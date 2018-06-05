//
//  SetViewController.swift
//  News
//
//  Created by zlf on 2018/6/1.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    var sections = [[settingModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let numbersCompound = [[1,2,3],[4,5,6]];
//        var flatRes = numbersCompound.flatMap{ $0.flatMap{ $0 + 2 } }
//        print(flatRes)
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        for dictArr in cellPlist {
            let array = dictArr as! [[String: Any]]
            var rows = [settingModel]()
            for dict in array {
                let setting = settingModel.deserialize(from: dict)
                rows.append(setting!)
            }
           sections.append(rows)
        }
//        sections = cellPlist.flatMap({ section in
//            (section as! [Any]).flatMap({ settingModel.deserialize(from: $0 as? [String: Any])! })
//        })
        print(cellPlist)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    

}
