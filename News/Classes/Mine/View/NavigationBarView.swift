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
    
    @IBOutlet weak var iphoneHeitht: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var nameLabel: UILabel!
    /// 关注按钮
//    @IBOutlet weak var concernButton: AnimatableButton!
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
    override func awakeFromNib() {
        if !isIPhoneX {
            iphoneHeitht.constant = 20.0
        }else {
            iphoneHeitht.constant = 44.0
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        height = navigationBar.frame.maxY
    }

}
