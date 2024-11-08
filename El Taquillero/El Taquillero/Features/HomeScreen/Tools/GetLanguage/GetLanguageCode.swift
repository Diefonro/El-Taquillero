//
//  GetLanguageCode.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 08/11/2024.
//

import UIKit

class LanguageCode {
    func getLanguageCode() -> String {
        let currentLanguageCode = Locale.current.language.languageCode?.identifier
        
        switch currentLanguageCode {
        case "es":
            return "es-ES"
        case "en":
            return "en-US"
        default:
            return "en-US"
        }
    }
}
