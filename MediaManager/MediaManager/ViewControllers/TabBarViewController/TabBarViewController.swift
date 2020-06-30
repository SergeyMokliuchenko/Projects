//
//  TabBarController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 26.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fillTabBar()
        tabBarStyle()
    }
    
    private func fillTabBar() {
        
        let audioFilesVC = AudioFilesViewController.init()
        let videoFilesVC = VideoFilesViewController.init()
        let playerVC = CustomAVPlayerViewController.init()
        let downloadFileVC = DownloadFileViewController.init()
        
        audioFilesVC.tabBarItem = UITabBarItem.init(title: "Audio", image: UIImage(named: "Player_button_white"), tag: 0)
        videoFilesVC.tabBarItem = UITabBarItem.init(title: "Video", image: UIImage(named: "Video_button_white"), tag: 1)
        playerVC.tabBarItem = UITabBarItem.init(title: "Player", image: UIImage(named: "Player_button_white"), tag: 2)
        downloadFileVC.tabBarItem = UITabBarItem.init(title: "Add", image: UIImage(named: "Add_button_white"), tag: 3)
        
        self.setViewControllers([audioFilesVC, videoFilesVC, playerVC, downloadFileVC], animated: true)
        self.selectedIndex = 2
    }
    
    private func tabBarStyle() {
        
        tabBar.backgroundColor = UIColor(displayP3Red: 0/255, green: 33/255, blue: 64/255, alpha: 1)
        tabBar.barStyle = .black
        tabBar.tintColor = UIColor(displayP3Red: 255/255, green: 120/255, blue: 91/255, alpha: 1)
    }
    
}
