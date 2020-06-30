//
//  NoteModel.swift
//  Note
//
//  Created by Сергей Моключенко on 24.03.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation

class NoteModel {
    
    var noteId: Int
    var createdDate: Date
    var noteTitle: String
    var noteBody: String
    
    init(noteId: Int, createdDate: Date, noteTitle: String, noteBody: String) {
        self.noteId = noteId
        self.createdDate = createdDate
        self.noteTitle = noteTitle
        self.noteBody = noteBody
    }
    
    func fillWith(model: Note) {
        
        self.noteId = Int(model.noteId)
        self.createdDate = model.createdDate!
        self.noteTitle = model.noteTitle ?? ""
        self.noteBody = model.noteBody ?? ""
    }
    
    func createNote(note: Note) -> Note {
        
        note.noteId = Int64(noteId.self)
        note.createdDate = createdDate.self
        note.noteTitle = noteTitle.self
        note.noteBody = noteBody.self
        return note
    }
}
