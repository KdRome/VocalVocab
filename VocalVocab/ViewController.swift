//
//  ViewController.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/10/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speakWord(_ word: String) {
        let utterance = AVSpeechUtterance(string: word)
        synthesizer.speak(utterance)
    }
    
        var currentWordClass: WordClass?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchNewWord()
        }
        
        // Fetch a new word and its definition
    private func fetchNewWord() {
        APICalls.shared.fetchWords { [weak self] fetchedWords in
            guard let self = self, let newWord = fetchedWords.first else { return }
            let wordClass = WordClass(word: newWord)
            self.currentWordClass = wordClass
            self.fetchDefinitions(for: newWord, wordClass: wordClass)
        }
    }

    private func fetchDefinitions(for word: String, wordClass: WordClass) {
        APICalls.shared.fetchDefinitions(for: word) { [weak self] (fetchedWordClass, hasDefinition) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                if !hasDefinition {
                    //print("No definitions found for \(word). Fetching a new word.")
                    strongSelf.fetchNewWord()
                } else {
                    self?.speakWord(word)
                    wordClass.nounDefinition = fetchedWordClass.nounDefinition
                    wordClass.verbDefinition = fetchedWordClass.verbDefinition
                    strongSelf.currentWordClass = wordClass
                }
            }
        }
    }
    @IBAction func listentoWordButton(_ sender: UIButton) {
        if let word = currentWordClass?.word {
                print("Attempting to speak word: \(word)")
                speakWord(word)
            } else {
                print("No word is currently set.")
            }
    }
    @IBAction func listenToDefinitionButton(_ sender: UIButton) {
        if currentWordClass?.nounDefinition == nil {
            if let definition = currentWordClass?.verbDefinition {
                print("Attempting to speak definition: \(definition)")
                speakWord(definition)
            }
        }
        else if let definition = currentWordClass?.nounDefinition {
            print("Attempting to speak definition: \(definition)")
            speakWord(definition)
        } else {
            let errorText = "No Definition is found for the word"
            print(errorText)
            speakWord(errorText)
        }
    }
    
    @IBOutlet weak var userInputTextField: UITextField!
    @IBAction func submitButton(_ sender: UIButton) {
        let userSpelling = userInputTextField?.text?.lowercased() ?? ""
        let correctSpelling = currentWordClass?.word.lowercased()
        
        if userSpelling == correctSpelling {
            if let correctWord = currentWordClass {
                NotificationCenter.default.post(name: .correctWordSubmitted, object: nil, userInfo: ["word": correctWord])
                WordDataModel.shared.saveWords()
            }
            fetchNewWord()
            speakWord("Correct")
        } else {
            speakWord("Incorrect")
        }
    }
}
