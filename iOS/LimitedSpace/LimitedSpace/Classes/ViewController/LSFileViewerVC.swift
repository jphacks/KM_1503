//
//  LSFileViewerVC.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LSFileViewerVC: UIViewController {
    
    var itemId :Int?
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/**
 *  Button Actions
 */
extension LSFileViewerVC {
    @IBAction func closeBtnTaped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func downloadBtnTaped(sender: AnyObject) {
        // TODO: 未実装
    }
}