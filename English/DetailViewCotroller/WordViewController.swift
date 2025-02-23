//
//  WordListViewController.swift
//  English
//
//  Created by Bratkevich Pasha on 22.10.2022.
//

import UIKit

final class WordViewController: UICollectionViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    var word: Word {
        didSet {
            onChange(word)
        }
    }
    
    var workingWord: Word
    var isAddingNewWord = false
    var onChange: (Word)->Void
    
    private var dataSource: DataSource!
    
    init(word: Word, onChange: @escaping (Word) -> Void) {
        self.word = word
        self.workingWord = word
        self.onChange = onChange
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(collectionViewLayout: listLayout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize WordViewController using init(word:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        navigationItem.title = NSLocalizedString("Word \(word.anyWord)", comment: "English VC title")
        navigationItem.rightBarButtonItem = editButtonItem
        navigationController?.navigationBar.barTintColor = .black
        updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        } else {
            if !isAddingNewWord {
                prepareForViewing()
            } else {
                if workingWord.anyWord == "" { // НАЙТИ СЮДА ТЕКСТ ФИЛД
                            let errorAlert = UIAlertController(title: "Ooooops", message: "You haven't added any word", preferredStyle: .alert)
                            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
                            present(errorAlert, animated: true, completion: nil)
                } else {
                    onChange(workingWord)
                }
            }
        }
    }

    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let anyWord)):
            
            cell.contentConfiguration = headerConfiguration(for: cell, with: anyWord)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.anyWord, .editText(let anyWord, "1") ):
            cell.contentConfiguration = anyWordConfiguration(for: cell, with: anyWord!)
        case (.wordTranscription, .editText(let wordTranscription, "2") ):
            cell.contentConfiguration = wordTranscriptionConfiguration(for: cell, with: wordTranscription)
        case (.wordTranslation, .editText(let wordTranslation, "3") ):
            cell.contentConfiguration = wordTranslationConfiguration(for: cell, with: wordTranslation!)
        case (.exampleWithWord, .editText(let exampleWithWord, "4") ):
            cell.contentConfiguration = exampleWithWordConfiguration(for: cell, with: exampleWithWord)
        default:
            fatalError("Unexpected combination of section and row.")
        }
        
        cell.tintColor = .green
    }
    
    
    @objc func didCancelEdit() {
        workingWord = word
        setEditing(false, animated: true)
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        updateSnapshotForEditing()
    }
    
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.anyWord, .wordTranscription, .wordTranslation, .exampleWithWord])
        snapshot.appendItems([.header(Section.anyWord.name), .editText(word.anyWord, id: "1")], toSection: .anyWord)
        snapshot.appendItems([.header(Section.wordTranscription.name), .editText(word.wordTranscription, id: "2")], toSection: .wordTranscription)
        snapshot.appendItems([.header(Section.wordTranslation.name), .editText(word.wordTranslation, id: "3")], toSection: .wordTranslation)
        snapshot.appendItems([.header(Section.exampleWithWord.name), .editText(word.exampleWithWord, id: "4")], toSection: .exampleWithWord)
            dataSource.apply(snapshot)
    
    }
    
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        if workingWord != word {
            word = workingWord
        } else {
            
        }
        updateSnapshotForViewing()
    }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([.header(""), .viewAnyWord, .viewTranskription, .viewTranslation, .viewExample], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
