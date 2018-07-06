//
//  UserDetailHeaderView.swift
//  News
//
//  Created by zlf on 2018/6/14.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailHeaderView: UIView, NibLoada, UIScrollViewDelegate {
    /// 当前选中的 topTab 的索引，点击了第几个
    var currentSelectedIndex = 0
    
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
            scrollView.delegate = self;
            // 推荐按钮的约束
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10.0
            followersCountLabel.text = userdetail!.followersCount
            followingsCountLabel.text = userdetail!.followingsCount
            
            if userdetail!.top_tab.count > 0 {
                for (index, topTab) in (userdetail?.top_tab.enumerated())!{
                    let button = UIButton(frame: CGRect(x: CGFloat(index) * topTabButtonWidth, y: 0, width: topTabButtonWidth, height: scrollView.height))
                    button.setTitle(topTab.show_name, for: .normal)
                    button.theme_setTitleColor("colors.black", forState: .normal)
                    button.theme_setTitleColor("colors.globalRedColor", forState: .selected)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    button.tag = index
                    button.addTarget(self, action: #selector(topTabButtonClicked), for: .touchUpInside)
                    scrollView.addSubview(button)
                    if index == 0 {
                        button.isSelected = true
                        privorButton = button
                    }
                }
                scrollView.addSubview(indicatorView)
            }else {
                topTabHeight.constant = 0
                topTabView.isHidden = true
            }
            
            layoutIfNeeded()
        }
    }
    
    private lazy var indicatorView: UIView = {
       let indicatorView = UIView()
        indicatorView.frame = CGRect(x: (topTabButtonWidth - topTabindicatorWidth) * 0.5 , y: topTabView.height - 3, width: topTabindicatorWidth, height: topTabindicatorHeight)
        indicatorView.theme_backgroundColor = "colors.globalRedColor"
        return indicatorView
    }()
    
    private lazy var relationRecommendView: RelationRecommendView = {
        let relationRecommendView = RelationRecommendView.loadViewFromNib()
        return relationRecommendView
    }()
    
    
    weak var privorButton = UIButton()
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
//    class func headerViewXIB() -> UserDetailHeaderView {
//        let view = Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! UserDetailHeaderView
////        view = UserDetailHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        return view
//
//    }
    override func awakeFromNib() {
        self.avatarImageView.layer.cornerRadius = 36
        self.avatarImageView.layer.masksToBounds = true
//        print(userdetail?.bg_img_url)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        // 设置主题颜色
        theme_backgroundColor = "colors.cellBackgroundColor"
        baseView.theme_backgroundColor = "colors.cellBackgroundColor"
        avatarImageView.layer.theme_borderColor = "colors.cellBackgroundColor"
        topTabView.theme_backgroundColor = "colors.cellBackgroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        nameLabel.theme_textColor = "colors.black"
        sendMailButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        followersCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        followingsCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        verifiedAgencyLabel.theme_textColor = "colors.verifiedAgencyTextColor"
        verifiedContentLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        toutiaohaoImageView.theme_image = "images.toutiaohao"
        areaButton.theme_setTitleColor("colors.black", forState: .normal)

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("123465798")
    }
   

}

extension UserDetailHeaderView {
   
   @objc func topTabButtonClicked(button: UIButton){
    privorButton?.isSelected = false
    button.isSelected = !button.isSelected
    UIView.animate(withDuration: 0.25, animations: {
        self.indicatorView.centerX = button.centerX
//        self.bottomScrollView.contentOffset = CGPoint(x: CGFloat(button.tag) * screenWidth, y: 0)
    }) { (_) in
        self.privorButton = button
    }
    // 获取索引
    currentSelectedIndex = button.tag
    // 取出 当前点击的 topTab, 赋值给 currentTopTabType
    
    
    }
    /// 发私信按钮点击
    @IBAction func sendMailButtonClicked() {
        
        let moreLogin = MoreLoginViewController()
        UIApplication.shared.keyWindow?.rootViewController?.present(moreLogin, animated: true, completion: {
            
        })
        
    }
    
    /// 关注按钮点击
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        if sender.isSelected {
            NetworkTool.loadRelationUnfollow(userId: (userdetail?.user_id)!, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.globalRedColor"
                self.recommendButton.isHidden = true
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 0
                self.recommendButtonTrailing.constant = 0
                self.recommendViewHeight.constant = 0
                UIView.animate(withDuration: 0.25, animations: {
                    ///让图片复位，防止下次点击，出现错乱
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                })
            })
        }else {
            NetworkTool.loadRelationFollow(userId: (userdetail?.user_id)!, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                sender.backgroundColor = UIColor.gray
//                sender.borderColor = .grayColor232()
//                sender.borderWidth = 1
                self.recommendButton.isHidden = false
                self.recommendButton.isSelected = false
                self.recommendButtonWidth.constant = 28.0
                self.recommendButtonTrailing.constant = 15.0
                self.recommendViewHeight.constant = 233
                UIView.animate(withDuration: 0.25, animations: {
                    self.layoutIfNeeded()
                }, completion: { (_) in
                    NetworkTool.loadRelationUserRecommend(userId: (self.userdetail?.user_id)!, completionHandler: { (userCard) in
                        self.recommendView.addSubview(self.relationRecommendView)
                        self.relationRecommendView.userCards = userCard
                    })
                })
            })
        }
    }
    /// 推荐关注按钮点击
    @IBAction func recommendButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        recommendViewHeight.constant = sender.isSelected ? 0 : 233.0
        
        UIView.animate(withDuration: 0.25, animations: {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
        })
    }
    
    
    
    /// 展开按钮点击
    @IBAction func unfoldButtonClicked() {
        unfoldButton.isHidden = true
        unfoldButtonWidth.constant = 0
      
        descriptionLabelHeight.constant = userdetail!.descriptionHeight + 10
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }) { (height) in
//            self.baseView.height = self.topTabView.frame.maxY
//            height = baseView.frame.maxY
        }
    }
    
    
}
