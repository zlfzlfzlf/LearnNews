//
//  UserDetailViewController.swift
//  News
//
//  Created by zlf on 2018/6/14.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewBotom: NSLayoutConstraint!
    
    var userId: Int = 0
    var userDetail: UserDetail?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isIPhoneX {
            bottomViewBotom.constant = 34
        }else {
            bottomViewBotom.constant = 0
        }
        view.layoutIfNeeded()
        self.navigationController?.navigationItem.title = "用户详情"
        view.backgroundColor = UIColor.white
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
//        headerView.x = 0
//        headerView.y = 100
        scrollView.addSubview(headerView)
        NetworkTool.loadUserDetail(userId: self.userId) { [weak self] userDetail in
            self?.userDetail = userDetail
            self?.headerView.userdetail = userDetail
            if userDetail.bottom_tab.count == 0 {
                self?.bottomViewBotom.constant = 0
                self?.view.layoutIfNeeded()
            }else {
                
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.headerViewXIB()
        var cgrect: CGRect = headerView.frame
        print(cgrect)
        cgrect = CGRect(x: 0, y: 0, width: screenWidth, height: 300)
       headerView.frame = cgrect
        
        return headerView
        
    }()
        
    
    /// 懒加载 头部
//    private lazy var headerView = UserDetailHeaderView.loadViewFromNib()
    
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
