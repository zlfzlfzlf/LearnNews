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
            nameLabel.text = dongtai.user.screen_name
            likeButton.setTitle(dongtai.diggCount, for: .normal)
            commentButton.setTitle(dongtai.commentCount, for: .normal)
//            areaLabel.text = dongtai.po
            readCountLabel.text = dongtai.readCount + "阅读"
            contentLabel.text = dongtai.content
            contentLabelHeight.constant = dongtai.contentH
            allContentLabel.isHidden = dongtai.contentH > 110 ? false:true
            switch dongtai.item_type {
            case .postVideoOrArticle, .postVideo, .answerQuestion, .proposeQuestion, .forwardArticle, .postContentAndVideo:
                print("")
                
                case .postContent, .postSmallVideo: // 发布了文字内容:
                print("")
            case .commentOrQuoteContent, .commentOrQuoteOthers: // 引用或评论
                print("")
           
            }

            layoutIfNeeded()
            
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
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    
    @IBOutlet weak var separatorView2: UIView!
    // 内容
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    // 全文
    @IBOutlet weak var allContentLabel: UILabel!
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
