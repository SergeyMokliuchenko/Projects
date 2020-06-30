//
//  CreateNoteViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class CreateNoteViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    
    var completionUpdate: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        currentUser()
        updateNote()
        completionUpdate?()
    }
    
    func currentUser() {
        guard let currentUser = Auth.auth().currentUser else { return }
        self.user = Users.init(user: currentUser)
        self.ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("notes")
    }
    func updateNote() {
        guard let note = noteModel else {return}
        self.titleTextField.text = note.title
        self.bodyTextView.text = note.body
        self.storageRef = Storage.storage().reference(forURL: note.imageURL)
        let megaByte = Int64(5 * 1024 * 1024)
        storageRef.getData(maxSize: megaByte) { [weak self] (data, error) in
            guard let imageData = data else { return }
            let image = UIImage.init(data: imageData)
            self?.userImageView.image = image
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        userImageView.image = image
    }

    func upload(userId: String, image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        self.storageRef = Storage.storage().reference().child("userImage").child(userId)
        
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { [weak self] (metadata, error) in
            guard let _ = metadata else {
                print(error!.localizedDescription)
                return
            }
            self?.storageRef.downloadURL { (url, error) in
                    guard let url = url else {
                    print(error!.localizedDescription)
                    return
                }
                completion(.success(url))
            }
        }
    }
    
    @IBAction func downloadImageAction(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let noteId: String = randomId()
        saveNoteToFirebase(noteId: noteId)
        saveNoteToCoredata(noteId: noteId)
        goToNotesViewController()
    }
    
    private func saveNoteToFirebase(noteId: String) {
        
        guard var title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        guard let image = userImageView.image else { return }
        
         if let note = noteModel {
            note.title = title
            note.body = body
            
            if note.title == "" { note.title = note.body }
            upload(userId: note.noteId, image: image) { [weak self] (result) in
                switch result {
                case .success(let url):
                    let post = ["title" : note.title, "body" : note.body, "imageURL" : url.absoluteString, "date" : self?.dateToString(), "noteId" : note.noteId, "userId" : note.userId]
                    let childUpdates = [note.noteId : post]
                    self?.ref.updateChildValues(childUpdates)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
           if title == "" { title = bodyTextView.text }
           upload(userId: randomId(), image: image) { (result) in
               switch result {
               case .success(let url):
                let imageData = image.pngData()
                let note = Note.init(title: title, body: body, imageURL: url.absoluteString, imageData: imageData!, date: self.dateToString(), noteId: noteId, userId: self.user.uid)
                   let noteRef = self.ref.child(note.noteId.lowercased())
                   noteRef.setValue(note.convertToDictionary())
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
        }
    }
    
    private func saveNoteToCoredata(noteId: String) {
        
        guard let title = titleTextField.text else { return }
        guard let body = bodyTextView.text else { return }
        guard let image = userImageView.image else { return }
        let imageData = image.pngData()!
        
        if let note = noteModel {
            note.title = title
            note.body = body
            note.imageData = image.pngData()!
            if note.title == "" { note.title = note.body }
            CoreDataManager.shared.updateNote(model: note)
        } else {
            let note = Note.init(title: title, body: body, imageURL: "", imageData: imageData, date: self.dateToString(), noteId: noteId, userId: "")
            CoreDataManager.shared.saveNote(noteModel: note)
        }
    }
    
    func loadOfflineNote(array: [Note]) {
        
        for note in array {
            self.loadNote(model: note)
        }
    }
    
    private func loadNote(model: Note) {
         currentUser()
        
        if let note = noteModel {
            let image = UIImage.init(data: note.imageData!)!
            upload(userId: note.userId, image: image) { (result) in
            switch result {
                
            case .success(let url):
                let note = Note.init(title: note.title, body: note.body, imageURL: url.absoluteString, imageData: Data(), date: self.dateToString(), noteId: note.noteId, userId: self.user.uid)
                    let noteRef = self.ref.child(note.noteId)
                    noteRef.setValue(note.convertToDictionary())
            case .failure(let error):
                print(error.localizedDescription)
                }
            }
            
        } else {
             let image = UIImage.init(data: model.imageData!)!
             
            upload(userId: model.userId, image: image) { (result) in
                 switch result {
                     
                 case .success(let url):
                     let note = Note.init(title: model.title, body: model.body, imageURL: url.absoluteString, imageData: Data(), date: self.dateToString(), noteId: model.noteId, userId: self.user.uid)
                         let noteRef = self.ref.child(note.noteId)
                         noteRef.setValue(note.convertToDictionary())
                 case .failure(let error):
                     print(error.localizedDescription)
                 }
             }
        }
        
     }
    
}
