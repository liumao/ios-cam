//
//  ViewController.swift
//  Cam
//
//  Created by MakaloLau on 2020/12/14.
//  Copyright © 2020年 MakaloLau. All rights reserved.
//

import UIKit
import Photos
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
        //private media
        let infodic:NSDictionary = info as NSDictionary
        let mediaUrl: NSURL = infodic[UIImagePickerController.InfoKey.mediaURL] as! NSURL
        
        //create album
        let fetchOptions = PHFetchOptions()
        let pidAlbm = "PID" + cameraView.pidView.text!
        fetchOptions.predicate = NSPredicate(format: "title = %@", pidAlbm);
        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        var assetCollection: PHAssetCollection!
        var assetCollectionPlaceholder: PHObjectPlaceholder!
        if let _: AnyObject = collection.firstObject {
            assetCollection = collection.firstObject!
        } else {
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: pidAlbm);
                assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
                }, completionHandler: { (isSuccess: Bool, error: Error?) in
                    if (isSuccess) {
                        let collectionFetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [assetCollectionPlaceholder.localIdentifier], options: nil)
                        assetCollection = collectionFetchResult.firstObject!
                    } else {
                        
                    }
                }
            )
        }
        
        //rename
        let videoPath = mediaUrl.path!
        var newVideoPath = String(videoPath.prefix(upTo: videoPath.lastIndex(of: "/")!))
        //get file name
        let fileName = cameraView.getFileName()
        newVideoPath = newVideoPath + "/" + fileName
        NSLog("new video path: %@", newVideoPath)
        
        //save
        if assetCollection != nil {
            PHPhotoLibrary.shared().performChanges({
                let result = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: mediaUrl as URL)
                let assetPlaceholder = result?.placeholderForCreatedAsset
                let albumChangeRequset = PHAssetCollectionChangeRequest(for: assetCollection!)
                albumChangeRequset!.addAssets([assetPlaceholder!] as NSArray)
            }, completionHandler: { (isSuccess: Bool, error: Error?) in
                if isSuccess {
                    NSLog("save success.")
                } else {
                    NSLog("save failure.  %@", error!.localizedDescription)
                }
            })
        } else {
            NSLog("album %@ is null", pidAlbm)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
