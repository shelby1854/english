//
//  WordViewController+Sections.swift
//  English
//
//  Created by Bratkevich Pasha on 22.10.2022.
//

import Foundation

extension WordViewController {
    
    enum Section: Int, Hashable {
        case view
        case anyWord
        case wordTranscription
        case wordTranslation
        case exampleWithWord
        
        var name: String {
            switch self {
            case .view: return ""
            case .anyWord:
                return NSLocalizedString("Word", comment: "Title section name")
            case .wordTranscription:
                return NSLocalizedString("Transcription", comment: "Transcription section name")
            case .wordTranslation:
                return NSLocalizedString("Translation", comment: "Translation section name")
            case .exampleWithWord:
                return NSLocalizedString("Example", comment: "Example section name")
            }
        }
    }
}


