//
//  FirebaseGlobalFunctions.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 10/11/2024.
//

import UIKit
import FirebaseAuth

class FirebaseGlobalFunctions {
    
    static func signUpUser(name: String, surname: String, phone: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                SessionCRUDFunctions.shared.saveUser(name: name, surname: surname, phone: phone, email: email)
                if let userEntity = SessionCRUDFunctions.shared.fetchUser(withEmail: email) {
                
                    
                    completion(.success("User signedUp in successfully with name: \(userEntity.name ?? "") and email: \(userEntity.email ?? "")"))
                } else {
                    completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User data not found in Core Data."])))
                }
                
                completion(.success("User signed up successfully"))
            }
        }
    }
    
    static func loginUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let isEmailVerified = Auth.auth().currentUser?.isEmailVerified, isEmailVerified {
                    UserDefaults.setLoggedIn(true, email: email)
                    
                    if let userEntity = SessionCRUDFunctions.shared.fetchUser(withEmail: email) {
                    
                        
                        completion(.success("User logged in successfully with name: \(userEntity.name ?? "") and email: \(userEntity.email ?? "")"))
                    } else {
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User data not found in Core Data."])))
                    }
                    
                    completion(.success(("User logged in successfully")))
                } else {
                    completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Email not verified."])))
                }
            }
        }
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
        Auth.auth().currentUser?.reload { error in
            if let user = Auth.auth().currentUser, user.isEmailVerified {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func logOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.setLoggedIn(false)
            completion(.success(()))
        } catch let signedOutError {
            completion(.failure(signedOutError))
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
}

