//
//  LSFileVC.swift
//  LimitedSpace
//
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LSFileVC: UIViewController {
    
    var itemId :Int?
    var displayType :LSFileDisplayType = .List
    
    @IBOutlet weak var ListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tileView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dispToggleBtn: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // cell の読み込み
        self.tableView.registerNib(UINib(nibName: "LSFileListCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "listCell")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/**
 *  Button Actions
 */
extension LSFileVC {
    @IBAction func dispToggleBtnTaped(sender: AnyObject) {
        switch self.displayType {
        case .List :
            self.displayType = .Tile
            self.dispToggleBtn.image = UIImage(named: "list")
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.ListView.alpha = 0
                self.tileView.alpha = 1
            })
            
        case .Tile :
            self.displayType = .List
            self.dispToggleBtn.image = UIImage(named: "tile")
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.ListView.alpha = 1
                self.tileView.alpha = 0
            })
        }
    }
    
}
 


/**
 *  UITableView delegate, datasourse
 */
extension LSFileVC :UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("listCell") as? LSFileListCell
        
        if cell == nil {
            cell = LSFileListCell(style: .Default, reuseIdentifier: "listCell")
        }
        
        switch indexPath.row {
        case 0...1 :
            cell!.fileNameLbl.text = "Folder \(indexPath.row+1)"
            cell!.accessoryType = .DisclosureIndicator
            cell!.backgroundColor = LSColor.getColor(.LightWhite)
            cell!.cellType = .Folder
            
        default :
            cell!.fileNameLbl.text = "File \(indexPath.row-1)"
            cell!.backgroundColor = LSColor.getColor(.White)
            cell!.cellType = .File
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? LSFileListCell else { return }
     
        switch cell.cellType {
        case .File :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("fileViewerVC") as? LSFileViewerVC
            guard let fileViewerVC :LSFileViewerVC = vc else { return }
            
            fileViewerVC.itemId = 1
            
            self.presentViewController(fileViewerVC, animated: false, completion: nil)
            
        case .Folder :
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LSFileListVC") as? LSFileVC
            guard let lsFileVC :LSFileVC = vc else { return }
            
            lsFileVC.itemId = 1
            
            self.navigationController?.pushViewController(lsFileVC, animated: true)
        }
    }
}


/**
 *  UICollectionView delegate, datasouse
 */
extension LSFileVC :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = collectionView.frame.size
        
        return CGSizeMake((size.width-50)/5, (size.width-50)/5)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        ?? UICollectionViewCell()
        
        cell.backgroundColor = LSColor.getColor(.White)
        
        
        let imageView = UIImageView(frame: cell.bounds)
        imageView.image = UIImage(named: "noImage")
        cell.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}