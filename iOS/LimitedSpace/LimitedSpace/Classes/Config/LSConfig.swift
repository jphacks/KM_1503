//
//  LSConfig.swift
//  LimitedSpace
//
//  Created by Ryunosuke Kirikihira on 2015/11/28.
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import Foundation
import UIKit


enum LSColor {
    case LightBlue
    case DarkBlue
    case White
    case Pink
    
    static func getColor(color :LSColor) -> UIColor {
        switch color {
        case .LightBlue :
            return UIColor(hexStr: "81DCFA")
            
        case .DarkBlue :
            return UIColor(hexStr: "2C3E4F")
            
        case .White :
            return UIColor(hexStr: "F6F5F2")
            
        case .Pink :
            return UIColor(hexStr: "FF91A8")
        }
    }
}


class LSConfig {
    
}