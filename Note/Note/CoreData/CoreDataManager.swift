//
//  CoreDataManager.swift
//  Note
//
//  Created by Сергей Моключенко on 24.03.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getNotes() -> [Note]? {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let hetchedEntities = try context.fetch(fetchRequest) as! [Note]
            return hetchedEntities
        } catch let error as NSError {
            print (error)
        }
        return nil
    }
    
    func saveNote(noteModel: NoteModel) {
        
        let context = appDelegate.persistentContainer.viewContext
        var note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        note = noteModel.createNote(note: note)
        do {
            try context.save()
        } catch let error as NSError {
            print (error)
        }
    }
    
    func deleteNote(noteModel: NoteModel) {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        fetchRequest.predicate = NSPredicate.init(format: "noteId==\(noteModel.noteId)")
        let object = try! context.fetch(fetchRequest)
        
        for obj in object {
            context.delete(obj)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print (error)
        }
    }
    
     func updateNote(noteModel: NoteModel) {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        fetchRequest.predicate = NSPredicate.init(format: "noteId==\(noteModel.noteId)")
        let objects = try! context.fetch(fetchRequest)
        guard var objectForUpdate = objects.first else {return}
        
        objectForUpdate = noteModel.createNote(note: objectForUpdate)
        do {
            try context.save()
        } catch let error as NSError{
            print(error)
        }
    }
}
