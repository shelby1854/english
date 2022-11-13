//
//  WordListVC+DataSource.swift
//  English
//
//  Created by Bratkevich Pasha on 22.10.2022.
//

import UIKit


extension WordListVC {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Word.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Word.ID>
    
    var wordCompleteValue: String {
        NSLocalizedString("Completed", comment: "Word completed value")
    }
    
    var wordNotCompleteValue: String {
        NSLocalizedString("Not completed", comment: "Word not completed value")
    }
    
    func updateSnapshot(reloading ids: [Word.ID] = [], with words: [Word]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(currentWords.map { $0.id })

        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    
    @objc func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Word.ID) {
        
        let word = word(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = word.anyWord
        contentConfiguration.secondaryText = word.wordTranslation
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: word)
        doneButtonConfiguration.tintColor = .green
        cell.accessories = [ .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)]
        
        var backgoundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgoundConfiguration.backgroundColor = .clear
    }
    
    func completeWord(with id: Word.ID, with words: [Word]) {
        var word = word(for: id)
        word.isLearnt.toggle()
        update(word, with: id, with: currentWords)
        updateSnapshot(reloading: [id], with: currentWords)
    }
    
    private func doneButtonAccessibilityAction(for word: Word) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Word done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeWord(with: word.id, with: self!.currentWords)
            return true
        }
        return action
    }
    
    private func doneButtonConfiguration(for word: Word) -> UICellAccessory.CustomViewConfiguration{
        let symbolName = word.isLearnt ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = WordDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_ :)), for: .touchUpInside)
        button.id = word.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
       
    }
    
    func add(_ word: Word) {
        currentWords.append(word)
        currentWords.sort(by: { $0.anyWord < $1.anyWord } )
    }
    
    func deleteWord(with id: Word.ID) {
        let index = currentWords.indexOfWord(with: id)
        currentWords.remove(at: index)
    }
    
    func word(for id: Word.ID) -> Word {
        let index = currentWords.indexOfWord(with: id)
        return currentWords[index]
    }
    
    func update(_ word: Word, with id: Word.ID, with words: [Word]) {
        let index = currentWords.indexOfWord(with: id)
        currentWords[index] = word
    }
}
