//
//  ViewController.swift
//  Cam
//
//  Created by MakaloLau on 2020/12/14.
//  Copyright © 2020年 MakaloLau. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @objc var cameraView = CameraView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.white
        cameraView = CameraView(frame: UIScreen.main.bounds)
        self.view.addSubview(cameraView)
    
        cameraView.recordBtn.addTarget(self, action: #selector(ViewController.recordBtnClicked), for: .touchUpInside)
    }
    
    @objc func recordBtnClicked() {
        if (cameraView.recordBtn.currentTitle == "RECORD") {
            NSLog("Recording...")
            cameraView.startSaveVideo()
        } else {
            NSLog("Ready to record")
            cameraView.stopSaveVideo()
        }
    }    
}
