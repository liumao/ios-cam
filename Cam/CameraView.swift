//
//  CameraView.swift
//  Cam
//
//  Created by MakaloLau on 2020/12/14.
//  Copyright © 2020年 MakaloLau. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Photos

class CameraView: UIView, AVCaptureFileOutputRecordingDelegate {
    
    //video view
    var videoView: UIView!
    let captureSession = AVCaptureSession()
    var camera: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer!
    //output file
    let fileOut = AVCaptureMovieFileOutput()
    //is recording...
    var isRecording = false
    
    //control view
    var AView: SelectView!
    var HView: SelectView!
    var LView: SelectView!
    var DView: SelectView!
    var DDView: SelectView!
    var EView: SelectView!
    var SView: SelectView!
    var GView: SelectView!
    var JView: SelectView!
    var KView: SelectView!
    var pidView: UITextField!
    
    //record btn
    var recordBtn: UIButton!
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        initVideoView()
        initControlView()
        initRecordBtn()
        initvideoConfig()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initVideoView() {
        videoView = UIView(frame: CGRect(x: 0, y: 20, width: Int(frame.size.width), height: Int(frame.size.height / 2)))
        
        //追加到当前view
        self.addSubview(videoView)
    }
    
    private func initControlView() {
        //采集场景
        let curX = 0
        var curY = 30 + Int(frame.size.height / 3)
        AView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / 15)))
        AView.setContents(labelTxt: "采集场景: ", cont: [
            "A1-室内-背景墙壁-正常光", "A2-室内-背景墙壁-强光", "A3-室内-背景墙壁-逆光", "A4-室内-背景墙壁-暗光", "A5-室内-背景墙壁-封闭灯光 ", "A6-室内-背景墙壁-光线不均匀",
            "A7-室内-背景地面-正常光", "A8-室内-背景地面-强光", "A9-室内-背景地面-逆光", "A10-室内-背景地面-暗光", "A11-室内-背景地面-封闭灯光 ", "A12-室内-背景地面-光线不均匀",
            "A13-室内-背景植物-正常光", "A14-室内-背景植物-强光", "A15-室内-背景植物-逆光", "A16-室内-背景植物-暗光", "A17-室内-背景植物-封闭灯光 ", "A18-室内-背景植物-光线不均匀",
            "A19-室内-背景植物-正常光", "A20-室内-背景植物-强光", "A21-室内-背景植物-逆光", "A22-室内-背景植物-暗光", "A23-室内-背景植物-封闭灯光 ", "A24-室内-背景植物-光线不均匀",
            "A25-室内-任选一种-正常光", "A26-室内-任选一种-强光", "A27-室内-任选一种-逆光", "A28-室内-任选一种-暗光", "A29-室内-任选一种-封闭灯光 ", "A30-室内-任选一种-光线不均匀",
            "A25-室内-边框，窗框、门框，条纹和框状等物体-正常光", "A26-室内-边框，窗框、门框，条纹和框状等物体-强光", "A27-室内-边框，窗框、门框，条纹和框状等物体-逆光",
            "A28-室内-边框，窗框、门框，条纹和框状等物体-暗光", "A29-室内-边框，窗框、门框，条纹和框状等物体-封闭灯光 ", "A30-室内-边框，窗框、门框，条纹和框状等物体-光线不均匀",
            "A31-室外-背景建筑-正常光", "A32-室外-背景建筑-强光", "A33-室外-背景建筑-逆光", "A34-室外-背景建筑-暗光", "A35-室外-背景建筑-光线不均匀",
            "A36-室外-背景植物-正常光", "A37-室外-背景植物-强光", "A38-室外-背景植物-逆光", "A39-室外-背景植物-暗光", "A40-室外-背景植物-光线不均匀",
            "A41-室外-背景空旷-正常光", "A42-室外-背景空旷-强光", "A43-室外-背景空旷-逆光", "A44-室外-背景空旷-暗光", "A45-室外-背景空旷-光线不均匀",
            "A46-室外-任选一种-正常光", "A47-室外-任选一种-强光", "A48-室外-任选一种-逆光", "A49-室外-任选一种-暗光", "A50-室外-任选一种-光线不均匀",
            "A51-室外-背景街景-正常光", "A52-室外-背景街景-强光", "A53-室外-背景街景-逆光", "A54-室外-背景街景-暗光", "A55-室外-背景街景-光线不均匀"
        ])
        self.addSubview(AView)
        
        //攻击方式
        curY = curY + Int(frame.size.height / 15)
        HView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / 15)))
        HView.setContents(labelTxt: "攻击方式: ", cont: [
            "H0-默认", "H1-图像-纸质照片-彩色", "H2-图像-纸质照片-黑白", "H3-图像-纸质裁剪人脸面具-彩色", "H4-图像-纸质裁剪人脸面具-黑白",
            "H5-图像-纸质裁剪半身面具-彩色", "H6-图像-纸质裁剪半身面具-黑白", "H7-图像-纸质海报全身-彩色", "H8-图像-纸质海报全身-黑白", "H9-图像-电子屏幕-(笔记本)电脑",
            "H10-图像-电子屏幕-Ipad", "H11-图像-电子屏幕- 手机 (Sec 五中的0-5)", "H12-图像-人脸面具", "H13-图像-人头模特(样例附件 1)", "H14-图像-3D渲染人头(样例附件 1)",
            "H15-视频-电子屏幕-(笔记本)电脑", "H16-视频-电子屏幕-Ipad", "H17-视频-电子屏幕-手机"
        ])
        self.addSubview(HView)
        
        //真人维度序号
        curY = curY + Int(frame.size.height / 15)
        LView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / 15)))
        LView.setContents(labelTxt: "真人维度序号: ", cont: [
            "L1-自然状态", "L2-手在脸上左右手拿手机、手挡下巴、手撩头发", "L3-切掉脸额头下巴脖子脸等不要使用道具遮挡，直接拍摄时切掉", "L4-面部表情（包括噘嘴、张嘴、大笑、鼓腮帮、皱眉等）",
            "L5-戴眼镜, 戴墨镜", "L6-戴帽子(还可以试着把帽檐拉低或斜向)", "L7-戴头巾、围巾、丝巾等", "L8-同时包含 0-7若干维度，如同时戴帽子、口罩以及眼镜等"
            ])
        self.addSubview(LView)
        
        //真人录制设备
        curY = curY + Int(frame.size.height / 15)
        DView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / 15)))
        DView.setContents(labelTxt: "真人录制设备: ", cont: [
            "D1-小米10", "D2-红米note9pro", "D3-荣耀9Xpro", "D4-oppoK7x", "D5-vivoiqoozi", "D6-魅族17", "D7-iphone11", "D8-大疆摄像头全景",
            "D9-mac摄像头罗技C930C", "D10-mac摄像头罗技C1000e光角", "D11-联想摄像头广角", "D12-华为笔记本摄像头matebook4", "D13-荣耀笔记本pro2020", "D14-ipadAir", "D15-ipaddmini5",
            "D16-华捷艾米摄像头-双目近红外", "D17-华捷艾米摄像头-RGBD（3D）", "D18-奥比中光摄像头-双目近红外", "D19-奥比中光摄像头-RGBD（3D）", "D20-健德源摄像头-双目近红外"
            ])
        self.addSubview(DView)
        
        //攻击录制设备
        curY = curY + Int(frame.size.height / 15)
        DDView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / 15)))
        DDView.setContents(labelTxt: "攻击录制设备: ", cont: [
            "DD1-小米10", "DD2-红米note9pro", "DD3-荣耀9Xpro", "DD4-oppoK7x", "DD5-vivoiqoozi", "DD6-魅族17", "DD7-iphone11", "DD8-大疆摄像头全景",
            "DD9-mac摄像头罗技C930C", "DD10-mac摄像头罗技C1000e光角", "DD11-联想摄像头广角", "DD12-华为笔记本摄像头matebook4", "DD13-荣耀笔记本pro2020", "DD14-ipadAir", "DD15-ipaddmini5",
            "DD16-华捷艾米摄像头-双目近红外", "DD17-华捷艾米摄像头-RGBD（3D）", "DD18-奥比中光摄像头-双目近红外", "DD19-奥比中光摄像头-RGBD（3D）", "DD20-健德源摄像头-双目近红外"
            ])
        self.addSubview(DDView)
        
        //人数
        curY = curY + Int(frame.size.height / 15)
        EView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width / 2), height: Int(frame.size.height / 15)))
        EView.setContents(labelTxt: "人数: ", cont: [
            "E0-默认", "E2-1（真或假）", "E3-2 （1 真 1 假）", "E4-2（2 假）", "E5-3（1 真 2假）", "E6-3（2  真 1 假）", "E7-3（3假）", "E8->3(随机包含假人)"
            ])
        self.addSubview(EView)
        //性别
        SView = SelectView(frame: CGRect(x: curX + Int(frame.size.width / 2), y: curY, width: Int(frame.size.width / 2), height: Int(frame.size.height / 15)))
        SView.setContents(labelTxt: "性别: ", cont: [
            "男", "女"
            ])
        self.addSubview(SView)
        
        //年龄编号
        curY = curY + Int(frame.size.height / 15)
        GView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width / 2), height: Int(frame.size.height / 15)))
        GView.setContents(labelTxt: "年龄: ", cont: [
            "G0-15岁及以下", "G1-20～40", "G2-40～60", "G3-60以上"
            ])
        self.addSubview(GView)
        
        //肤色
        JView = SelectView(frame: CGRect(x: curX + Int(frame.size.width / 2), y: curY, width: Int(frame.size.width / 2), height: Int(frame.size.height / 15)))
        JView.setContents(labelTxt: "肤色: ", cont: [
            "J0-华人", "J1-东南亚", "J2-白人"
            ])
        self.addSubview(JView)
        
        //编号
        curY = curY + Int(frame.size.height / 15)
        let label = UILabel(frame: CGRect(x: curX, y: curY,
                                          width: Int(frame.size.width * 0.2) - 5, height: Int(frame.size.height / 15)))
        label.text = "编号: "
        self.addSubview(label)
        pidView = UITextField(frame: CGRect(x: curX + Int(frame.size.width * 0.1), y: curY,
                                            width: Int(frame.size.width * 0.4) - 5, height: Int(frame.size.height / 15)))
        pidView.borderStyle = UITextField.BorderStyle.bezel
        self.addSubview(pidView)
        
        //距离
        KView = SelectView(frame: CGRect(x: curX + Int(frame.size.width / 2), y: curY, width: Int(frame.size.width / 2), height: Int(frame.size.height / 15)))
        KView.setContents(labelTxt: "距离: ", cont: [
            "K0-0.3米~0.5米", "K1-1米~2米", "K2-4米~5米"
            ])
        self.addSubview(KView)
    }
    
    private func initRecordBtn() {
        recordBtn = UIButton(type: .custom)
        recordBtn.frame = CGRect(x: frame.size.width / 2 - 50, y: frame.size.height - 45, width: 100, height: 40)
        recordBtn.setTitleColor(.black, for: .normal)
        recordBtn.setTitle("RECORD", for: .normal)

        recordBtn.layer.cornerRadius = 6.0
        recordBtn.layer.borderColor = UIColor.blue.cgColor
        recordBtn.layer.borderWidth = 1.0

        self.addSubview(recordBtn)
    }
    
    private func initvideoConfig() {
        camera = cameraWithPosition(position: AVCaptureDevice.Position.front)
        captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        if let videoInput = try? AVCaptureDeviceInput(device: self.camera!) {
            self.captureSession.addInput(videoInput)
        }
        
        captureSession.addOutput(fileOut)
        
        let videoLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoLayer.frame = videoView.bounds
        videoView.layer.addSublayer(videoLayer)
    }
    
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
        for item in devices {
            if item.position == position {
                return item
            }
        }
        return nil
    }
    
    //date time
    func getDateTime() -> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyyMMdd-HHmm"
        
        let now = NSDate()
        return dformatter.string(from: now as Date)
    }
    
    //take flag
    func getFlag(param: String) -> String {
        NSLog("in %@", param)
        if (!param.contains("-")) {
            return param
        }
        let array = param.split(separator: "-")
        NSLog("out %@", String(array[0]))
        return String(array[0])
    }
    
    //get file name
    func getFileName() -> String {
        let fileName = String(format: "%@_%@_%@(%@)_%@_%@_%@_%@_%@_%@_%@_PID%@",
            getDateTime(),
            getFlag(param: (AView?.selectData)!),
            getFlag(param: (HView?.selectData)!),
            getFlag(param: (LView?.selectData)!),
            getFlag(param: (DView?.selectData)!),
            getFlag(param: (DDView?.selectData)!),
            getFlag(param: (EView?.selectData)!),
            getFlag(param: (SView?.selectData)!) == "男" ? "F0" : "F1",
            getFlag(param: (GView?.selectData)!),
            getFlag(param: (JView?.selectData)!),
            getFlag(param: (KView?.selectData)!),
            (pidView?.text)!
        )
        return fileName
    }
    
    //save video
    func startSaveVideo() {
        recordBtn.setTitle("STOP", for: .normal)
        isRecording = true
        
        //启动采集
        captureSession.startRunning()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = path[0] as String
        let filePath: String? = "\(documentDirectory)/\(getFileName()).mp4"
        let fileUrl: NSURL? = NSURL(fileURLWithPath: filePath!)
        NSLog(filePath!)
        
        //启动视频编码输出
        fileOut.startRecording(to: fileUrl! as URL, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
    }
    func stopSaveVideo() {
        recordBtn.setTitle("RECORD", for: .normal)
        isRecording = false
        
        //停止录像以及停止采集
        fileOut.stopRecording()
        captureSession.stopRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        NSLog("captureOutput without error")
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        NSLog("captureOutput without error")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        NSLog("fileOutput:%@", outputFileURL.absoluteString)
        
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest .creationRequestForAssetFromVideo(atFileURL: outputFileURL as URL)},
                                               completionHandler: {(isSuccess: Bool, error:  NSError) in
            if (isSuccess) {
                NSLog("保存成功!")
            } else {
                NSLog("保存失败：@", error.localizedDescription)
            }} as? (Bool, Error?) -> Void
        )
    }
}
