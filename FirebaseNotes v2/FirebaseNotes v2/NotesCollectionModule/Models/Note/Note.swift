//
//  Note.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation
import Firebase

class Note: Equatable {
    
    var title: String
    var body: String
    var imageURL: String
    var imageData: Data?
    var date: String
    var noteId: String
    var userId: String
    var ref: DatabaseReference?
    
    init(title: String, body: String, imageURL: String, imageData: Data?, date: String, noteId: String, userId: String) {
        
        self.title = title
        self.body = body
        self.imageURL = imageURL
        self.imageData = imageData
        self.date = date
        self.noteId = noteId
        self.userId = userId
        //self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String : AnyObject]
        self.title = snapshotValue["title"] as! String
        self.body = snapshotValue["body"] as! String
        self.imageURL = snapshotValue["imageURL"] as! String
        self.date = snapshotValue["date"] as! String
        self.noteId = snapshotValue["noteId"] as! String
        self.userId = snapshotValue["userId"] as! String
        self.ref = snapshot.ref
    }
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.noteId == rhs.noteId
    }
    
    func convertToDictionary() -> Any {
        
        return ["title" : title, "body" : body, "imageURL" : imageURL, "date" : date, "noteId" : noteId, "userId" : userId]
    }
    
    func entityToObject(model: Notes) {
        
        self.title = model.title ?? ""
        self.body = model.body ?? ""
        self.imageURL = model.imageURL ?? ""
        self.imageData = model.imageData ?? Data()
        self.date = model.date ?? ""
        self.noteId = model.noteId ?? ""
        self.userId = model.userId ?? ""
    }

    func objectToEntity(model: Notes) -> Notes {
        
        model.title = title.self
        model.body = body.self
        model.imageURL = imageURL.self
        model.imageData = imageData.self
        model.date = date.self
        model.noteId = noteId.self
        model.userId = userId.self

        return model
    }
}
