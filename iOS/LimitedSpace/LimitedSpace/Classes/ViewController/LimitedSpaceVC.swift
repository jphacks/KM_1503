//
//  LimitedSpaceVC.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LimitedSpaceVC: UIViewController {
    
    @IBOutlet weak var LSButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("LSItemTapedAction:"), name: LSNotification.LSItemTaped.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeLSButtonText"), name: LSNotification.MakedLS.rawValue, object: nil)

        
        
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
    
    func changeLSButtonText() {
        // LSButton's text
        let ud = NSUserDefaults.standardUserDefaults()
        if ud.objectForKey("userLS") != nil {
            self.LSButton.setTitle("管理", forState: .Normal)
        } else {
            self.LSButton.setTitle("作成", forState: .Normal)
        }
    }
    // -------------------------------------------------
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/**
 *  Button Actions
 */
extension LimitedSpaceVC {
    @IBAction func LSButtonTaped(sender: UIButton) {
        switch sender.titleLabel!.text! {
        case "作成" :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("makeLSVC")
            guard let makeLSVC = vc as? MakeLSVC else { return }
            
            self.presentViewController(makeLSVC, animated: true, completion: nil)
            
        case "管理" :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MyLSFileVC")
            guard let myLSFileVC = vc as? MyLSFileVC else { return }
            
            self.presentViewController(myLSFileVC, animated: true, completion: nil)
            
        default :
            return
        }
    }
    
}
