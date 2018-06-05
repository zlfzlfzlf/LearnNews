//
//  MyTheme.swift
//  News
//
//  Created by zlf on 2018/5/22.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import SwiftTheme
enum MyTheme: Int {
    case day = 0
    case night = 1
    static var before = MyTheme.day
    static var current = MyTheme.day
    static func switchTo(_ theme: MyTheme){
        before = current
        current = theme
        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    static func switchNight(isToNight: Bool){
        switchTo(isToNight ? .night : .day)
    }
    static func isNightt() -> Bool {
        return current == .night
    }
}
/////

////////nizai 
