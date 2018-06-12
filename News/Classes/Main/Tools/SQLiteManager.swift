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
    //主键
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let tip_new = Expression<Int64>("tip_new")
    let default_add = Expression<Int64>("default_add")
    let web_url = Expression<String>("web_url")
    let concern_id = Expression<String>("concern_id")
    let icon_url = Expression<String>("icon_url")
    let flags = Expression<Int64>("flags")
    let type = Expression<Int64>("type")
    let name = Expression<String>("name")
    let selected = Expression<Bool>("selected")
    
    init() {
        
        try! sqlManager.database.run(news_title.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
            t.column(id, primaryKey: true)
            t.column(category)
            t.column(tip_new)
            t.column(default_add)
            t.column(web_url)
            t.column(concern_id)
            t.column(icon_url)
            t.column(flags)
            t.column(type)
            t.column(name)
            t.column(selected)
        }))
    
    }
    
    /// 插入一组数据
    func inserts(_ titles: [HomeNewsTitle]) { _ = titles.map { insert($0) }}
    func insert(_ title: HomeNewsTitle) {
         if !exist(title) {
        let insert = news_title.insert(category <- title.category, tip_new <- Int64(title.tip_new), default_add <- Int64(title.default_add), concern_id <- title.concern_id, web_url <- title.web_url, icon_url <- title.icon_url, flags <- Int64(title.flags), type <- Int64(title.type), name <- title.name, selected <- title.selected)
        do {
            let rowid = try sqlManager.database.run(insert)
            print("插入数据成功 id: \(rowid)")
        } catch {
            print("插入数据失败: \(error)")
        }
        }
    }
    
    ///判断此条数据是否存在
    func exist(_ title: HomeNewsTitle) -> Bool {
        let title = news_title.filter(category == title.category)
        let count = try! sqlManager.database.scalar(title.count)
//        let all = Array(try! sqlManager.database.prepare(news_title))
//        print("all.count\(all.count)  -- count = \(count)")
        return count != 0
    }
    
    
     func selectAll() -> [HomeNewsTitle] {
         var allTitles = [HomeNewsTitle]()
        for title in try! sqlManager.database.prepare(news_title) {
            // 取出表中数据，并初始化为一个结构体模型
            let newsTitle = HomeNewsTitle.init(category: title[category], tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: Bool(title[selected]))
            allTitles.append(newsTitle)
        }
        
        return allTitles
    }
    
    func update(_ newsTitle: HomeNewsTitle) {
//         取出数据库中数据
        let title = news_title.filter(category == newsTitle.category)
//         更新数据
        try! sqlManager.database.run(title.update(selected <- newsTitle.selected))
    }
    
}
