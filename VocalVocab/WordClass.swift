//
//  WordClass.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/11/23.
//

import Foundation

class WordClass {
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
}
