//
//  SQLiteManager.swift
//  News
//
//  Created by zlf on 2018/6/11.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import SQLite
struct SQLiteManager {
    // 数据库链接
    var database:Connection!
    init() {
        do {
        let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            database = try Connection(path)
        } catch  {
            print(error)
        }
    }
    
}

struct NewsTitleTable {
    /// 数据库管理者
    let sqlManager = SQLiteManager()
    /// 新闻标题 表
    let news_title = Table("news_title")
    
    
}
