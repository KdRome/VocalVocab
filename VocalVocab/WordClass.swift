//
//  WordClass.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/11/23.
//

import Foundation

class WordClass: Codable {
    let word: String
    var nounDefinition: String?
    var verbDefinition: String?
    
    init(word: String, nounDefinition: String? = nil, verbDefinition: String? = nil){
        self.word = word
        self.nounDefinition = nounDefinition
        self.verbDefinition = verbDefinition
    }
    
}

class WordDataModel {
    static let shared = WordDataModel()
    var correctWords: [WordClass] = []
    
    func saveWords() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(correctWords) {
            UserDefaults.standard.set(encoded, forKey: "SavedWords")
        }
    }
    
    func loadWords() {
        if let savedWords = UserDefaults.standard.object(forKey: "SavedWords") as? Data {
            let decoder = JSONDecoder()
            if let loadedWords = try? decoder.decode([WordClass].self, from: savedWords) {
                correctWords = loadedWords
            }
        }
    }
}
