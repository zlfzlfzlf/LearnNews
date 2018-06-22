//
//  UserDetail.swift
//  News
//
//  Created by zlf on 2018/6/15.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import HandyJSON

enum TopTabType: String, HandyJSONEnum {
    case dongtai = "dongtai"                            // 动态
    case article = "all"                                // 文章
    case video = "video"                                // 视频
    case wenda = "wenda"                                // 问答
    case iesVideo = "ies_video"                         // 小视频
    //    case matrix_atricle_list = "matrix_atricle_list"    // 发布厅
    //    case matrix_media_list = "matrix_media_list"        // 矩阵
}

struct UserDetail: HandyJSON {
    
    var screen_name: String = ""
    var name: String = ""
    
    var big_avatar_url: String = "" // 头像
    var avatar_url: String = ""
    
    var status: Int = 0
    
    var is_followed: Bool = false
    var is_following: Bool = false // 是否正在关注
    
    var current_user_id: Int = 0
    
    var media_id: Int = 0               // 1554769814257666
    var ugc_publish_media_id: Int = 0   // 1576963425007630
    var user_id: Int = 0                // 53271122458
    var creator_id: Int = 0             // 53271122458
    
    var description: String = "" // 考研规划“神嘴”张雪峰老师。
    var descriptionHeight: CGFloat {
        let sized = description.boundingRect(with: CGSize(width: screenWidth - 30, height: CGFloat(MAXFLOAT)), font: UIFont.boldSystemFont(ofSize: 13))
        
        return sized.height
    }
    
//    var attributedDescription: NSAttributedString {
//        let emojimanager = EmojiManager()
//        return emojimanager.showEmoji(content: description, font: UIFont.systemFont(ofSize: 13))
//    }
//    // screeenWidth - (15 + 15 + 40 + 5)
//    var descriptionHeight: CGFloat { return Calculate.textHeight(text: description, fontSize: 13, width: screenWidth - 30.0) }
    
    var apply_auth_url: String = "" // sslocal://apply_user_auth_info
    
    var bottom_tab: [BottomTab] = [BottomTab]()
    var top_tab: [TopTab] = [TopTab]()
    
    var bg_img_url: String = ""
    
    var verified_content: String = ""
    var user_verified: Bool = false
    
    var verified_agency: String = "" // 头条认证
    
    var is_blocking: Bool = false
    var is_blocked: Bool = false
    
    var gender: Int = 0
    
    var share_url: String = ""
    
    var followers_count: Int = 0// 粉丝 470837
    var followersCount: String { return followers_count.convertString() }
    
    var followings_count: Int = 0 // 关注 3
    var followingsCount: String { return followings_count.convertString() }
    
    var media_type: Int = 0
    
    var area: String = ""
    
    var user_auth_info = UserAuthInfo()
}
struct TopTab: HandyJSON {
    
    var url: String = ""
    
    var is_default: Bool = false
    
    var show_name: String = "" // 动态 文章 视频 问答
    
    var type: TopTabType = .dongtai
    
}
// MARK: 用户详情底部 tab
struct BottomTab: HandyJSON {
    
    var type: String = "" // href
    
    var name: String = ""
    
    var value: String = ""
    
    var children: [BottomTabChildren] = [BottomTabChildren]()
    
}

struct BottomTabChildren: HandyJSON {
    
    var schema_href: String = "" // sslocal://webview?url=http%3A%2F%2Fwww.guanfumuseum.org.cn%2F
    
    var type: String = "" // href
    
    var name: String = ""
    
    var value: String = "" // http://www.guanfumuseum.org.cn/
}


struct ConcernUser: HandyJSON {
    var is_followed: Bool = false
    var is_following: Bool = false // 是否正在关注
    var media_id: Int = 0               // 1554769814257666
    
    var create_time: TimeInterval = 0
    
    var user_verified: Bool = false
    
    var screen_name: String = "" // 考研张雪峰
    var name: String = "" // 考研张雪峰
    
    var user_id: Int = 0                // 53271122458
    
    var last_update: String = ""
    
    var avatar_url: String = ""
    
    var user_auth_info = UserAuthInfo()
    
    var type: Int = 0
}

struct UserCard: HandyJSON {
    
    var name: String = ""
    
    var recommend_reason: String = ""
    
    var recommend_type: Int = 0
    
//    var user: UserCardUser = UserCardUser()
    
    var stats_place_holder: String = ""
    
}

struct UserCardUser: HandyJSON {
    var info = UserCardUserInfo()
    var relation: UserCardUserRelation = UserCardUserRelation()
}

struct UserCardUserInfo: HandyJSON {
    
    var name: String = ""
    
    var user_id: Int = 0
    
    var avatar_url: String = ""
    
    var desc: String = ""
    
    var schema: String = ""
    
    var user_auth_info = UserAuthInfo()
}

// MARK: 相关推荐的用户是否关注模型
struct UserCardUserRelation: HandyJSON {
    
    var is_followed: Bool = false
    
    var is_following: Bool = false
    
    var is_friend: Bool = false
    
}

extension String {
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedStringKey.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
}

extension Int {
    
    func convertString() -> String {
        guard self >= 10000 else {
            return String(describing: self)
        }
        return String(format: "%.1f万", Float(self) / 10000.0)
    }
    
    /// 将秒数转成字符串
    func convertVideoDuration() -> String {
        // 格式化时间
        if self == 0 { return "00:00" }
        let hour = self / 3600
        let minute = (self / 60) % 60
        let second = self % 60
        if hour > 0 { return String(format: "%02d:%02d:%02d", hour, minute, second) }
        return String(format: "%02d:%02d", minute, second)
    }
    
}



