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
    
        var currentWordClass: WordClass?
        let apiCalls = APICalls()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //configureAudioSession()
            fetchNewWord()
        }
        
        // Fetch a new word and its definition
    private func fetchNewWord() {
        apiCalls.fetchWords { [weak self] fetchedWords in
            guard let self = self, let newWord = fetchedWords.first else { return }
            let wordClass = WordClass(word: newWord)
            self.currentWordClass = wordClass
            print("Fetched and set new word: \(newWord)")
            self.fetchDefinition(for: newWord, wordClass: wordClass)
        }
    }

    private func fetchDefinition(for word: String, wordClass: WordClass) {
        apiCalls.fetchDefinition(for: word) { [weak self] definition in
            DispatchQueue.main.async {
                wordClass.definition = definition
                self?.currentWordClass?.definition = definition
                print("Fetched and set definition for \(word): \(definition ?? "None")")
            }
        }
    }
    
    // Configure the audio session for playback
    
    
    @IBAction func listentoWordButton(_ sender: UIButton) {
        if let word = currentWordClass?.word {
                print("Attempting to speak word: \(word)")
                //speakWord(word)
            } else {
                print("No word is currently set.")
            }
    }
    @IBAction func listenToDefinitionButton(_ sender: UIButton) {
        if let definition = currentWordClass?.definition {
            print("Attempting to speak definition: \(definition)")
            //speakWord(definition)
        } else {
            var errorText = "No Definiton is found for the word"
            print(errorText)
            //speakWord(errorText)
        }
    }
}
