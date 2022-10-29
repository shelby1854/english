//
//  WordListStyle.swift
//  English
//
//  Created by Bratkevich Pasha on 23.10.2022.
//

import Foundation


enum WordListStyle: Int {
    
    case newWord
    case memorized
    case allWord
    
    func shouldInclude() -> Bool {
        let isMemorized = Word.wordsSet.isLearnt
        
    }
}
