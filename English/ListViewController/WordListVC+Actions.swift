//
//  WordListVC+Actions.swift
//  English
//
//  Created by Bratkevich Pasha on 22.10.2022.
//

import UIKit

extension WordListVC {
    
    @objc func didPressDoneButton(_ sender: WordDoneButton) {
        guard let id = sender.id else { return }
        completeWord(with: id)
        
    }
    
    @objc func didPressAddButton(_ sender: UIBarButtonItem) {
        let word = Word(anyWord: "", wordTranscription: "", wordTranslation: "")
        let viewController = WordViewController(word: word) { [weak self] word in
            self?.add(word)
            self?.updateSnapshot()
            self?.dismiss(animated: true)
        }
        
        viewController.isAddingNewWord = true
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
        viewController.navigationItem.title = "Add word"
        viewController.navigationItem.titleView?.backgroundColor = .black
        viewController.navigationItem.titleView?.tintColor = .green
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
    
    @objc func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    
}
