//
//  HTTPRequest.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import Foundation

protocol HTTPRequest {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension HTTPRequest {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            urlRequest.httpBody = body
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            print("* * * * * * * * * ")
            urlRequest.printFullRequest()
            print("* * * * * * * * * ")
            print("Response: \(httpResponse)")
            print("JSON DATA: \(String(data: data, encoding: .utf8) ?? "")")

            switch httpResponse.statusCode {
            case 200...299:
                if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                    return .success(decodedResponse)
                } else {
                    return .failure(.decode)
                }
            case 401:
                return .failure(.unauthorized)
            default:
                print("Response status code: \(httpResponse.statusCode)")
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}


extension URLRequest {
    func printFullRequest() {
        let method = self.httpMethod ?? ""
        let url = self.url ?? URL(string: "")!
        print("\n\(method) : \(url)")
        if let headers = self.allHTTPHeaderFields {
            print("\nHEADERS :")
            for (key, value) in headers {
                print("\n\(key) : \(value)")
            }
        }

        if let body = String(data: self.httpBody ?? Data(), encoding: .utf8) {
            print("\nBODY : \(body) \n")
        }
    }
}

