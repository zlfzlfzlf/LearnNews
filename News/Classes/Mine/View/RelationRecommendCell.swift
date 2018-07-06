//
//  RelationRecommendCell.swift
//  News
//
//  Created by zlf on 2018/7/5.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class RelationRecommendCell: UICollectionViewCell, RegistterCellOrNib {

    var userCard = UserCard() {
        didSet {
            nameLabel.text = userCard.user.info.name
            avatarImageView.kf.setImage(with: URL(string: (userCard.user.info.avatar_url)))
            vImageView.isHidden = userCard.user.info.user_auth_info.auth_info == ""
            recommendReasonLabel.text = userCard.recommend_reason
        }
    }
    
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// V 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名称
    @IBOutlet weak var nameLabel: UILabel!
    /// 推荐原因
    @IBOutlet weak var recommendReasonLabel: UILabel!
    /// 加载 图标
    @IBOutlet weak var loadingImageView: UIImageView!
    /// 关注按钮
    @IBOutlet weak var concernButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 33.0
        avatarImageView.layer.masksToBounds = true
        concernButton.layer.cornerRadius = 5.0
        concernButton.layer.masksToBounds = true
        loadingImageView.isHidden = true
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel.theme_textColor = "colors.black"
        recommendReasonLabel.theme_textColor = "colors.black"
        theme_backgroundColor = "colors.cellBackgroundColor"
//        baseView.theme_backgroundColor = "colors.cellBackgroundColor"
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        
    }
    
    private lazy var animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = Double.pi * 2
        animation.duration = 1.5
        animation.autoreverses = false;
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        loadingImageView.isHidden = false
        loadingImageView.layer.add(animation, forKey: nil)
        if sender.isSelected {
            NetworkTool.loadRelationUnfollow(userId: userCard.user.info.user_id, completionHandler: { (_) in
                sender.isSelected = false
                sender.backgroundColor = UIColor.red
//                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                self.loadingImageView.isHidden = true
                self.loadingImageView.layer.removeAllAnimations()
//                sender.layer.borderColor = UIColor.grayColor232().cgColor
//                sender.layer.borderWidth = 1
            })
        }else {
            
            NetworkTool.loadRelationFollow(userId: (userCard.user.info.user_id), completionHandler: { (_) in
                sender.isSelected = true
                 sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
                sender.layer.borderColor = UIColor.grayColor232().cgColor
                sender.layer.borderWidth = 1
            })
        }
    }

}
