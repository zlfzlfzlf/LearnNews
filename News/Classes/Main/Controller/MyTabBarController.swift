//
//  MyTabBarController.swift
//  News
//
//  Created by 杨蒙 on 2017/9/6.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(tabBar.subviews)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        tabbar.tintColor = UIColor(red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        
        // 添加子控制器
        addChildViewControllers()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    /// 接收到了按钮点击的通知
    @objc func receiveDayOrNightButtonClicked(notification: Notification){
       if notification.object as! Bool {
        for childViewController in childViewControllers {
            switch childViewController.title! {
            case "首页":
                setNightChildController(controller: childViewController, imageName: "home")
            case "视频":
                setNightChildController(controller: childViewController, imageName: "video")
            case "小视频":
                setNightChildController(controller: childViewController, imageName: "huoshan")
            case "未登录":
                setNightChildController(controller: childViewController, imageName: "no_login")
            default:
                break
            }
        }
        
       } else {
        for childViewController in childViewControllers {
            switch childViewController.title! {
            case "首页":
                setDayChildController(controller: childViewController, imageName: "home")
            case "视频":
                setDayChildController(controller: childViewController, imageName: "video")
            case "小视频":
                setDayChildController(controller: childViewController, imageName: "huoshan")
            case "未登录":
                setDayChildController(controller: childViewController, imageName: "no_login")
            default:
                break
            }
        }
        }
        
    }
        /// 设置夜间控制器
        func setNightChildController(controller: UIViewController, imageName: String) {
            controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
            controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
        }
    /// 设置白天控制器
    func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
    
    /// 添加子控制器
    func addChildViewControllers() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home", selectedImageName: "home_tabbar_press_32x32_")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video", selectedImageName: "video_tabbar_press_32x32_")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan", selectedImageName: "huoshan_tabbar_press_32x32_")
        setChildViewController(MineViewController(), title: "未登录", imageName: "no_login", selectedImageName: "no_login")//no_login_tabbar_press_32x32_
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
    }
    
    /// 初始化子控制器
    func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        // 设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        }else {
            setDayChildController(controller: childController, imageName: imageName)
        }
//        childController.tabBarItem.image = UIImage(named: imageName)
//        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        let navVc = MyNavigationController(rootViewController: childController)
        addChildViewController(navVc)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
