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
            allWords = allWords.sorted(by: { $0.anyWord < $1.anyWord })
            updateSnapshot(with: currentWords)
        case 1:
            newWords = newWords.sorted(by: { $0.anyWord < $1.anyWord })
            updateSnapshot(with: currentWords)
        case 2:
            learnedWords = learnedWords.sorted(by: { $0.anyWord < $1.anyWord })
            updateSnapshot(with: currentWords)
        default:
            break
        }
    }
}
