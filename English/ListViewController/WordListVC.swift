//
//  ViewController.swift
//  English
//
//  Created by Bratkevich Pasha on 16.10.2022.
//

import UIKit

enum CurrentType {
    case all
    case new
    case learnt
}

final class WordListVC: UICollectionViewController {

    var type: CurrentType = .all

    var dataSource: DataSource!
    var newWords: [Word] = []
    var learnedWords: [Word] = []
    var allWordsInApp = [
        Word(anyWord: "Hello", wordTranscription: "Хеллоу", wordTranslation: "Привет", exampleWithWord: "Hello, I am Pasha"),
        Word(anyWord: "Apple", wordTranscription: "Эпл", wordTranslation: "Яблоко", exampleWithWord: "Give me an apple"),
        Word(anyWord: "Exhausted", wordTranslation: "Изнеможенный, истощенный"),
        Word(anyWord: "Breast", wordTranscription: "брэст", wordTranslation: "Грудь"),
        Word(anyWord: "Bye", wordTranscription: "Бай", wordTranslation: "Пока", exampleWithWord: "Bye-bye, motherfucker"),
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
    ].sorted(by: { $0.anyWord < $1.anyWord })

    var currentSegmentedIndex: Int = 0
    var currentWords: [Word] {

        switch currentSegmentedIndex {
        case 0:
            type = .all
            return allWordsInApp
        case 1:
            type = .new
            return newWords
        case 2:
            type = .learnt
            return learnedWords
        default:
            type = .all
            return allWordsInApp
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titlesSC = ["All", "New", "Learned"]
        let isLearnSC = UISegmentedControl(items: titlesSC)
        isLearnSC.backgroundColor = .systemGreen
        isLearnSC.selectedSegmentIndex = 0
        self.navigationItem.titleView = isLearnSC
        isLearnSC.addTarget(self, action: #selector(changeSelection), for: UIControl.Event.valueChanged)
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Word.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add word", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        self.navigationController?.navigationBar.barTintColor = .black
        updateSnapshot(with: allWordsInApp)
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = allWordsInApp[indexPath.item].id
        showDetail(for: id)
        return false
    }
    
    
    func showDetail(for id: Word.ID) {
        let word = word(for: id)
        let viewController = WordViewController(word: word) { [weak self] word in
            self?.update(word, with: word.id, with: self!.allWordsInApp)
            self?.updateSnapshot(with: self!.allWordsInApp)
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            self?.deleteWord(with: id)
            self?.updateSnapshot(with: self!.allWordsInApp)
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

