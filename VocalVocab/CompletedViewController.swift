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
        cell.definitionLabel?.text = "Definition: \(wordClass.nounDefinition ?? "No Definition Found")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            WordDataModel.shared.correctWords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            WordDataModel.shared.saveWords()
        }
    }

    var correctWords : [WordClass] {
        return WordDataModel.shared.correctWords
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        WordDataModel.shared.loadWords()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc func handleWordSubmission(_ notification: Notification) {
        if let wordClass = notification.userInfo?["word"] as? WordClass {
            WordDataModel.shared.correctWords.append(wordClass)
            tableView.reloadData()
        }
    }
}

extension Notification.Name {
    static let correctWordSubmitted = Notification.Name("correctWordSubmitted")
}
