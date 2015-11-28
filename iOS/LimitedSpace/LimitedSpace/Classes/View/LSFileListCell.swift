//
//  LSFileListCell.swift
//  LimitedSpace
//
//  Created by Ryunosuke Kirikihira on 2015/11/28.
//  Copyright © 2015年 Ryunosuke Kirikihira. All rights reserved.
//

import UIKit

class LSFileListCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var fileNameLbl: UILabel!
    
    var cellType :LSListCellType = .File
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
