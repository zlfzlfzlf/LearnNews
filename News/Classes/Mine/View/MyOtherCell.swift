//
//  MyOtherCell.swift
//  News
//
//  Created by zlf on 2018/5/8.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell, RegistterCellOrNib {

    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 设置主题
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImage.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
