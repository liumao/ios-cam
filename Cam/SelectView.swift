//
//  SelectView.swift
//  Cam
//
//  Created by MakaloLau on 2020/12/16.
//  Copyright © 2020年 MakaloLau. All rights reserved.
//

import UIKit

class SelectView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //label和pick view比例
    let labelSize = 2
    let pickViewSize = 8
    
    var label: UILabel!
    var selector: UIPickerView!
    
    //select data
    var selectData: String!
    
    //contents
    var contents: [String]!
    
    override init(frame : CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置下拉框内容
    func setContents(labelTxt: String, cont: [String]) {
        //label标签
        label = UILabel(frame: CGRect(x: 5, y: 0,
                                      width: Int(frame.size.width * 0.2) - 5, height: Int(frame.size.height)))
        label.textColor = UIColor.gray
        label.text = labelTxt
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        
        //select下拉框
        selector = UIPickerView(frame: CGRect(x: Int(frame.size.width * 0.2) + 5, y: 0,
                                              width: Int(frame.size.width * 0.8) - 10, height: Int(frame.size.height)))
        selector.delegate = self
        selector.dataSource = self
        contents = cont
        self.addSubview(selector)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 16)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = contents[row]
        pickerLabel?.textColor = UIColor.blue
     
        return pickerLabel!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectData = contents[row]
        return selectData
    }
}
