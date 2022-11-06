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
   static  var allWordsInApp = [
        Word(anyWord: "Hello", wordTranscription: "Хеллоу", wordTranslation: "Привет", exampleWithWord: "Hello, I am Pasha", isLearnt: true),
        Word(anyWord: "Apple", wordTranscription: "Эпл", wordTranslation: "Яблоко", exampleWithWord: "Give me an apple", isLearnt: true),
        Word(anyWord: "Exhausted", wordTranslation: "Изнеможенный, истощенный", isLearnt: false),
        Word(anyWord: "Breast", wordTranscription: "брэст", wordTranslation: "Грудь", isLearnt: false),
        Word(anyWord: "Bye", wordTranscription: "Бай", wordTranslation: "Пока", exampleWithWord: "Bye-bye, motherfucker", isLearnt: true),
        Word(anyWord: "Test", wordTranscription: "Тэст", wordTranslation: "Тест"),
        Word(anyWord: "Will", wordTranscription: "Vil", wordTranslation: "Воля", exampleWithWord: "He has no will of his own"),
        Word(anyWord: "After", wordTranscription: "Afte", wordTranslation: "После", exampleWithWord: "He came after you left"),
        Word(anyWord: "Need", wordTranscription: "Nid", wordTranslation: "Нужда", exampleWithWord: "I need to buy those things"),
        Word(anyWord: "People", wordTranslation: "Люди", exampleWithWord: "People like believing in something"),
        Word(anyWord: "Way", wordTranslation: "Путь, способ", exampleWithWord: "You have to find the right way"),
        Word(anyWord: "Would", wordTranslation: "Бы", exampleWithWord: "I would not bought it"),
        Word(anyWord: "Approach", wordTranslation: "Подход", exampleWithWord: "I dont like your approach to this deal"),
        Word(anyWord: "Soil", wordTranslation: "Почва", exampleWithWord: "Soil is still wet"),
        Word(anyWord: "Lack", wordTranslation: "Недостаток", exampleWithWord: "Lack of evidence"),
        Word(anyWord: "Advantage", wordTranscription: "Advantidj", wordTranslation: "Преимущество, выгода", exampleWithWord: "He has a small advantage"),
        

    ]

}
 

