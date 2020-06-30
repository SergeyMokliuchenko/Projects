//
//  LoadingFiles.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 28.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import Foundation

protocol FilesManager {
    
    func loadFiles()
    
    func deleteFile(url: URL)
}
