//
//  Notes+CoreDataProperties.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 10.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageURL: String?
    @NSManaged public var noteId: String?
    @NSManaged public var title: String?
    @NSManaged public var userId: String?

}
