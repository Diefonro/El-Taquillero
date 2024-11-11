//
//  UserDefaults+SessionExtension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 11/11/2024.
//

import UIKit

extension UserDefaults {
    enum Keys {
        static let isLoggedIn = "isLoggedIn"
        static let currentUserEmail = "currentUserEmail"
    }
    
    static func setLoggedIn(_ isLoggedIn: Bool, email: String? = nil) {
        UserDefaults.standard.set(isLoggedIn, forKey: .init(Keys.isLoggedIn))
        
        if let email = email {
            UserDefaults.standard.set(email, forKey: Keys.currentUserEmail)
        } else {
            UserDefaults.standard.removeObject(forKey: Keys.currentUserEmail)
        }
    }
    
    static func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
    }
    
    static func currentUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: Keys.currentUserEmail)
    }
}
