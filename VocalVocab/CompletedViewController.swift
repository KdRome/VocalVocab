//
//  CompletedViewController.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/10/23.
//

import UIKit

class CompletedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return correctWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Cell", for: indexPath) as? CompleteCell else {
            return UITableViewCell()
        }
        
        let wordClass = correctWords[indexPath.row]
        cell.wordLabel?.text = "Word: \(wordClass.word)"
        cell.definitionLabel?.text = "Definition: \(wordClass.definition ?? "No Definition Found")"
        return cell
    }
    
    var correctWords: [WordClass] = []
    
    func addWord(_ word: WordClass) {
        correctWords.append(word)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let selectedWord = correctWords[selectedIndexPath.row]
        
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.wordClass = selectedWord
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleWordSubmission(_:)), name: .correctWordSubmitted, object: nil)
        tableView.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc func handleWordSubmission(_ notification: Notification) {
        if let wordClass = notification.userInfo?["word"] as? WordClass {
            addWord(wordClass)
            tableView.reloadData()
        }
    }
}

extension Notification.Name {
    static let correctWordSubmitted = Notification.Name("correctWordSubmitted")
}
