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
    
    init(word: String, definition: String? = nil){
        self.word = word
        self.definition = definition
    }
    
}
