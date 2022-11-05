//
//  WordViewController+Row.swift
//  English
//
//  Created by Bratkevich Pasha on 22.10.2022.
//

import UIKit

extension WordViewController {
    
    enum Row: Hashable {
        case header(String)
        case viewAnyWord
        case viewTranslation
        case viewTranskription
        case viewExample
        case editText(String?, id: String)
        
        var imageName: String? {
            switch self {
                
            case .viewAnyWord: return "list.bullet.clipboard"
            case .viewTranskription: return "binoculars"
            case .viewTranslation: return "questionmark.square"
            default: return nil
                
            }
        }
        
        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .viewAnyWord: return .headline
            default: return .subheadline
            }
        }
    }
}

