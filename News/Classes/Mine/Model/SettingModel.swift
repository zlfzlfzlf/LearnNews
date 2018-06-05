//
//  SettingModel.swift
//  News
//
//  Created by zlf on 2018/6/1.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import HandyJSON

struct settingModel: HandyJSON{
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArraw: Bool = false
    
}
