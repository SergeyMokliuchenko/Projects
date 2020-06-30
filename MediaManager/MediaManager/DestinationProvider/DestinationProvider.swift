//
//  DestinationProvider.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 26.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import Foundation

class DestinationProvider {
    
    var format: String
    var folder:String
    
    init(format: String, folder:String) {
        self.format = format
        self.folder = folder
    }
    
    func getFiles() -> [FileModel] {
        
         let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(folder)
         
        let directoryContents = try? FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
        
        let filesPaths = directoryContents?.filter{ $0.pathExtension == format }
        
        var fileList: [FileModel] = []
        
        filesPaths?.forEach { url in
            let name = url.deletingPathExtension().lastPathComponent
            let file = FileModel.init(name: name, url: url)
            fileList.append(file)
        }
        return fileList
    }
    
    func deleteFile(url: URL) {
        do {
        try FileManager.default.removeItem(at: url)
        } catch let error as NSError {
            print(error)
        }
    }
}
