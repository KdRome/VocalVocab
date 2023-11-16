//
//  WordClass.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/11/23.
//

import Foundation

class WordClass {
    let word: String
    var definition: String?
    var nounDefinition: String?
    var verbDefinition: String?
    
    init(word: String, definition: String? = nil, nounDefinition: String? = nil, verbDefinition: String? = nil){
        self.word = word
        self.definition = definition
        self.nounDefinition = nounDefinition
        self.verbDefinition = verbDefinition
    }
    
}
