//
//  UserDetailHeaderView.swift
//  News
//
//  Created by zlf on 2018/6/14.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailHeaderView: UIView {
    var userdetail: UserDetail? {
        didSet {
//            print(userdetail?.bg_img_url)
            backgroundImageView.kf.setImage(with: URL(string: userdetail!.bg_img_url)!)
            avatarImageView.kf.setImage(with: URL(string: (userdetail?.avatar_url)!))
            vImageView.isHidden = !(userdetail?.user_verified)!
            nameLabel.text = userdetail?.screen_name
            if userdetail!.verified_agency == "" {
                verifiedAgencyLabelHeight.constant = 0
                verifiedAgencyLabelTop.constant = 0
            } else {
                verifiedAgencyLabel.text = userdetail!.verified_agency + "："
                verifiedContentLabel.text = userdetail!.verified_content
            }
            concernButton.isSelected = (userdetail?.is_following)!
//            concernButton.theme_backgroundColor = (userdetail?.is_following)! ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.backgroundColor = (userdetail?.is_following)! ? UIColor.gray : UIColor.blue
            concernButton.setTitle("已关注", for: .selected)
            
            
//            self.concernButton.layer.borderWidth = 1.0
//            self.concernButton.layer.borderColor = (userdetail?.is_following)! ? UIColor.grayColor232() as! CGColor : UIColor.globalRedColor() as! CGColor
            if userdetail!.area == "" {
                areaButton.isHidden = true
                areaButtonHeight.constant = 0
                areaButtonTop.constant = 0
            } else {
                areaButton.setTitle(userdetail!.area, for: .normal)
            }
            
            descriptionLabel.text = userdetail?.description
            if userdetail!.descriptionHeight > CGFloat(21) {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40.0
            }else {
                unfoldButton.isHidden = true
                unfoldButtonWidth.constant = 0
            }
            
            // 推荐按钮的约束
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10.0
            followersCountLabel.text = userdetail!.followersCount
            followingsCountLabel.text = userdetail!.followingsCount
            
            layoutIfNeeded()
        }
    }
    /// 背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    /// 背景图片顶部约束
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    /// 用户头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// V 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 头条号图标
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    /// 发私信按钮
    @IBOutlet weak var sendMailButton: UIButton!
    /// 关注按钮
    @IBOutlet weak var concernButton: UIButton!
    /// 推荐按钮
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendButtonTrailing: NSLayoutConstraint!
    /// 推荐 view
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    /// 头条认证
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var verifiedAgencyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    /// 认证内容
    @IBOutlet weak var verifiedContentLabel: UILabel!
    /// 地区
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    /// 描述内容
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    /// 展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    /// 关注数量
    @IBOutlet weak var followingsCountLabel: UILabel!
    /// 粉丝数量
    @IBOutlet weak var followersCountLabel: UILabel!
    
    // 文章 视频 问答
    @IBOutlet weak var topTabView: UIView!
    @IBOutlet weak var topTabHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    /// 底层 view
    @IBOutlet weak var baseView: UIView!
    
    
    /// 底部的 ScrollView
//    @IBOutlet weak var bottomScrollView: UIScrollView!
    class func headerViewXIB() -> UserDetailHeaderView {
        let view = Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserDetailHeaderView
//        view = UserDetailHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        return view
        
    }
    override func awakeFromNib() {
        self.avatarImageView.layer.cornerRadius = 36
        self.avatarImageView.layer.masksToBounds = true
//        print(userdetail?.bg_img_url)

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
