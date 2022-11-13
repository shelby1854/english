//
//  WordListVC + SegmentedControl.swift
//  English
//
//  Created by Bratkevich Pasha on 06.11.2022.
//

import UIKit

extension WordListVC {
    
    @objc func changeSelection(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            currentWords = Word.allWordsInApp.sorted(by: { $0.anyWord < $1.anyWord })
            updateSnapshot(with: currentWords)
            print(currentWords)
        case 1:
            newWords = currentWords.sorted(by: { $0.anyWord < $1.anyWord }).filter({!$0.isLearnt})
            updateSnapshot(with: newWords)
            print(newWords)
        case 2:
            learnedWords = currentWords.sorted(by: { $0.anyWord < $1.anyWord }).filter({$0.isLearnt})
            updateSnapshot(with: learnedWords)
            print(learnedWords)
        default:
            break
        }
    }
}
