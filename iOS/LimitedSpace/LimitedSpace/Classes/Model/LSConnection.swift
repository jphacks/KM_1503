//
//  LSConnection.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

enum LSAPI :String {
    case BaseUrl = "https://limited-space.herokuapp.com"
    case getLS = "/api/getLimitedSpaces"
    case registLS = "/api/createLimiSpe"
    
    static func getURL(api :LSAPI) -> String {
        return LSAPI.BaseUrl.rawValue + api.rawValue
    }
}

class LSConnection: NSObject {
    
    class func getLSItemWithAPI(location :CLLocation, handler :((data :NSDictionary)->Void)?) {
        let param = [
            "lat" : location.coordinate.latitude,
            "lng" : location.coordinate.longitude
        ]
        
        Alamofire.request(.GET, LSAPI.getURL(.getLS), parameters: param, encoding: .JSON, headers: nil).responseJSON { (req, res, result) -> Void in
            guard let data = result.data else { return }
            let json = JSON(data)
//            handler?(data: json)
        }
    }
    
    class func registLimitedSpace(handler :(()->Void)?) {
        
    }
}
