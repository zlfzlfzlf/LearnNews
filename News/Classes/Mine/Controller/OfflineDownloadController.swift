//
//  OfflineDownloadController.swift
//  News
//
//  Created by zlf on 2018/6/7.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class OfflineDownloadController: UITableViewController {
    var titles = [HomeNewsTitle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.ym_registerCell(cell: OfficeDownCell.self)
        NetworkTool.loadHomeNewsTitleData { (titles) in
            self.titles = titles
            self.tableView.reloadData()
        }
        tableView.rowHeight = 44;
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    navigationController?.navigationItem.rightBarButtonItem?.title = "下载"
        
        
//        tableView.ym_registerCell(cell)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}


extension OfflineDownloadController
{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as OfficeDownCell
        cell.HomeTitle = titles[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        view.backgroundColor = RGBColorFromHex(rgbValue: 0xECECEC)
        let viewLine = UIView()
        viewLine.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0.5)
        viewLine.backgroundColor = RGBColorFromHex(rgbValue: 0x333333)
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: screenWidth, height: 44))
        label.text = "我的频道"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        view.addSubview(viewLine)
        view.addSubview(label)
        
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

}
