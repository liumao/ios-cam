
//
//  ViewController.swift
//  Cam
//
//  Created by MakaloLau on 2020/12/14.
//  Copyright © 2020年 MakaloLau. All rights reserved.
//
import UIKit
import AssetsLibrary
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @objc var cameraView = CameraView()
    
    //system camera
    var videoPicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        self.view.backgroundColor = UIColor.white
        cameraView = CameraView(frame: UIScreen.main.bounds)
        self.view.addSubview(cameraView)
        
        //text field delegate
        cameraView.pidView.delegate = self
        cameraView.recordBtn.addTarget(self, action: #selector(ViewController.recordBtnClicked), for: .touchUpInside)
    }
    
    @objc func recordBtnClicked() {
        videoPicker = UIImagePickerController()
        videoPicker.sourceType = .camera
        videoPicker.cameraDevice = .front
        videoPicker.mediaTypes =  [kUTTypeMovie as String]
        videoPicker.videoQuality = .typeHigh
        videoPicker.delegate = self
        self.present(videoPicker, animated: true, completion: nil)

    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //收起键盘
            cameraView.pidView.resignFirstResponder()
            return true;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let infodic:NSDictionary = info as NSDictionary
        let mediaUrl: NSURL = infodic[UIImagePickerController.InfoKey.mediaURL] as! NSURL
        let videoPath = mediaUrl.path!
        NSLog("video path: %@", videoPath)
        
        //save
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath) {
            UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil)
        }
        
        //rename
        var newVideoPath = String(videoPath.prefix(upTo: videoPath.lastIndex(of: "/")!))
        //get file name
        let fileName = cameraView.getFileName()
        
        //file manager
        let fileManager = FileManager()
        
        //create dir
        let pid = cameraView.pidView.text!
        let pidDir = newVideoPath + "/PID" + pid
        if !fileManager.fileExists(atPath: pidDir) {
            do {
                try fileManager.createDirectory(atPath: pidDir, withIntermediateDirectories: true, attributes:nil)
                newVideoPath = pidDir + "/" + fileName
            } catch {
                newVideoPath = newVideoPath + "/" + fileName
                NSLog("rename failure")
            }
        } else {
            newVideoPath = pidDir + "/" + fileName
        }
        NSLog("new video path: %@", newVideoPath)
        
        do {
          try fileManager.moveItem(atPath: videoPath, toPath: newVideoPath)
        } catch {
            NSLog("rename failure")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
