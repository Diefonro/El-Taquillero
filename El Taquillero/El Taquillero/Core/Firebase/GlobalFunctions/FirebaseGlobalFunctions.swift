//
//  FirebaseGlobalFunctions.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit
import FirebaseAuth

class FirebaseGlobalFunctions {
    
    static func signUpUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("User signed up successfully"))
            }
        }
    }
    
    static func loginUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("User logged in successfully"))
            }
        }
    }
    
    static func resetPassword(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Password reset email sent"))
            }
        }
    }
    
    static func handleAuthError(_ error: Error) -> (FirebaseAuthErrorType, AuthErrorCode?) {
        let authError = error as NSError
        guard let errorCode = AuthErrorCode(rawValue: authError.code) else {
            return (.unknown, nil)
        }
        return (FirebaseAuthErrorType(authErrorCode: errorCode), errorCode)
    }
    
    static func sendVerificationEmail(completion: @escaping (Result<String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "FirebaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is logged in."])))
            return
        }
        
        currentUser.sendEmailVerification { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Verification email sent"))
            }
        }
    }
    
    static func checkEmailVerification(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        if user.isEmailVerified {
            completion(true)
        } else {
            completion(false)
        }
    }

}

enum FirebaseAuthErrorType: String {
    case invalidEmail = "The email address is badly formatted."
    case invalidCredential = "The supplied auth credential is malformed or has expired."
    case wrongPassword = "The password is invalid or the user does not have a password."
    case unknown
    
    init(authErrorCode: AuthErrorCode) {
        switch authErrorCode {
        case .invalidEmail:
            self = .invalidEmail
        case .wrongPassword:
            self = .wrongPassword
        case .invalidCredential:
            self = .invalidCredential
        default:
            self = .unknown
        }
    }
}

