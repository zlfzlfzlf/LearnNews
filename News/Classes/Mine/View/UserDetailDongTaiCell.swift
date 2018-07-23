//
//  UserDetailDongTaiCell.swift
//  News
//
//  Created by zlf on 2018/7/18.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit


class UserDetailDongTaiCell: UITableViewCell, RegistterCellOrNib {
    var dongtai = UserDetailDongtai() {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: dongtai.user.avatar_url))
            
        }
    }
    
    
    
    @IBOutlet weak var separatorView: UIView!
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 修改时间
    @IBOutlet weak var modifyTimeLabel: UILabel!
    /// 更多按钮
    @IBOutlet weak var moreButton: UIButton!
    /// 喜欢按钮
    @IBOutlet weak var likeButton: UIButton!
    /// 评论按钮
    @IBOutlet weak var commentButton: UIButton!
    /// 转发按钮
    @IBOutlet weak var forwardButton: UIButton!
    /// 位置，阅读数量
//    @IBOutlet weak var areaLabel: UILabel!
//    @IBOutlet weak var readCountLabel: UILabel!
//    
//    @IBOutlet weak var separatorView2: UIView!
    /// 内容
//    @IBOutlet weak var contentLabel: RichLabel!
//    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    /// 全文
//    @IBOutlet weak var allContentLabel: UILabel!
    /// 中间的 view
    @IBOutlet weak var middleView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
