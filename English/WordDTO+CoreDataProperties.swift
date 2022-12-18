//
//  WordDTO+CoreDataProperties.swift
//  English
//
//  Created by Bratkevich Pasha on 18.12.2022.
//
//

import Foundation
import CoreData


extension WordDTO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordDTO> {
        return NSFetchRequest<WordDTO>(entityName: "WordDTO")
    }

    @NSManaged public var id: String?
    @NSManaged public var anyWord: String?
    @NSManaged public var wordTranscription: String?
    @NSManaged public var wordTrancslation: String?
    @NSManaged public var exampleWithWord: String?
    @NSManaged public var isLearnt: Bool

}

extension WordDTO : Identifiable {

}
