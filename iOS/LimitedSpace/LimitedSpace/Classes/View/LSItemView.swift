//
//  LSItemView.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LSItemView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nib = UINib(nibName: "LSItemView", bundle: nil)
        let view = nib.instantiateWithOwner(self, options: nil).first as? UIView ?? UIView()
        view.frame = self.bounds
        self.addSubview(view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("hoge")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
