//
//  Word.swift
//  English
//
//  Created by Bratkevich Pasha on 16.10.2022.
//

import Foundation


struct Word: Equatable, Identifiable {
    
    var id: String = UUID().uuidString
    var anyWord: String
    var wordTranscription: String?
    var wordTranslation: String
    var exampleWithWord: String?
    var isLearnt: Bool = false
}

extension Array where Element == Word {
    
    func indexOfWord(with id: Word.ID) -> Self.Index {
        
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
    
}



extension Word {
   static  var wordsSet = [
        Word(anyWord: "Hello", wordTranscription: "Хеллоу", wordTranslation: "Привет", exampleWithWord: "Hello, I am Pasha", isLearnt: true),
        Word(anyWord: "Apple", wordTranscription: "Эпл", wordTranslation: "Яблоко", exampleWithWord: "Give me an apple", isLearnt: true),
        Word(anyWord: "Exhausted", wordTranslation: "Изнеможенный, истощенный", isLearnt: false),
        Word(anyWord: "Breast", wordTranscription: "брэст", wordTranslation: "Грудь", isLearnt: false),
        Word(anyWord: "Bye", wordTranscription: "Бай", wordTranslation: "Пока", exampleWithWord: "Bye-bye, motherfucker", isLearnt: true),
        Word(anyWord: "Test", wordTranscription: "тэст", wordTranslation: "тест")
    ]

}
 

