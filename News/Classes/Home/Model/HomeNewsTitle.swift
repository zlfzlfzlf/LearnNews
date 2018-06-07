//
//  HomeNewsTitle.swift
//  News
//
//  Created by zlf on 2018/6/7.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import HandyJSON

struct HomeNewsTitle: HandyJSON {
//    var category: NewsTitleCategory = .recommend
    var tip_new: Int = 0
    var default_add: Int = 0
    var web_url: String = ""
    var concern_id: String = ""
    var icon_url: String = ""
    var flags: Int = 0
    var type: Int = 0
    var name: String = ""
    
    var selected: Bool = true
}
