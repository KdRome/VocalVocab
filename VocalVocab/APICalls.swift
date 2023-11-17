//
//  APICalls.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/11/23.
//

import Foundation
import UIKit

class APICalls {
    
    static let shared = APICalls()
    var words: [String] = []
    var wordLength: String = "6"
    
    private init() {}
    
    func fetchWords(completion: @escaping ([String]) -> Void) {
        print("Fetching words of length: \(wordLength)")
            let randomWordsURL = URL(string: "https://random-word-api.herokuapp.com/word?length=\(wordLength)")!
            let task = URLSession.shared.dataTask(with: randomWordsURL) { data, response, error in
                if let error = error {
                    print("Error fetching words: \(error.localizedDescription)")
                    completion([])
                    return
                }
                guard let data = data else {
                    print("No data received from word API")
                    completion([])
                    return
                }
                do {
                    let words = try JSONDecoder().decode([String].self, from: data)
                    completion(words)
                } catch {
                    print("JSON Decoding Error: \(error.localizedDescription)")
                    completion([])
                }
            }
            task.resume()
    }
    
    func fetchDefinitions(for word: String, completion: @escaping (WordClass, Bool) -> Void) {
        let definitionURLString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        guard let definitionURL = URL(string: definitionURLString) else {
            completion(WordClass(word: word), false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: definitionURL) { data, response, error in
            if let error = error {
                print("Error fetching definition for word \(word): \(error.localizedDescription)")
                completion(WordClass(word: word), false)
                return
            }
            guard let data = data else {
                print("No data received from definition API")
                completion(WordClass(word: word), false)
                return
            }
            do {
                let entries = try JSONDecoder().decode([DictionaryEntry].self, from: data)
                var nounDefinition: String?
                var verbDefinition: String?

                for entry in entries {
                    for meaning in entry.meanings {
                        if meaning.partOfSpeech == "noun", let definition = meaning.definitions.first?.definition {
                            nounDefinition = definition
                        } else if meaning.partOfSpeech == "verb", let definition = meaning.definitions.first?.definition {
                            verbDefinition = definition
                        }
                    }
                }

                let hasDefinition = nounDefinition != nil || verbDefinition != nil
                let wordClass = WordClass(word: word, nounDefinition: nounDefinition, verbDefinition: verbDefinition)
                completion(wordClass, hasDefinition)
            } catch {
                print("Error decoding definition for word \(word): \(error)")
                completion(WordClass(word: word), false)
            }
        }
        task.resume()
    }


}

    struct DictionaryEntry: Decodable {
        let word: String
        let meanings: [Meaning]
    }

    struct Meaning: Decodable {
        let partOfSpeech: String
        let definitions: [Definition]
    }

    struct Definition: Decodable {
        let definition: String
    }
