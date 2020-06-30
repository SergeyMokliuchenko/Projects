//
//  CreateCoredataNoteViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 09.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit

class CreateCoredataNoteViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    
    var completionUpdate: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        updateNote()
    }
    
    func updateNote() {
        guard let note = noteModel else {return}
        self.titleTextField.text = note.title
        self.bodyTextView.text = note.body
        let imdage = UIImage(data: note.imageData!)
        self.userImageView.image = imdage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        userImageView.image = image
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func downloadImageAction(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func saveNoteAction(_ sender: UIButton) {
        
        guard let title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        guard let image = userImageView.image else { return }
        let imageData = image.pngData()
        
        if let note = noteModel {
            note.title = title
            note.body = body
            note.imageData = image.pngData()!
            if note.title == "" { note.title = note.body }
            CoreDataManager.shared.updateNote(model: note)
            
        } else {
            let note = Note.init(title: title, body: body, imageURL: "", imageData: imageData!, date: self.dateToString(), noteId: self.randomId(), userId:"")
            CoreDataManager.shared.saveNote(noteModel: note)
        }
        goToNotesCoredataViewController()
    }
    
}
