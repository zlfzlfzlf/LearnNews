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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        test()
//        let numbersCompound = [[1,2,3],[4,5,6]];
//        var flatRes = numbersCompound.flatMap{ $0.flatMap{ $0 + 2 } }
//        print(flatRes)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return sections.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let rows = sections[section]
//        return rows.count
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as SettingCell
//        let rows = sections[indexPath.section]
//        cell.setting = rows[indexPath.row]
//        return cell
//
//    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
//        view.backgroundColor = UIColor.globalBackgroundColo()
//        return view
//
//    }

}

func test () {
    print("1234679")
}

extension SettingViewController {
    func setupUI() {
        tableView.ym_registerCell(cell: SettingCell.self)
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        //        for dictArr in cellPlist {
        //            let array = dictArr as! [[String: Any]]
        //            var rows = [settingModel]()
        //            for dict in array {
        //                let setting = settingModel.deserialize(from: dict)
        //                rows.append(setting!)
        //            }
        //           sections.append(rows)
        //        }
        sections = cellPlist.flatMap({ section in
            (section as! [Any]).flatMap({ settingModel.deserialize(from: $0 as? [String: Any])! })
        })
        print(cellPlist)
    }
}

extension SettingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section]
        return rows.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
              cell.clearCacheAlertController()
            default:
                break
            }
        case 1:
            print("456")
           default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as SettingCell
        let rows = sections[indexPath.section]
        cell.setting = rows[indexPath.row]
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.calculateDiskCashSize()
        }else {
            
        }
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColo()
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
        
    }
}
