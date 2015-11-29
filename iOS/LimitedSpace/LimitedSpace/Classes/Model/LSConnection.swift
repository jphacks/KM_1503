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
    case registLS = "/api/createLimitedSpace"
    
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
    
    class func registLimitedSpace(data :[String:AnyObject], handler :(()->Void)?) {
        let name = data["name"] as? String
        let span = data["span"] as? Int
        let radius = data["radius"] as? Int
        let lat = data["lat"] as? Double
        let lng = data["lng"] as? Double
        let icon = data["icon"] as? NSData
        
        guard case (_?, _?, _?, _?, _?, _?) = (name, span, radius, lat, lng, icon) else { return }
        
        let param :[String:AnyObject] = [
            "name" : name!,
            "span" : span!,
            "radius" : radius!,
            "lat" : lat!,
            "lng" : lng!,
//            "icon" : icon!,
            "icon_type" : 0
        ]
        
        Alamofire.request(.POST, LSAPI.getURL(.registLS), parameters: param, encoding: .JSON, headers: nil).responseJSON { (req, res, result) -> Void in
            print(res)
            
        }
    }
}
