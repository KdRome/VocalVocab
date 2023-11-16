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
        let apiCalls = APICalls()
        
        override func viewDidLoad() {
            super.viewDidLoad()
           // configureAudioSession() prob dont actually need this function
            fetchNewWord()
            if let word = currentWordClass?.word {
                speakWord(word)
            }
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
        if let definition = currentWordClass?.definition {
            print("Attempting to speak definition: \(definition)")
            speakWord(definition)
        } else {
            let errorText = "No Definition is found for the word"
            print(errorText)
            speakWord(errorText)
        }
    }
    
    @IBOutlet weak var userInputTextField: UITextField!
    
    
    var completedViewTable: CompletedViewController?
    
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
