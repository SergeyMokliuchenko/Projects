//
//  CoreDataManager.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 06.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getNotes() -> [Notes]? {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        do {
            let hetchedEntities = try context.fetch(fetchRequest) as! [Notes]
            return hetchedEntities
        } catch let error as NSError {
            print (error)
        }
        return nil
    }
    
    func saveNote(noteModel: Note) {
        
        let context = appDelegate.persistentContainer.viewContext
        var note = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context) as! Notes
        note = noteModel.objectToEntity(model: note)
        do {
            try context.save()
        } catch let error as NSError {
            print (error)
        }
    }
    
    func deleteNote(model: Note) {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "noteId==\(model.noteId)")
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
    
     func updateNote(model: Note) {
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "noteId==\(model.noteId)")
        let objects = try! context.fetch(fetchRequest)
        guard var objectForUpdate = objects.first else {return}
        objectForUpdate = model.objectToEntity(model: objectForUpdate)
        do {
            try context.save()
        } catch let error as NSError{
            print(error)
        }
    }
    
    func DeleteAllData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Notes"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
}
