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
            words = Word.wordsSet.sorted(by: { $0.anyWord < $1.anyWord })
            updateSnapshot()
        case 1:
            words = Word.wordsSet.sorted(by: { $0.anyWord < $1.anyWord })
            words = Word.wordsSet.filter( {!$0.isLearnt })
            updateSnapshot()
        case 2:
            words = Word.wordsSet.sorted(by: { $0.anyWord < $1.anyWord })
            words = Word.wordsSet.filter( {$0.isLearnt })
            updateSnapshot()
        default:
            break
        }
    }
}
