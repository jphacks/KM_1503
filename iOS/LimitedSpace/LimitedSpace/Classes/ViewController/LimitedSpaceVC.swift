//
//  LimitedSpaceVC.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit
import CoreLocation

class LimitedSpaceVC: UIViewController {
    
    @IBOutlet weak var LSButton: UIButton!
    
    var locationManager:CLLocationManager?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("LSItemTapedAction:"), name: LSNotification.LSItemTaped.rawValue, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeLSButtonText"), name: LSNotification.MakedLS.rawValue, object: nil)

        // 現在地の取得.
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.locationManager?.startUpdatingLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        // DEBUG
        self.mockCode()
    }
    
    func setLSItem(data :NSDictionary) {
        
    }
    
    func mockCode() {
        let item = LSItemView(frame: CGRectMake(100, 100, 20, 20))
        item.center = CGPointMake(100, 100)
        item.alpha = 0
        self.view.addSubview(item)
        let item2 = LSItemView(frame: CGRectMake(200, 200, 80, 80))
        self.view.addSubview(item2)
        
        
        UIView.animateWithDuration(0.3) { () -> Void in
            item.alpha = 1
            var frame = item.frame
            frame.size.width = 80
            frame.size.height = 80
            item.frame = frame
            frame.origin = CGPointMake(0, 0)
            item.subviews[0].frame = frame
            item.subviews[0].layer.cornerRadius = frame.size.width/2
            item.center = CGPointMake(100, 100)
        }
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



extension LimitedSpaceVC :CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
    
        LSConnection.getLSItemWithAPI(location) { (data) -> Void in
            print(data)
        }
    }
}