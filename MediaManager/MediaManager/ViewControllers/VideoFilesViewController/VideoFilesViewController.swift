//
//  VideoFilesViewController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 26.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit
import AVFoundation

class VideoFilesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var videoController: VideoFilesController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        longPressRecognizer()
    }
    
    private func prepareCollectionView() {
        
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.register(UINib.init(nibName: String(describing: CustomCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
         collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideoList()
    }
    
    private func setupVideoList() {
        videoController = VideoFilesController()
        videoController?.loadFiles()
        collectionView.reloadData()
    }
    
    private func longPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizer.State.began {

            let touchPoint = sender.location(in: self.collectionView)
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                guard let video = videoController?.getVideoList()[indexPath.row].url else { return }
                deleteVideo(url: video)
            }
        }
    }
    
    private func deleteVideo(url: URL) {
        let deleteFileVC = DeleteFileViewController.init()
        deleteFileVC.modalPresentationStyle = .overFullScreen
        deleteFileVC.modalTransitionStyle = .coverVertical
        deleteFileVC.completion = {
            self.videoController?.deleteFile(url: url)
            self.setupVideoList()
        }
        present(deleteFileVC, animated: true, completion: nil)
    }
    
}

extension VideoFilesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let videoList = videoController?.getVideoList() else { return 0 }
        return videoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as! CustomCollectionViewCell
        guard let video = videoController?.getVideoList()[indexPath.row] else { return cell }
        cell.fillWith(model: video)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.collectionView.frame.width / 2 - 20, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let video = videoController?.getVideoList() else { return }
        let userInfo = ["CurrentVideo" : video[indexPath.row].url, "VideoList" : video] as [String : Any]
        NotificationCenter.default.post(name: NotificationNames.videoListener, object: nil, userInfo: userInfo)
        self.tabBarController?.selectedIndex = 2
    }
    
}
