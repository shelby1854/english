//
//  WordListVC + SegmentedControl.swift
//  English
//
//  Created by Bratkevich Pasha on 06.11.2022.
//

import UIKit

extension WordListVC {
    
    @objc func changeSelection(sender: UISegmentedControl) {
        currentSegmentedIndex = sender.selectedSegmentIndex

        switch sender.selectedSegmentIndex {
        case 0:
            updateSnapshot(with: allWordsInApp)
            print(allWordsInApp)
        case 1:
            newWords = allWordsInApp
                .sorted(by: { $0.anyWord < $1.anyWord })
                .filter { !$0.isLearnt }
            updateSnapshot(with: newWords)
            print(newWords)
        case 2:
            learnedWords = allWordsInApp
                .sorted(by: { $0.anyWord < $1.anyWord })
                .filter { $0.isLearnt }
            updateSnapshot(with: learnedWords)
            print(learnedWords)
        default:
            break
        }
    }
}
