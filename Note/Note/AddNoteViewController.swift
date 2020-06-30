//
//  AddNoteViewController.swift
//  Note
//
//  Created by Сергей Моключенко on 26.03.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var headerTX: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
    var completionReload: (() -> ())?
    
    var noteModel: NoteModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fill()
    }
    
    func fill() {
        
        guard let note = noteModel else {return}
        self.headerTX.text = note.noteTitle
        self.bodyTV.text = note.noteBody
    }
    
    @IBAction func saveNote(_ sender: Any) {
        
        if let note = noteModel {
            
            guard let header = headerTX.text else {return}
            guard let body = bodyTV.text else {return}
            
            note.noteTitle = header
            note.noteBody = body
            
            CoreDataManager.shared.updateNote(noteModel: note)
            
            completionReload?()
            
            self.navigationController?.popViewController(animated: true)
            
        } else {
            
           guard let header = headerTX.text else {return}
           guard let body = bodyTV.text else {return}
            
           let randomInt = Int.random(in: 0..<1000000)
            
           let note = NoteModel.init(noteId: randomInt, createdDate: Date(), noteTitle: header, noteBody: body)
            
           CoreDataManager.shared.saveNote(noteModel: note)
            
            completionReload?()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
