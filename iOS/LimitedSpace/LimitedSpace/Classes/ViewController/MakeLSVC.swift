//
//  MakeLSVC.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class MakeLSVC: UIViewController {
    
    @IBOutlet weak var LSImageBtn: UIButton!
    @IBOutlet weak var LSNameTF: UITextField!
    @IBOutlet weak var LSRangeBtn: UIButton!
    @IBOutlet weak var LSTimeBtn: UIButton!
    
    var pickData :[String]?
    var pickerType :PickerType = .Range

    override func viewDidLoad() {
        super.viewDidLoad()

        self.LSNameTF.delegate = self
    }

    
    // DataをもとにpickeViewを生成，表示
    func makeAndDispPickerViewWithData(type :PickerType, data :[String]) {
        self.pickerType = type
        self.pickData = data
        
        var frame  = self.view.bounds
        frame.origin.y = frame.height - 200
        frame.size.height = 200
        
        let pickerView = UIPickerView(frame: frame)
        pickerView.backgroundColor = LSColor.getColor(.White)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 100
        self.view.addSubview(pickerView)
        
        // 完了ボタン用View
        frame.origin.y -= 30
        frame.size.height = 30
        let compView = UIView(frame: frame)
        compView.backgroundColor = LSColor.getColor(.White)
        compView.tag = 100
        self.view.addSubview(compView)
        
        // 完了ボタン
        let compBtn = UIButton(frame: CGRectMake(frame.width-100, 0, 100, 30))
        compBtn.setTitle("完了", forState: .Normal)
        compBtn.setTitleColor(LSColor.getColor(.DarkBlue), forState: .Normal)
        compBtn.addTarget(self, action: Selector("compBtnTaped"), forControlEvents: .TouchUpInside)
        compBtn.tag = 100
        compView.addSubview(compBtn)
        
        
        // pickerView 初期値
        var row = 0
        switch type {
        case .Range :
            for var i=0; i<data.count; i++ {
                let str = data[i]
                let range = self.LSRangeBtn.titleLabel?.text?.stringByReplacingOccurrencesOfString("m", withString: "")
                
                if range == str { row = i }
            }
        case .Time :
            for var i=0; i<data.count; i++ {
                let str = data[i]
                let time = self.LSTimeBtn.titleLabel?.text?.stringByReplacingOccurrencesOfString("分", withString: "")
                
                if time == str { row = i }
            }
        }
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    func removePickerView() {
        for view in self.view.subviews {
            if view.tag != 100 { continue }
            
            view.removeFromSuperview()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/**
 *  Button Action
 */
extension MakeLSVC {
    @IBAction func LSImageBtnTaped(sender: AnyObject) {
    }
    
    @IBAction func LSRangeBtnTaped(sender: AnyObject) {
        let data = ["50", "200", "400", "800", "1000"]
        self.makeAndDispPickerViewWithData(.Range, data: data)
    }
    
    @IBAction func LSTimeBtnTaped(sender: AnyObject) {
        var data :[String] = []
        for (var i=10; i<=180; i=i+10) {
            data.append("\(i)")
        }
        
        self.makeAndDispPickerViewWithData(.Time, data: data)
    }
    
    @IBAction func cancelBtnTaped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func makeBtnTaped(sender: AnyObject) {
        guard let text = self.LSNameTF.text else { return }
        let title = text.stringByReplacingOccurrencesOfString(" ", withString: "")
        if title == "" { return }
        guard let rangeStr = self.LSRangeBtn.titleLabel?.text else { return }
        guard let timeStr = self.LSTimeBtn.titleLabel?.text else { return }
        
        let range = Int(rangeStr.stringByReplacingOccurrencesOfString("m", withString: "")) ?? 0
        let time = Int(timeStr.stringByReplacingOccurrencesOfString("分", withString: "")) ?? 0
        
        let ls = LimitedSpaceModel(title: title, range: range, time: time)
        let lsData = NSKeyedArchiver.archivedDataWithRootObject(ls)
        
        NSUserDefaults.standardUserDefaults().setObject(lsData, forKey: "userLS")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.dismissViewControllerAnimated(true) {
            NSNotificationCenter.defaultCenter().postNotificationName(LSNotification.MakedLS.rawValue, object: nil)
        }
    }
    
    func compBtnTaped() {
        self.removePickerView()
    }
}


/**
 *  TextField Delegate
 */
extension MakeLSVC :UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.LSNameTF.endEditing(true)
        return false
    }
}


/**
 *  PickerView Delegate, Datasource
 */
extension MakeLSVC :UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickData?.count ?? 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickData?[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = self.pickData else { return }
        
        let rowStr = data[row]
        switch self.pickerType {
        case .Range :
            self.LSRangeBtn.setTitle("\(rowStr)m", forState: .Normal)
            
        case .Time :
            self.LSTimeBtn.setTitle("\(rowStr)分", forState: .Normal)
        }
    }
}