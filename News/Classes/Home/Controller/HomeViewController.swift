//
//  HomeViewController.swift
//  News
//
//  Created by 杨蒙 on 2017/9/6.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
//    var titles = [HomeNewsTitle]()
    fileprivate let newstitleTabs = NewsTitleTable()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        NetworkTool.loadHomeNewsTitleData { (titles) in
//            self.titles = titles
            //向数据库中传数据
            self.newstitleTabs.inserts(titles)
        }
    }

}
