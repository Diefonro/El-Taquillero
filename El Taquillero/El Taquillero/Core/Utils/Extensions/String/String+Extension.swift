//
//  String+Extension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

extension String {
    func toDate(withFormats formats: [String] = ["yyyy-MM-dd", "dd/MM/yyyy HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", "yyyy-MM-dd'T'HH:mm:ss'Z'"]) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        for format in formats {
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }
        return nil
    }
    
    //MARK: TextField validation functions
    
    func validateAlphabeticRequirement() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-ZÀ-ÿ\\u00f1\\u00d1]*(\\s*[a-zA-ZÀ-ÿ\\u00f1\\u00d1]*)*[a-zA-ZÀ-ÿ\\u00f1\\u00d1]+$")
        return regex.evaluate(with: self)
    }
    
    func validateAsEmail() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", "[a-z0-9A-Z]+(?:[\\.\\-\\_][A-Za-z0-9]+)*(?:[\\.|\\-|\\_])?@[A-Za-z0-9]+(\\.[a-z]{2,3})(\\.[a-z]{2})?")
        return regex.evaluate(with: self)
    }
    
    func validateMinimunEightCharactersRequirement() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", ".{8,}")
        return regex.evaluate(with: self)
    }
    
    func validateMinimunOneNumberRequirement() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", ".*[0-9].*")
        return regex.evaluate(with: self)
    }
    
    func validateSpecialCharacterRequirement() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", ".*[!@#$%^&*(),.?\":{}|<>].*")
        return regex.evaluate(with: self)
    }
    
    func validateUppercaseLetterRequirement() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z].*")
        return regex.evaluate(with: self)
    }

    func validateLowercaseLetterRequirement() -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", ".*[a-z].*")
        return regex.evaluate(with: self)
    }
}

