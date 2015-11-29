//
//  KRAdditions.swift
//
//  Copyright (c) 2015年 Krimpedance. All rights reserved.
//

import UIKit


/**
*  Synchronized Class ---------------------------------------------------------
*/
class AutoSync {
    let object :AnyObject
    
    init(obj :AnyObject) {
        object = obj
        objc_sync_enter(object)
    }
    
    deinit {
        objc_sync_exit(object)
    }
}


/**
*  UIView ---------------------------------------------------------
*/
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth :CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor :UIColor {
        get {
            return (layer.borderColor != nil) ? UIColor(CGColor: layer.borderColor!) : UIColor.whiteColor()
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    
    func cornerRadius(roundingCorners roundingCorners :UIRectCorner, radius :CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSizeMake(radius, radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        
        self.layer.mask = maskLayer
    }
}


/**
*  String ---------------------------------------------------------
*/
extension String {
    func urlEncodedString() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }

    func urlDecodedString() -> String {
        return self.stringByRemovingPercentEncoding!
    }
}


/**
*  UIColor ---------------------------------------------------------
*/
extension UIColor {
    // 0~255
    convenience init(intRed red :Int, green :Int, blue :Int, alpha :CGFloat) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha:alpha)
    }                                    
    
    convenience init(intRed red :Int, green :Int, blue :Int) {
        self.init(intRed: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // Hex
    convenience init(aHex :UInt32) {
        let r = Int32((aHex >> 24) & 0xFF)
        let g = Int32((aHex >> 16) & 0xFF)
        let b = Int32((aHex >> 8) & 0xFF)
        let a = Int32(aHex & 0xFF)
        
        self.init(intRed: Int(r), green: Int(g), blue: Int(b), alpha: CGFloat(a))
    }                                     
    
    convenience init(hex :UInt32) {
        let r = Int32((hex & 0xFF0000) >> 16)
        let g = Int32((hex & 0x00FF00) >> 8)
        let b = Int32(hex & 0x0000FF)
        
        self.init(intRed: Int(r), green: Int(g), blue: Int(b))
    }
    
    // Hex String
    convenience init(hexStr :String) {
        let str = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        
        let colorScanner = NSScanner(string: str)
        var color :UInt32 = 0
        colorScanner.scanHexInt(&color)

        self.init(hex: color)
    }
    
    convenience init(aHexStr :String) {
        let str = aHexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        
        let colorScanner = NSScanner(string: str)
        var color :UInt32 = 0
        colorScanner.scanHexInt(&color)

        self.init(hex: color)
    }
    
    // Random color
    class func getRandomColor(alpha :CGFloat) -> UIColor {
        let red = Int(arc4random_uniform(256))
        let green = Int(arc4random_uniform(256))
        let blue = Int(arc4random_uniform(256))
        
        return UIColor(intRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func getRandomColor() -> UIColor {
        let red = Int(arc4random_uniform(256))
        let green = Int(arc4random_uniform(256))
        let blue = Int(arc4random_uniform(256))
        
        return UIColor(intRed: red, green: green, blue: blue)
    }
}


/**
*  NSDictionary ---------------------------------------------------------
*/
extension NSDictionary {
    // @{ @"key":@"value", ...}   =>  "key=value&..." に変換
    func httpBuildQuery() -> String {
        // 再帰関数
        var buildQuery :((String, AnyObject) -> String)!
        buildQuery = { (key :String, value :AnyObject) -> String in
            var str = String()
            
            if(value is NSArray) {
                // arrayの場合
                var idx :Int = 0
                for element in (value as! NSArray) {
                    str += buildQuery(key + "[" + String(idx) + "]", element)
                    idx++
                }
            } else if (value is NSDictionary) {
                // dictionaryの場合
                let valueDict = value as! NSDictionary
                for element in (valueDict.allKeys as! [String]) {
                    str += buildQuery(key + "[" + element + "]", valueDict[element]!)
                }
            } else {
                str += key.urlEncodedString() + "=" + (value as! String).urlEncodedString() + "&"
            }
            
            return str
        }
        
        var str = ""
        for key in (self.allKeys as! [String]) {
            str += buildQuery(key, self[key]!)
        }
        
        // 最後の & は削除する
        str = str.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "&"))
        
        return str
    }
    
}


/**
* NSURL
*/
extension NSURL {
    // Query を [Key : Value, ....] に変換
    func parseParams() -> [String : String] {
        guard let queryPairs :[String] = self.query?.componentsSeparatedByString("&") else { return [:] }
        
        var querys :[String : String] = [:]
        
        for queryPair :String in queryPairs {
            let pairs = queryPair.componentsSeparatedByString("=")
            if pairs.count < 2 { continue }
            
            let key :String = pairs[0].urlDecodedString()
            let value :String  = pairs[1].urlDecodedString()
            
            querys[key] = value
        }

        return querys
    }
}