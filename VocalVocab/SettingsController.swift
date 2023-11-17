//
//  SettingsController.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/17/23.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
    
    
    @IBOutlet weak var settingsTextField: UITextField!
    
    @IBAction func setSettingsButton(_ sender: UIButton) {
        // Update wordLength based on the textField's content
            if let text = settingsTextField.text, !text.isEmpty {
                APICalls.shared.wordLength = text
            } else {
                APICalls.shared.wordLength = "5" // Replace with your default length
            }
        print("Word Length set to: \(APICalls.shared.wordLength)")
    }
    
}
