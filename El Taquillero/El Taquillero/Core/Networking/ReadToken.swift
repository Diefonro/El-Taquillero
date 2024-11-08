//
//  ReadToken.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import Foundation

class ReadToken {
    static func readBearerToken() -> String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path) as? [String: Any],
              let token = plist["API_BEARER_TOKEN"] as? String else {
            fatalError("Bearer token not found in Config.plist")
        }
        return token
    }
}
