//
//  Note+CoreDataProperties.swift
//  Note
//
//  Created by Сергей Моключенко on 24.03.2020.
//  Copyright © 2020 triare. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var noteId: Int64
    @NSManaged public var noteTitle: String?
    @NSManaged public var noteBody: String?
    @NSManaged public var createdDate: Date?

}
