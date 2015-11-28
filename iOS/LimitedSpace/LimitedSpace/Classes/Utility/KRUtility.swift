//
//  KRUtility.swift
//
//  Copyright (c) 2015年 Krimpedance. All rights reserved.
//

import SystemConfiguration
import SafariServices


class KRUtility {
    /**
    タイトル，テキスト付きの情報ダイアログを出力する
    
    :param: title 表示するタイトル
    :param: text  表示するテキスト
    :param: del   アタッチするデリゲート
    :param: handler クロージャ
    */
    class func infoDialog(title title: String, message:String, delegate:AnyObject, handler:((action :UIAlertAction) -> Void)?) {
        // アラートビューの生成
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //Cancel 一つだけしか指定できない
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: {(action) -> Void in
            handler?(action: action)
        })
        
        alert.addAction(cancelAction)
        
        delegate.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /**
    タイトル,テキスト付きの複数選択肢のダイアログを出力する
    
    :param: title      表示するタイトル
    :param: text       表示するテキスト
    :param: cancelText キャンセルボタンのテキスト
    :param: otherTexts その他のボタンのテキストの配列
    :param: tag        アラートのタグ
    :param: del        アタッチするデリゲート
    */
    class func infoDialog(title title: String, message: String, cancelText: String, others: NSArray, delegate:AnyObject, handler:((action :UIAlertAction) -> Void)?) {
        // アラートビューの生成
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //Cancel 一つだけしか指定できない
        let cancelAction = UIAlertAction(title: cancelText, style: UIAlertActionStyle.Cancel, handler: {(action) -> Void in
            if (handler != nil) {
                handler!(action: action)
            }
        })
        alert.addAction(cancelAction)
        
        for var i=0; i<others.count; i++ {
            let text = others[i] as! String
            let buttonAction = UIAlertAction(title: text, style: UIAlertActionStyle.Default, handler: {(action) -> Void in
                handler?(action: action)
            })
            alert.addAction(buttonAction)
        }
        
        delegate.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /**
    ネットワークに接続されているか判定する
    
    :returns: ネットワークに接続されている -> true
    */
    class func isConnectNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let reachability = withUnsafePointer(&zeroAddress) { SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)) }
        
        var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
       
        if !SCNetworkReachabilityGetFlags(reachability!, &flags) { return false }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    
        return (isReachable && !needsConnection)
    }
    
    
    /**
    指定URLへのブラウザアクセス
    */
    class func webTo(url url :NSURL) {
        webTo(url: url, delegate: nil)
    }
    
    class func webTo(url url :NSURL, delegate :AnyObject?) {
        guard #available(iOS 9.0, *) else {
            UIApplication.sharedApplication().openURL(url)
            return
        }

        if delegate == nil {
            UIApplication.sharedApplication().openURL(url)
            return
        }
        
        let safariVC = SFSafariViewController(URL:url)
        delegate?.presentViewController(safariVC, animated: true, completion: nil)
    }
}