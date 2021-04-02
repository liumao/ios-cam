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

class CameraView: UIView, UITextFieldDelegate {
    
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
    
    //height
    var control_height = 15
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        initControlView()
        initRecordBtn()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initControlView() {
        //采集场景
        let curX = 0
        var curY = 60
        AView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        AView.setContents(labelTxt: "采集场景: ", cont: [
            "A1-室内-背景墙壁-正常光", "A2-室内-背景墙壁-强光", "A3-室内-背景墙壁-逆光", "A4-室内-背景墙壁-暗光", "A5-室内-背景墙壁-封闭灯光 ", "A6-室内-背景墙壁-光线不均匀",
            "A7-室内-背景地面-正常光", "A8-室内-背景地面-强光", "A9-室内-背景地面-逆光", "A10-室内-背景地面-暗光", "A11-室内-背景地面-封闭灯光 ", "A12-室内-背景地面-光线不均匀",
            "A13-室内-背景植物-正常光", "A14-室内-背景植物-强光", "A15-室内-背景植物-逆光", "A16-室内-背景植物-暗光", "A17-室内-背景植物-封闭灯光 ", "A18-室内-背景植物-光线不均匀",
            "A19-室内-任选一种-正常光", "A20-室内-任选一种-强光", "A21-室内-任选一种-逆光", "A22-室内-任选一种-暗光", "A23-室内-任选一种-封闭灯光 ", "A24-室内-任选一种-光线不均匀",
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
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        HView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        HView.setContents(labelTxt: "攻击方式: ", cont: [
            "H0-默认", "H1-图像-纸质照片-彩色", "H2-图像-纸质照片-黑白", "H3-图像-纸质裁剪人脸面具-彩色", "H4-图像-纸质裁剪人脸面具-黑白",
            "H5-图像-纸质裁剪半身面具-彩色", "H6-图像-纸质裁剪半身面具-黑白", "H7-图像-纸质海报全身-彩色", "H8-图像-纸质海报全身-黑白", "H9-图像-电子屏幕-(笔记本)电脑",
            "H10-图像-电子屏幕-Ipad", "H11-图像-电子屏幕- 手机 (Sec 五中的0-5)", "H12-图像-人脸面具", "H13-图像-人头模特(样例附件 1)", "H14-图像-3D渲染人头(样例附件 1)",
            "H15-视频-电子屏幕-(笔记本)电脑", "H16-视频-电子屏幕-Ipad", "H17-视频-电子屏幕-手机"
        ])
        self.addSubview(HView)
        
        //真人维度序号
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        LView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        LView.setContents(labelTxt: "真人维度序号: ", cont: [
            "L1-自然状态", "L2-手在脸上左右手拿手机、手挡下巴、手撩头发", "L3-切掉脸额头下巴脖子脸等不要使用道具遮挡，直接拍摄时切掉", "L4-面部表情（包括噘嘴、张嘴、大笑、鼓腮帮、皱眉等）",
            "L5-戴眼镜, 戴墨镜", "L6-戴帽子(还可以试着把帽檐拉低或斜向)", "L7-戴头巾、围巾、丝巾等", "L8-同时包含 0-7若干维度，如同时戴帽子、口罩以及眼镜等"
            ])
        self.addSubview(LView)
        
        //真人录制设备
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        DView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        DView.setContents(labelTxt: "真人录制设备: ", cont: [
            "D1-小米10", "D2-红米note9pro", "D3-荣耀9Xpro", "D4-oppoK7x", "D5-vivoiqoozi", "D6-魅族17", "D7-iphone11", "D8-大疆摄像头全景", "D9-mac摄像头罗技C930C", "D10-mac摄像头罗技C1000e广角", "D11-联想摄像头广角", "D17-OPPOAce2", "D18-realmeQ2pro", "D13-华为笔记本", "D14-荣耀笔记本", "D15-ipadAir", "D16-ipaddmini5", "D12-健德源摄像头-双目近红外", "D19-华捷艾米", "D20-奥比中光",
            "D21-小米10", "D22-红米note9pro", "D23-荣耀9Xpro", "D24-oppoK7x", "D25-vivoiqoozi", "D26-魅族17", "D27-iphone11", "D28-大疆摄像头全景", "D29-mac摄像头罗技C1000e广角", "D30-联想摄像头广角", "D31-ONEPLUS8", "D32-VIVOY3s", "D33-华为笔记本摄像头matebook4", "D34-健德源摄像头-双目近红外", "D35-华捷艾米", "D36-奥比中光",
            "D41-小米10", "D42-红米note9pro", "D43-荣耀9Xpro", "D44-oppoK7x", "D45-vivoiqoozi", "D46-魅族17", "D47-iphone11", "D48-大疆摄像头全景", "D49-mac摄像头罗技C1000e广角", "D50-联想摄像头广角", "D51-华为mate30pro", "D52-OPPOreno3pro", "D53-ipaddmini5", "D54-健德源摄像头-双目近红外", "D55-华捷艾米", "D56-奥比中光",
            "D61-小米10至尊", "D62-红米note9pro", "D63-荣耀9Xpro", "D64-oppoK7x", "D65-vivoiqoozi", "D66-魅族17pro", "D67-iphone11", "D68-大疆摄像头全景", "D69-mac摄像头罗技C930C", "D70-联想摄像头广角", "D71-华为mate30pro", "D72-OPPOreno3pro", "D73-荣耀笔记本2020", "D74-健德源摄像头-双目近红外", "D75-华捷艾米", "D76-奥比中光",
            "D81-小米10", "D82-红米note9", "D83-荣耀9Xpro", "D84-oppoK7x", "D85-vivoiqoozi", "D86-魅族17", "D87-iphone11", "D88-大疆摄像头全景", "D89-罗技C1000e", "D90-联想摄像头广角", "D91-华为mate30pro", "D92-OPPOreno4", "D93-ipadAir", "D94-健德源摄像头-双目近红外", "D95-华捷艾米", "D96-奥比中光",
            "D101-小米10", "D102-红米note9", "D103-荣耀9Xpro", "D104-oppoK7x", "D105-vivoiqoopro", "D106-魅族17", "D107-iphone11", "D108-大疆摄像头全景", "D109-罗技C930C", "D110-联想摄像头广角", "D111-华为mate30pro", "D112-OPPOreno4", "D113-华为笔记本", "D114-健德源摄像头-双目近红外", "D115-华捷艾米", "D116-奥比中光",
            "D121-小米10", "D122-红米note9", "D123-荣耀9Xpro", "D124-oppoK7x", "D125-vivo iqoopro", "D126-魅族17", "D127-iphone11", "D128-大疆摄像头全景", "D129-罗技C1000e", "D130-联想摄像头广角", "D131-华为mate30pro", "D132-OPPOreno4", "D133-ipaddmini5", "D134-健德源摄像头-双目近红外", "D135-华捷艾米", "D136-奥比中光",
            "D141-小米10", "D142-红米note9", "D143-荣耀9Xpro", "D144-oppoK7x", "D145-vivoiqooneo3", "D146-魅族17", "D147-iphone11", "D148-大疆摄像头全景", "D149-罗技C930C", "D150-联想摄像头广角", "D151-华为mate30pro", "D152-OPPOreno4", "D153-荣耀笔记本", "D154-健德源摄像头-双目近红外", "D155-华捷艾米", "D156-奥比中光"
            ])
        self.addSubview(DView)
        
        //攻击录制设备
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        DDView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        DDView.setContents(labelTxt: "攻击录制设备: ", cont: [
            "DD0-默认", "DD1-小米10", "DD2-红米note9pro", "DD3-荣耀9Xpro", "DD4-oppoK7x", "DD5-vivoiqoozi", "DD6-魅族17", "DD7-iphone11", "DD8-大疆摄像头全景", "DD9-mac摄像头罗技C930C", "DD10-mac摄像头罗技C1000e广角", "DD11-联想摄像头广角", "DD17-OPPOAce2", "DD18-realmeQ2pro", "DD13-华为笔记本", "DD14-荣耀笔记本", "DD15-ipadAir", "DD16-ipaddmini5", "DD12-健德源摄像头-双目近红外", "DD19-华捷艾米", "DD20-奥比中光",
            "DD21-小米10", "DD22-红米note9pro", "DD23-荣耀9Xpro", "DD24-oppoK7x", "DD25-vivoiqoozi", "DD26-魅族17", "DD27-iphone11", "DD28-大疆摄像头全景", "DD29-mac摄像头罗技C1000e广角", "DD30-联想摄像头广角", "DD31-ONEPLUS8", "DD32-VIVOY3s", "DD33-华为笔记本摄像头matebook4", "DD34-健德源摄像头-双目近红外", "DD35-华捷艾米", "DD36-奥比中光",
            "DD41-小米10", "DD42-红米note9pro", "DD43-荣耀9Xpro", "DD44-oppoK7x", "DD45-vivoiqoozi", "DD46-魅族17", "DD47-iphone11", "DD48-大疆摄像头全景", "DD49-mac摄像头罗技C1000e广角", "DD50-联想摄像头广角", "DD51-华为mate30pro", "DD52-OPPOreno3pro", "DD53-ipaddmini5", "DD54-健德源摄像头-双目近红外", "DD55-华捷艾米", "DD56-奥比中光",
            "DD61-小米10", "DD62-红米note9pro", "DD63-荣耀9Xpro", "DD64-oppoK7x", "DD65-vivoiqoozi", "DD66-魅族17", "DD67-iphone11", "DD68-大疆摄像头全景", "DD69-mac摄像头罗技C930C", "DD70-联想摄像头广角", "DD71-华为mate30pro", "DD72-OPPOreno3pro", "DD73-荣耀笔记本2020", "DD74-健德源摄像头-双目近红外", "DD75-华捷艾米", "DD76-奥比中光",
            "DD81-小米10", "DD82-红米note9", "DD83-荣耀9Xpro", "DD84-oppoK7x", "DD85-vivoiqoozi", "DD86-魅族17", "DD87-iphone11", "DD88-大疆摄像头全景", "DD89-罗技C1000e", "DD90-联想摄像头广角", "DD91-华为mate30pro", "DD92-OPPOreno4", "DD93-ipaDDAir", "DD94-健德源摄像头-双目近红外", "DD95-华捷艾米", "DD96-奥比中光",
            "DD101-小米10", "DD102-红米note9", "DD103-荣耀9Xpro", "DD104-oppoK7x", "DD105-vivoiqoopro", "DD106-魅族17", "DD107-iphone11", "DD108-大疆摄像头全景", "DD109-罗技C930C", "DD110-联想摄像头广角", "DD111-华为mate30pro", "DD112-OPPOreno4", "DD113-华为笔记本", "DD114-健德源摄像头-双目近红外", "DD115-华捷艾米", "DD116-奥比中光",
            "DD121-小米10", "DD122-红米note9", "DD123-荣耀9Xpro", "DD124-oppoK7x", "DD125-vivo iqoopro", "DD126-魅族17", "DD127-iphone11", "DD128-大疆摄像头全景", "DD129-罗技C1000e", "DD130-联想摄像头广角", "DD131-华为mate30pro", "DD132-OPPOreno4", "DD133-ipaDDDDmini5", "DD134-健德源摄像头-双目近红外", "DD135-华捷艾米", "DD136-奥比中光",
            "DD141-小米10", "DD142-红米note9", "DD143-荣耀9Xpro", "DD144-oppoK7x", "DD145-vivoiqooneo3", "DD146-魅族17", "DD147-iphone11", "DD148-大疆摄像头全景", "DD149-罗技C930C", "DD150-联想摄像头广角", "DD151-华为mate30pro", "DD152-OPPOreno4", "DD153-荣耀笔记本", "DD154-健德源摄像头-双目近红外", "DD155-华捷艾米", "DD156-奥比中光"
            ])
        self.addSubview(DDView)
        
        //人数
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        EView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        EView.setContents(labelTxt: "人数: ", cont: [
            "E0-默认", "E1-1（真或假）", "E2-2 （1 真 1 假）", "E3-2（2 假）", "E4-3（1 真 2假）", "E5-3（2  真 1 假）", "E6-3（3假）", "E7->3(随机包含假人)"
            ])
        self.addSubview(EView)
        
        //性别
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        SView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        SView.setContents(labelTxt: "性别: ", cont: [
            "男", "女"
            ])
        self.addSubview(SView)
        
        //年龄
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        GView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        GView.setContents(labelTxt: "年龄: ", cont: [
            "G0-15岁及以下", "G1-20～40", "G2-40～60", "G3-60以上"
            ])
        self.addSubview(GView)
        
        //肤色
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        JView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        JView.setContents(labelTxt: "肤色: ", cont: [
            "J0-华人", "J1-东南亚", "J2-白人"
            ])
        self.addSubview(JView)
        
        //编号
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        let label = UILabel(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width * 0.4) - 5, height: Int(frame.size.height / CGFloat(control_height))))
        label.text = "编号: "
        self.addSubview(label)
        pidView = UITextField(frame: CGRect(x: curX + Int(frame.size.width * 0.2), y: curY,
                                            width: Int(frame.size.width * 0.8) - 5, height: Int(frame.size.height / CGFloat(control_height))))
        pidView.borderStyle = UITextField.BorderStyle.bezel
        pidView.keyboardType = UIKeyboardType.default
        pidView.returnKeyType = UIReturnKeyType.done
        pidView.clearButtonMode = UITextField.ViewMode.whileEditing
        pidView.textColor = .red
        self.addSubview(pidView)
        
        //距离
        curY = curY + Int(frame.size.height / CGFloat(control_height))
        KView = SelectView(frame: CGRect(x: curX, y: curY, width: Int(frame.size.width), height: Int(frame.size.height / CGFloat(control_height))))
        KView.setContents(labelTxt: "距离: ", cont: [
            "K0-0.3米~0.5米", "K1-1米~2米", "K2-4米~5米"
            ])
        self.addSubview(KView)
    }
    
    private func initRecordBtn() {
        recordBtn = UIButton(type: .custom)
        recordBtn.frame = CGRect(x: frame.size.width / 2 - 50, y: frame.size.height - 100, width: 100, height: 40)
        recordBtn.setTitleColor(.black, for: .normal)
        recordBtn.setTitle("RECORD", for: .normal)

        recordBtn.layer.cornerRadius = 6.0
        recordBtn.layer.borderColor = UIColor.blue.cgColor
        recordBtn.layer.borderWidth = 1.0

        self.addSubview(recordBtn)
    }
    
    //date time
    func getDateTime() -> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyyMMdd-HHmmss"
        
        let now = NSDate()
        return dformatter.string(from: now as Date)
    }
    
    //take flag
    func getFlag(param: String) -> String {
        if (!param.contains("-")) {
            return param
        }
        let array = param.split(separator: "-")
        return String(array[0])
    }
    
    //get file name
    func getFileName() -> String {
        let fileName = String(format: "%@_%@_%@(%@)_%@_%@_%@_%@_%@_%@_%@_PID%@.mp4",
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

}
