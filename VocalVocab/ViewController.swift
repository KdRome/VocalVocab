//
//  ViewController.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/10/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //AVSpeechSynthesizer()
    private let synthesizer = AVSpeechSynthesizer()
    // Function to handle text-to-speech
    func speakWord(_ word: String) {
        let utterance = AVSpeechUtterance(string: word)
        synthesizer.speak(utterance)
    }
    
        var currentWordClass: WordClass?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // configureAudioSession() prob dont actually need this function
            
            fetchNewWord()
        }
        
        // Fetch a new word and its definition
    private func fetchNewWord() {
        APICalls.shared.fetchWords { [weak self] fetchedWords in
            guard let self = self, let newWord = fetchedWords.first else { return }
            let wordClass = WordClass(word: newWord)
            self.currentWordClass = wordClass
            print("Fetched and set new word: \(newWord)")
            self.fetchDefinitions(for: newWord, wordClass: wordClass)
            //speakWord(newWord)
        }
    }

    private func fetchDefinitions(for word: String, wordClass: WordClass) {
        APICalls.shared.fetchDefinitions(for: word) { [weak self] (fetchedWordClass, hasDefinition) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                if !hasDefinition {
                    print("No definitions found for \(word). Fetching a new word.")
                    strongSelf.fetchNewWord() // Implement fetchNewWord to get a new word
                } else {
                    // Update the current wordClass with the fetched definitions
                    self?.speakWord(word)
                    wordClass.nounDefinition = fetchedWordClass.nounDefinition
                    wordClass.verbDefinition = fetchedWordClass.verbDefinition

                    // Update the current wordClass in the ViewController
                    strongSelf.currentWordClass = wordClass

                    print("Fetched definitions for \(word): Noun - \(fetchedWordClass.nounDefinition ?? "None"), Verb - \(fetchedWordClass.verbDefinition ?? "None")")
                }
            }
        }
    }

    // Configure the audio session for playback
    // (prob dont actually need this function)
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up the audio session: \(error)")
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
        //debugging tests ( delete later )
        //---------------------------------------------------------
        print("User Spelling: \(userSpelling)")
        print("Correct Spelling: \(correctSpelling ?? "nil")")
        //---------------------------------------------------------
        if userSpelling == correctSpelling {
            if let correctWord = currentWordClass {
                NotificationCenter.default.post(name: .correctWordSubmitted, object: nil, userInfo: ["word": correctWord])
                WordDataModel.shared.saveWords()
            }
            fetchNewWord()
            speakWord("Correct")
            print("Correct spelling!")
        } else {
            speakWord("Incorrect")
            print("Incorrect spelling.")
        }
    }
}
