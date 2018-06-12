//
//  TestDatabaseController.swift
//  News
//
//  Created by zlf on 2018/6/12.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class TestDatabaseController: UIViewController {
    var database :Database!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        view.backgroundColor = UIColor.globalBackgroundColo()
        database = Database()
//        database.connectDatabase()
        database.tableLampCreate()
//        let isEx = database.exist()
        // 插入两条数据
        database.tableLampInsertItem(address: 51, name: "灯光1", colorValue: "#FFFFFF", lampType: 0)
        database.tableLampInsertItem(address: 52, name: "灯光2", colorValue: "#AAAAAA", lampType: 1)
        
//        let isExw = database.exist()
        // 遍历列表（检查插入结果）
        let rowArr = database.queryTableLamp()
        print(rowArr[0])
//        // 根据条件查询
        database.readTableLampItem(address: 52)
//
//        // 修改列表项
        database.tableLampUpdateItem(address: 51, newName: "客厅大灯")
//
//        // 遍历列表（检查修改结果）
//        database.queryTableLamp()
//
//        // 删除列表项
        database.tableLampDeleteItem(address: 52)

        // 遍历列表（检查删除结果）
//        database.queryTableLamp()
        //删除表
         database.detelTable()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
