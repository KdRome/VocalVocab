//
//  DetailViewController.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/15/23.
//

import UIKit

class DetailViewController: UIViewController {

    var wordClass: WordClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordLabel.text = wordClass.word
        nounDefinition.text = wordClass.nounDefinition
        verbDefinition.text = wordClass.verbDefinition
    }
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var nounDefinition: UILabel!
    @IBOutlet weak var verbDefinition: UILabel!
}
