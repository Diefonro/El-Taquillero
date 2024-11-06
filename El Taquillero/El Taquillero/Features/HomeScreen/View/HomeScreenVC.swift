//
//  HomeScreenVC.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

class HomeScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "HomeScreen"
    static var identifier = "HomeScreenVC"

    @IBOutlet weak var label: UILabel!
    
    let testText = String(localized: "TestPhrase")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = testText
    }
    
    func setupVIPER() {
        print("on it")
    }
    
}
