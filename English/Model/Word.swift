//
//  Word.swift
//  English
//
//  Created by Bratkevich Pasha on 16.10.2022.
//

import Foundation

class Word: Equatable, Identifiable {
    
    var id: String
    var anyWord: String
    var wordTranscription: String?
    var wordTranslation: String
    var exampleWithWord: String?
    var isLearnt: Bool

    init(id: String = UUID().uuidString, anyWord: String, wordTranscription: String? = nil, wordTranslation: String, exampleWithWord: String? = nil, isLearnt: Bool = false) {
        self.id = id
        self.anyWord = anyWord
        self.wordTranscription = wordTranscription
        self.wordTranslation = wordTranslation
        self.exampleWithWord = exampleWithWord
        self.isLearnt = isLearnt
    }

    static func == (lhs: Word, rhs: Word) -> Bool {
        lhs.id == rhs.id
    }
}

extension Array where Element == Word {
    func indexOfWord(with id: Word.ID) -> Self.Index {
        
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}
