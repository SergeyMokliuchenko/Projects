//
//  NotesViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 02.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class NotesViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        prepareCollectionView()
        currentUser()
        fetchCoreData()
    }
    
    private func prepareCollectionView() {
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.register(UINib.init(nibName: String(describing: CustomCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
         collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
     }
    
    private func currentUser() {
        guard let currentUser = Auth.auth().currentUser else { return }
        self.user = Users.init(user: currentUser)
        self.ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("notes")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        fetchData()
    }
    
    private func fetchData() {
        ref.observe(.value) { [weak self] (snapshot) in
            var firebase: [Note] = []
            for item in snapshot.children {
                let note = Note(snapshot: item as! DataSnapshot)
                firebase.append(note)
            }
            self?.notes = firebase
            self?.loadCoredata(array: firebase)
            self?.collectionView.reloadData()
        }
        
    }
    
    private func loadCoredata(array: [Note]) {
        for note in array {
            self.updateCoredata(model: note)
        }
    }
    // Save Firebase notes to Coredata
    private func updateCoredata(model: Note) {
        CoreDataManager.shared.saveNote(noteModel: model)
    }
    
    private func fetchCoreData() {
        self.coredataNotes.removeAll()
        var mass: [Note] = []
        for obj in CoreDataManager.shared.getNotes()! {
            let note = Note.init(title: "", body: "", imageURL: "", imageData: Data(), date: "", noteId: "", userId: "")
            note.entityToObject(model: obj)
            mass.append(note)
        }
        self.coredataNotes = mass
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as! CustomCollectionViewCell
        
        let note = notes[indexPath.row]
        cell.fillWith(model: note)
        cell.deleteCompletion = {
            
            self.storageRef = Storage.storage().reference().child("userImage")
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { [weak self] action in
                CoreDataManager.shared.deleteNote(model: note)
                note.ref?.removeValue()
                self?.storageRef.child(note.noteId).delete { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            alert.addAction(cancelButton)
            alert.addAction(deleteButton)
            
            self.present(alert, animated: true, completion: nil)
            }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let watchNoteViewController = WatchNoteViewController.init()
        
        let note = self.notes[indexPath.row]
        watchNoteViewController.completionWatch = {
            watchNoteViewController.watchNote(model: note)
        }
        watchNoteViewController.completionUpdate = {
            self.updateNote(noteModel: note)
        }
        navigationController?.pushViewController(watchNoteViewController, animated: true)
    }
    
    private func updateNote(noteModel: Note?) {
        let createNote = CreateNoteViewController.init()
        createNote.completionUpdate = {
            self.fetchData()
            self.collectionView.reloadData()
        }
        createNote.noteModel = noteModel
        navigationController?.pushViewController(createNote, animated: true)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightTitle = notes[indexPath.row].title.height(withConstrainedWidth: self.collectionView.frame.width, font: UIFont.systemFont(ofSize: 35))
        let heightDate = notes[indexPath.row].date.height(withConstrainedWidth: self.collectionView.frame.width, font: UIFont.systemFont(ofSize: 15))
        return CGSize.init(width: self.collectionView.frame.width / 2 - 20, height: heightTitle + heightDate)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension NotesViewController {
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        self.refreshNote()
        self.collectionView.reloadData()
    }
    
    private func refreshNote() {
        
        let createNoneViewController = CreateNoteViewController.init()
        let coredataNote = self.coredataNotes
        let firebaseNote = self.notes
        var result: [Note] = []
        
        print(coredataNote)
        print(firebaseNote)
        
        coredataNote.forEach { (a) in
            firebaseNote.forEach { (b) in
                if a != b {
                    result.append(a)
                }
            }
        }
        print(result)
        createNoneViewController.loadOfflineNote(array: result)
    }
    
    @IBAction func addNoteAction(_ sender: UIBarButtonItem) {
        updateNote(noteModel: nil)
    }
    
    @IBAction func logOutAction(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        CoreDataManager.shared.DeleteAllData()
        self.rememberUser(value: false)
        goToSignInViewController()
        
    }
    
}
