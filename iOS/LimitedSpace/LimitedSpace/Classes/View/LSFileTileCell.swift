//
//  LSFileTileCell.swift
//  LimitedSpace
//
//  Created by Ryunosuke Kirikihira on 2015/11/29.
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LSFileTileCell: UICollectionViewCell {

    var cellType :LSListCellType = .File
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
