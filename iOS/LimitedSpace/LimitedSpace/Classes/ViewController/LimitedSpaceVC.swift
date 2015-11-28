//
//  LimitedSpaceVC.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LimitedSpaceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // DEBUG 
        self.mockCode()
    }
    
    
    func mockCode() {
        let item = LSItemView(frame: CGRectMake(100, 100, 80, 80))
        self.view.addSubview(item)
        let item2 = LSItemView(frame: CGRectMake(200, 200, 80, 80))
        self.view.addSubview(item2)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
