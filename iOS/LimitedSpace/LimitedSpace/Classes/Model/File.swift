//
//  File.swift
//  LimitedSpace
//
//  Created by Ryunosuke Kirikihira on 2015/11/28.
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import Foundation


class Controller {
    func getInfo() {
        let paths = ["/AA/BB/mp4", "/AA/zip", "rar"]
        
        var data :
        for path in paths {
            data = Model.fileInfo(path)
        }
    }
}


class Model {
    class func fileInfo(path :String) -> [String:AnyObject] {
        
        
        return [:]
    }
}