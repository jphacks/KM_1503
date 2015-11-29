//
//  MyLSFileVC.swift
//  LimitedSpace
//
//  Created by Ryunosuke Kirikihira on 2015/11/29.
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import Foundation
import UIKit

class MyLSFileVC: LSFileVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            cell?.removeFromSuperview()
//            tableView.reloadData()
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
