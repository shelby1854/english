//
//  ViewController.swift
//  English
//
//  Created by Bratkevich Pasha on 16.10.2022.
//

import UIKit

final class WordListVC: UICollectionViewController {
  
    var dataSource: DataSource!
    var words: [Word] = Word.wordsSet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        words = words.sorted(by: { $0.anyWord < $1.anyWord })
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)

        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Word.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
      
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add word", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        
        updateSnapshot()
        collectionView.dataSource = dataSource
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = words[indexPath.item].id
        showDetail(for: id)
        return false
    }
    
    
    func showDetail(for id: Word.ID) {
        let word = word(for: id)
        let viewController = WordViewController(word: word) { [weak self] word in
            self?.update(word, with: word.id)
            self?.updateSnapshot(reloading: [word.id])
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
 
  private func listLayout() -> UICollectionViewCompositionalLayout {
      var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
      listConfiguration.showsSeparators = false
      listConfiguration.backgroundColor = .clear
      listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
      
      return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
    }

    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            self?.deleteWord(with: id)
            self?.updateSnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

