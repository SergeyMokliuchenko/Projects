//
//  VideoController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 27.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import Foundation

class VideoFilesController {
    
    private let destonationProvider: DestinationProvider
    private var videoList: [FileModel] = []
    
    init(destonationProvider: DestinationProvider = DestinationProvider(format: "mp4", folder: "Video")) {
        self.destonationProvider = destonationProvider
    }
    
}

extension VideoFilesController: FilesManager {
    
    func loadFiles() {
        videoList.removeAll()
        for file in destonationProvider.getFiles() {
            let name = file.name
            let url = file.url
            let file = FileModel.init(name: name, url: url)
            videoList.append(file)
        }
    }
    
    func deleteFile(url: URL) {
        destonationProvider.deleteFile(url: url)
    }
    
    func getVideoList() -> [FileModel] {
        return videoList
    }
    
}
