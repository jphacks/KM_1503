//
//  LSBackgroundView.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

@IBDesignable
class LSBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let size = self.frame.size
        
        let path = UIBezierPath()
        LSColor.getColor(.LightBlue).setStroke()
        
        // horizonatal line
        for var i=0; CGFloat(30+i*50)<size.height; i++ {
            let y = CGFloat(30+i*50)
            path.moveToPoint(CGPointMake(0, y))
            path.addLineToPoint(CGPointMake(size.width, y))
        }
        
        // vertical line
        for var i=0; CGFloat(20+i*70)<size.height; i++ {
            let x = CGFloat(20+i*70)
            path.moveToPoint(CGPointMake(x, 0))
            path.addLineToPoint(CGPointMake(x, size.height))
        }
        
        path.stroke()

        
    }

}
