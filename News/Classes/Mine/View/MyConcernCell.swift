//
//  MyConcernCell.swift
//  News
//
//  Created by zlf on 2018/5/18.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher
class MyConcernCell: UICollectionViewCell, RegistterCellOrNib {
   
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var vipImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 新通知
    @IBOutlet weak var tipsButton: UIButton!
    var myConcern: MyConcern? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel.text = myConcern?.name
            if let isVerify = myConcern?.is_verify {
                vipImageView.isHidden = !isVerify
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        tipsButton.layer.cornerRadius = 5
        tipsButton.layer.masksToBounds = true
        
        // Initialization code
    }

}
