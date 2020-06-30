//
//  NotesCoredataViewController.swift
//  FirebaseNotes v2
//
//  Created by Сергей Моключенко on 09.05.2020.
//  Copyright © 2020 triare. All rights reserved.
//

import UIKit

class NotesCoredataViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.register(UINib.init(nibName: String(describing: CustomCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
         collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        fetchData()
    }
    
    private func fetchData() {
        self.notes.removeAll()
        var mass: [Note] = []
        for obj in CoreDataManager.shared.getNotes()! {
            let note = Note.init(title: "", body: "", imageURL: "", imageData: Data(), date: "", noteId: "", userId: "")
            note.entityToObject(model: obj)
            mass.append(note)
        }
        self.notes = mass
        print(notes)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as! CustomCollectionViewCell
        
        let note = notes[indexPath.row]
        cell.fillWith(model: note)
        cell.deleteCompletion = {
            
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { [weak self] action in
                CoreDataManager.shared.deleteNote(model: note)
                self?.fetchData()
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
            watchNoteViewController.watchCoredataNote(model: note)
            self.fetchData()
        }
        watchNoteViewController.completionUpdate = {
            self.updateNote(model: note)
        }
        navigationController?.pushViewController(watchNoteViewController, animated: true)
    }
    
    private func updateNote(model: Note?) {
        let createNote = CreateCoredataNoteViewController.init()
        createNote.completionUpdate = {
            self.fetchData()
            self.collectionView.reloadData()
        }
        createNote.noteModel = model
        navigationController?.pushViewController(createNote, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightTitle = notes[indexPath.row].title.height(withConstrainedWidth: self.collectionView.frame.width, font: UIFont.systemFont(ofSize: 45))
        let heightDate = notes[indexPath.row].date.height(withConstrainedWidth: self.collectionView.frame.width, font: UIFont.systemFont(ofSize: 15))
        return CGSize.init(width: self.collectionView.frame.width / 2 - 20, height: heightTitle + heightDate)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        self.collectionView.reloadData()
    }
    
    @IBAction func addNoteAction(_ sender: UIBarButtonItem) {
        updateNote(model: nil)
    }
}
