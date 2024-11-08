//
//  ViewIdentity.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

protocol StoryboardInfo {
    static var storyboard: String { get }
    static var identifier: String { get }
}

protocol CellInfo {
    static var reuseIdentifier: String { get }
}
