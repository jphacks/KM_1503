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
        
        // Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("LSItemTapedAction:"), name: LSNotification.LSItemTaped.rawValue, object: nil)

        
        // DEBUG 
        self.mockCode()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func mockCode() {
        let item = LSItemView(frame: CGRectMake(100, 100, 80, 80))
        self.view.addSubview(item)
        let item2 = LSItemView(frame: CGRectMake(200, 200, 80, 80))
        self.view.addSubview(item2)
    }
    
    
    // Notifications -----------------------------------
    func LSItemTapedAction(notif :NSNotification) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LSFileListVC") as? LSFileVC
        guard let lsFileVC :LSFileVC = vc else {
            return
        }
        
        lsFileVC.itemId = 1
        
        self.navigationController?.pushViewController(lsFileVC, animated: true)
    }
    // -------------------------------------------------
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
