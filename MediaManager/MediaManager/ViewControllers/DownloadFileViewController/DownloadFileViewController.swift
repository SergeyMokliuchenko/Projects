//
//  DownloadFileViewController.swift
//  MediaManager
//
//  Created by Serhii Mokliuchenko on 26.05.2020.
//  Copyright © 2020 triate. All rights reserved.
//

import UIKit

class DownloadFileViewController: UIViewController {

    @IBOutlet weak var nameFileTextField: UITextField!
    @IBOutlet weak var urlAddressTextView: UITextView!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var downloadProgressView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var okButton: UIButton!
    
    var downloadManager: DownloadManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadManager = DownloadManager()
        nameFileTextFieldStyle()
        urlAddressTextViewStyle()
        downloadButtonStyle()
        downloadProgressViewStyle()
        okButtonStyle()
    }
    
    private func nameFileTextFieldStyle() {
        nameFileTextField.layer.borderWidth = 1
        nameFileTextField.layer.cornerRadius = 5
        nameFileTextField.layer.borderColor = CGColor(srgbRed: 201/255, green: 201/255, blue: 201/255, alpha: 1)
    }
    
    private func urlAddressTextViewStyle() {
        urlAddressTextView.layer.borderWidth = 1
        urlAddressTextView.layer.cornerRadius = 5
        urlAddressTextView.layer.borderColor = CGColor(srgbRed: 201/255, green: 201/255, blue: 201/255, alpha: 1)
    }
    
    private func downloadButtonStyle() {
        downloadButton.layer.borderWidth = 1
        downloadButton.layer.cornerRadius = 5
        downloadButton.layer.borderColor = CGColor(srgbRed: 255/255, green: 105/255, blue: 103/255, alpha: 1)
    }
    
    private func downloadProgressViewStyle() {
        downloadProgressView.layer.cornerRadius = 10
    }
    
    private func okButtonStyle() {
        okButton.layer.borderWidth = 1
        okButton.layer.cornerRadius = 5
        okButton.layer.borderColor = CGColor(srgbRed: 255/255, green: 120/255, blue: 91/255, alpha: 1)
    }
    
}

extension DownloadFileViewController {
    
    @IBAction func selectedFileFormatAction(_ sender: UISegmentedControl) {
        selectFormatFile(sender: sender)
    }
    
    private func selectFormatFile(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            downloadManager?.format = "mp3"
            downloadManager?.folder = "Audio"
        case 1:
            downloadManager?.format = "mp4"
            downloadManager?.folder = "Video"
        default:
            break
        }
    }
    
    @IBAction func downloadFileAction(_ sender: UIButton) {
        downloadFile()
    }
    
    private func downloadFile() {
        
        guard let fileName = nameFileTextField.text, fileName != ""
            else {
                warningViewController(text: "Please type the title of the file")
                return
            }
        
        guard let url = urlAddressTextView.text, url != ""
            else {
                warningViewController(text: "Please type the URL address of the file")
                return
            }
        
        downloadManager?.downloadFile(url: url, fileName: fileName) { [weak self] progress in
            self?.showDownloadProgress(progress: progress)
        }
        
    }
    
    private func warningViewController(text: String) {
        
        let warningVC = WarningViewController.init(warningText: text)
        warningVC.modalPresentationStyle = .overFullScreen
        warningVC.modalTransitionStyle = .crossDissolve
        self.present(warningVC, animated: true)
    }
    
    private func showDownloadProgress(progress: Progress) {
        
        alertView.alpha = 1
        progressLabel.text = progress.localizedDescription
        progressView.setProgress(Float(progress.fractionCompleted), animated: true)
        if progress.fractionCompleted == 1.0 {
            progressLabel.text = "Download completed"
            animateOkButton()
        }
    }
    
    private func animateOkButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.okButton.alpha = 1
        }
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        
        hideDownloadProgress()
    }
    
    private func hideDownloadProgress() {
        
        alertView.alpha = 0
        okButton.alpha = 0
        progressView.progress = 0
        nameFileTextField.text?.removeAll()
        urlAddressTextView.text.removeAll()
        progressLabel.text = "Loading..."
    }
    
}
