//
//  LimitedSpaceModel.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import Foundation

class LimitedSpaceModel :NSObject {
    let itemId :Int
    let title :String
    let range :Int
    let createDate :NSDate
    var time :Int
    
    init(title :String, range :Int, time :Int) {
        self.title = title
        self.range = range
        self.time = time
        
        self.createDate = NSDate()
        self.itemId = 0
    }
    
    @objc required init(coder aDecoder :NSCoder) {
        self.itemId = aDecoder.decodeIntegerForKey("itemId")
        self.title = aDecoder.decodeObjectForKey("title") as? String ?? ""
        self.range = aDecoder.decodeIntegerForKey("range")
        self.createDate = aDecoder.decodeObjectForKey("createDate") as? NSDate ?? NSDate()
        self.time = aDecoder.decodeIntegerForKey("time")
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.itemId, forKey: "itemId")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeInteger(self.range, forKey: "range")
        aCoder.encodeObject(self.createDate, forKey: "createDate")
        aCoder.encodeInteger(self.time, forKey: "time")
    }
}