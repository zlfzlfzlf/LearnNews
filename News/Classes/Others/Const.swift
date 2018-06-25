//
//  Const.swift
//  News
//
//  Created by zlf on 2018/5/3.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let Base_URL = "https://is.snssdk.com"
let device_id: Int = 6096495334
let iid: Int = 5034850950

let kMyHeaderViewHeight:CGFloat = 280
let isIPhoneX: Bool = screenHeight == 812 ? true : false
let newsTitleHeight: CGFloat = 40
let kUserDetailHeaderBGImageViewHeight: CGFloat = 146
let isNight = "isNight"

/// 关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth: CGFloat = screenWidth * 0.2
/// 关注的用户详情界面 topTab 的指示条的宽度 和 高度
let topTabindicatorWidth: CGFloat = 40
let topTabindicatorHeight: CGFloat = 2

func RGBColorFromHex(rgbValue: Int) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,alpha: 1.0)
    
}
