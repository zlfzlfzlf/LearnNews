//
//  Database.swift
//  News
//
//  Created by zlf on 2018/6/12.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import SQLite


struct Database {
    var db: Connection!
    
    init() {
        connectDatabase()
    }
    
    //获取doc路径
    
    
  
    // 与数据库建立连接
    mutating func connectDatabase(filePath: String = "/Documents") -> Void {
        
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            print("与数据库建立连接 成功")
        } catch {
            print("与数据库建立连接 失败：\(error)")
        }
        
    }
    
    // ===================================== 灯光 =====================================
    let TABLE_LAMP = Table("table_lamp") // 表名称
    let TABLE_LAMP_ID = Expression<Int64>("lamp_id") // 列表项及项类型
    let TABLE_LAMP_ADDRESS = Expression<Int64>("lamp_address")
    let TABLE_LAMP_NAME = Expression<String>("lamp_name")
    let TABLE_LAMP_COLOR_VALUE = Expression<String>("lamp_colorValue")
    let TABLE_LAMP_LAMP_TYPE = Expression<Int64>("lamp_lampType")
    
    //建表
    func tableLampCreate() {
        do {
            try db.run(TABLE_LAMP.create(block: { (table) in
                table.column(TABLE_LAMP_ID, primaryKey: .autoincrement) // 主键自加且不为空
                table.column(TABLE_LAMP_ADDRESS)
                table.column(TABLE_LAMP_NAME)
                table.column(TABLE_LAMP_COLOR_VALUE)
                table.column(TABLE_LAMP_LAMP_TYPE)
            }))
        } catch  {
            print("创建表 TABLE_LAMP 失败：\(error)")
        }
    }
    
    // 插入
    func tableLampInsertItem(address: Int64, name: String, colorValue: String, lampType: Int64) -> Void {
        let insert = TABLE_LAMP.insert(TABLE_LAMP_ADDRESS <- address, TABLE_LAMP_NAME <- name, TABLE_LAMP_COLOR_VALUE <- colorValue, TABLE_LAMP_LAMP_TYPE <- lampType)
        do {
            let rowid = try db.run(insert)
            print("插入数据成功 id: \(rowid)")
        } catch {
            print("插入数据失败: \(error)")
        }
    }
    
    // 遍历
    func queryTableLamp() -> ([Row]) {
        var row = [Row]()
        
        for item in (try! db.prepare(TABLE_LAMP)) {
//            print(type(of: item))
            print("灯光 遍历 ———— id: \(item[TABLE_LAMP_ID]), address: \(item[TABLE_LAMP_ADDRESS]), name: \(item[TABLE_LAMP_NAME]), colorValue: \(item[TABLE_LAMP_COLOR_VALUE]), lampType: \(item[TABLE_LAMP_LAMP_TYPE])")
            row .append(item)
        }
        return row
    }
    
    // 读取
    func readTableLampItem(address: Int64) -> Void {
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_ADDRESS == address)) {
            print("\n读取（灯光）id: \(item[TABLE_LAMP_ID]), address: \(item[TABLE_LAMP_ADDRESS]), name: \(item[TABLE_LAMP_NAME]), colorValue: \(item[TABLE_LAMP_COLOR_VALUE]), lampType: \(item[TABLE_LAMP_LAMP_TYPE])")
        }
        
    }
    
    // 更新
    func tableLampUpdateItem(address: Int64, newName: String) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ADDRESS == address)
        do {
            if try db.run(item.update(TABLE_LAMP_NAME <- newName)) > 0 {
                print("灯光\(address) 更新成功")
            } else {
                print("没有发现 灯光条目 \(address)")
            }
        } catch {
            print("灯光\(address) 更新失败：\(error)")
        }
    }
    
    // 删除
    func tableLampDeleteItem(address: Int64) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ADDRESS == address)
        do {
            if try db.run(item.delete()) > 0 {
                print("灯光\(address) 删除成功")
            } else {
                print("没有发现 灯光条目 \(address)")
            }
        } catch {
            print("灯光\(address) 删除失败：\(error)")
        }
    }
    
    func exist() -> Bool {
        //        let title = news_title.filter(name.length > 1)
        let count = try! db.scalar(TABLE_LAMP.count)
        let all = Array(try! db.prepare(TABLE_LAMP))
        print("all.count\(all.count)  -- count = \(count)")
        return all.count != 0
    }
    func detelTable() {
        do {
            try db.run(TABLE_LAMP.delete())
        } catch  {
            print(error)
        }
        
    }
    
}
