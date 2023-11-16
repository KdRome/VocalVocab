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
        
        nounDefinition.text = wordClass.definition
        
        verbDefinition.text = wordClass.definition

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var nounDefinition: UILabel!
    
    @IBOutlet weak var verbDefinition: UILabel!
    
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
