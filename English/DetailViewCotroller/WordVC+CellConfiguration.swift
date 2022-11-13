//
//  WordVC+CellConfiguration.swift
//  English
//
//  Created by Bratkevich Pasha on 23.10.2022.
//

import UIKit

extension WordViewController {
    
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func anyWordConfiguration(for cell: UICollectionViewListCell, with anyWord: String) -> TextFieldContentView.Configuration {
        
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = anyWord
        contentConfiguration.onChange = { [weak self] anyWord in
            self?.workingWord.anyWord = anyWord
        }
        return contentConfiguration
    }
    
    func wordTranscriptionConfiguration(for cell: UICollectionViewListCell, with wordTranscription: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = wordTranscription
        contentConfiguration.onChange = { [weak self] wordTranscription in
            self?.workingWord.wordTranscription = wordTranscription
        }
        return contentConfiguration
    }
    
    func wordTranslationConfiguration(for cell: UICollectionViewListCell, with wordTranslation: String) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = wordTranslation
        contentConfiguration.onChange = { [weak self] wordTranslation in
            self?.workingWord.wordTranslation = wordTranslation
        }
        return contentConfiguration
    }
    
    func exampleWithWordConfiguration(for cell: UICollectionViewListCell, with exampleWithWord: String?) -> TextViewContentView.Configuration {
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = exampleWithWord
        contentConfiguration.onChange = { [weak self] exampleWithWord in
            self?.workingWord.exampleWithWord = exampleWithWord
        }
        return contentConfiguration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .viewAnyWord: return word.anyWord
        case .viewTranskription: return word.wordTranscription
        case .viewTranslation: return word.wordTranslation
        case .viewExample: return word.exampleWithWord
        default: return nil
        }
    }
}

