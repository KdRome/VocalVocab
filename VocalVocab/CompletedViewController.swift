//
//  CompletedViewController.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/10/23.
//

import UIKit

class CompletedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Cell", for: indexPath) as? CompleteCell else {
            return UITableViewCell()
        }
        
        let words = array[indexPath.row]
        
        cell.wordLabel?.text = words
        cell.definitionLabel?.text = words
        
        
        return cell
    }
    
    
    var array = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        array.append("Hello")
        array.append("Goodbye")
        array.append("Testing")
        
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
}
