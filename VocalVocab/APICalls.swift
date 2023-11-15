//
//  APICalls.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/11/23.
//

import Foundation
import UIKit

class APICalls {
    
    var words: [String] = []
    
    func fetchWords(completion: @escaping ([String]) -> Void) {
            let randomWordsURL = URL(string: "https://random-word-api.herokuapp.com/word?")!
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
    
   
    func fetchDefinition(for word: String, completion: @escaping (String?) -> Void) {
            let definitionURLString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        guard let definitionURL = URL(string: definitionURLString) else {
            completion(nil)
            return
        }
            
            let task = URLSession.shared.dataTask(with: definitionURL) { data, response, error in
                if let error = error {
                    print("Error fetching definition for word \(word): \(error.localizedDescription)")
                    return
                }
                guard let data = data else {
                    print("No data received from definition API")
                    completion(nil)
                    return
                }
                do {
                    // Decode the first meaning of the first entry for simplicity
                    if let entries = try? JSONDecoder().decode([DictionaryEntry].self, from: data),
                       let firstMeaning = entries.first?.meanings.first,
                       let definition = firstMeaning.definitions.first?.definition {
                        let definitionText = "The definition of \(word) is: \(definition)"
                        print(definitionText)
                        completion(definitionText)
                    } else {
                        print("Definition not found for word \(word)")
                        completion(nil)
                    }
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

    
