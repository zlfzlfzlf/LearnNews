//
//  NavigationBarView.swift
//  News
//
//  Created by zlf on 2018/7/2.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class NavigationBarView: UIView, NibLoadable {

    var goBackButtonClicked:(() -> ())?
    var userDetail: UserDetail? {
        didSet {
            nameLabel.text = userDetail!.screen_name
            concernButton.isSelected = userDetail!.is_following
            concernButton.theme_backgroundColor = userDetail!.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
//            self.concernButton.layer.borderWidth = 1.0
            
            
//            concernButton.layer.borderWidth = userDetail!.is_following ? 1 : 0
        }
    }
    
    
    @IBOutlet weak var iphoneHeitht: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var nameLabel: UILabel!
    /// 关注按钮
    @IBOutlet weak var concernButton: UIButton!
    /// 导航栏栏
    @IBOutlet weak var navigationBar: UIView!
    /// 返回按钮
    @IBOutlet weak var returnButton: UIButton!
    /// 更多按钮
    @IBOutlet weak var moreButton: UIButton!
    
    /// 返回按钮点击
    @IBAction func returnButtonClicked(_ sender: UIButton) {
        print("1246")
        goBackButtonClicked!()
    }
    
    /// 更多按钮点击
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        print("1246")
    }
    
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        if sender.isSelected { // 已经关注，点击则取消关注
            // 已关注用户，取消关注
            NetworkTool.loadRelationUnfollow(userId: userDetail!.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.globalRedColor"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NavigationBarConcernButtonClicked), object: self, userInfo: ["isSelected": sender.isSelected])
            })
        }else { // 未关注，点击则关注这个用户
            // 点击关注按钮，关注用户
            NetworkTool.loadRelationFollow(userId: userDetail!.user_id, completionHandler: { (_) in
                sender.isSelected = !sender.isSelected
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NavigationBarConcernButtonClicked), object: self, userInfo: ["isSelected": sender.isSelected])
            })
        }
    }
    override func awakeFromNib() {
        if !isIPhoneX {
            iphoneHeitht.constant = 20.0
        }else {
            iphoneHeitht.constant = 44.0
        }
        theme_backgroundColor = "colors.cellBackgroundColor"
        returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
        moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedConcernButtonClicked), name: NSNotification.Name(rawValue: UserDetailHeaderViewButtonClicked), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigationBar.frame.maxY
    }

}

extension NavigationBarView {
    @objc private func receivedConcernButtonClicked(notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let isSelected = userInfo["isSelected"] as! Bool
        concernButton.isSelected = isSelected
        concernButton.theme_backgroundColor = isSelected ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
        
    }
}
