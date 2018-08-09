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
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navigationBar)
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        navigationBar.goBackButtonClicked = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        scrollView.delegate = self;
        self.bottomView.backgroundColor = UIColor.gray
        if isIPhoneX {
            bottomViewBotom.constant = 34
        }else {
            bottomViewBotom.constant = 0
        }
        view.layoutIfNeeded()
        self.navigationController?.navigationItem.title = "用户详情"
        view.backgroundColor = UIColor.white
//        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)

        scrollView.addSubview(headerView)
//        userId = 51025535398
        NetworkTool.loadUserDetail(userId: self.userId) { [weak self] userDetail in
            //获取用户详情的动态数据
            NetworkTool.loadUserDetailDongtaiList(userId: (self?.userId)!, maxCursor: 0, completionHandler: { (cursor, dongtais) in
                self?.scrollView.addSubview((self?.headerView)!)
                self?.userDetail = userDetail
                self?.headerView.userdetail = userDetail
                self?.navigationBar.userDetail = userDetail
                if userDetail.bottom_tab.count == 0 {
                    self?.bottomViewBotom.constant = 0
                    self?.bottomViewHeight.constant = 0
                    self?.headerView.height = 979 - 44
                    //                self?.view.layoutIfNeeded()
                }else {
                    self?.headerView.height = 979
                    self?.bottomViewHeight.constant = 40;
                    
                    self?.bottomView.addSubview((self?.myBottomView)!)
                    //                self?.view.layoutIfNeeded()
                    self?.myBottomView.bottomTabs = userDetail.bottom_tab
                }
//                self?.headerView.maxCursor = cursor
                self?.headerView.dongtais = dongtais
//                self?.headerView.currentTopTabType = .dongtai
                self?.scrollView.contentSize = CGSize(width: screenWidth, height: (self?.headerView.height)!)
                
            })
           
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.loadFromNib()
        var cgrect: CGRect = headerView.frame
        print(cgrect)
        cgrect = CGRect(x: 0, y: 0, width: screenWidth, height: 696 + 44)
       headerView.frame = cgrect
        
        return headerView
        
    }()
        
    
    /// 懒加载 头部
//    private lazy var headerView = UserDetailHeaderView.loadViewFromNib()
    /// 懒加载 底部
    fileprivate lazy var myBottomView: UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        myBottomView.delegate = self
        return myBottomView
    }()
    private lazy var navigationBar = NavigationBarView.loadViewFromNib()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UserDetailViewController: UserDetailBottomViewDelegate, UIScrollViewDelegate {
    
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print("===\(offsetY)")
        if offsetY < -19.9 {
            let totalOffset = kUserDetailHeaderBGImageViewHeight + abs(offsetY)
            let f = totalOffset / kUserDetailHeaderBGImageViewHeight
            headerView.backgroundImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
            
         }else if offsetY == 0 {
            for subview in headerView.bottomScrollView.subviews {
                let tableview = subview as! UITableView
                tableview.isScrollEnabled = false
            }
        }
        else {
            var alpha: CGFloat = (offsetY + 22)  / (37 + 22)
           alpha = min(alpha, 1.0)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
             
            if alpha == 1.0 {
                changeStatusBarStyle = .default
                navigationBar.returnButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            } else {
                changeStatusBarStyle = .lightContent
                navigationBar.returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
        }
        var alpha1: CGFloat = offsetY / 57
        
        ///14 + 15 + 14
        if offsetY >= 43 {
            alpha1 = min(alpha1, 1.0)
            navigationBar.nameLabel.isHidden = false
            navigationBar.concernButton.isHidden = false
            navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
            navigationBar.concernButton.alpha = alpha1
        }else {
            alpha1 = min(0.0, alpha1)
            navigationBar.nameLabel.textColor = UIColor(r: 0, g: 0, b: 0, alpha: alpha1)
            navigationBar.concernButton.alpha = alpha1
        }
        //设置heardview 的 toptab 黏住顶部
        var letth: CGFloat = 0
        
        if userDetail?.area == "" {
            letth = 50.0;
        }
        print(headerView.topTabView.frame.minY)
        if offsetY >= (19 + headerView.topTabView.frame.minY) {
            headerView.y = offsetY - 215 + letth
            for subview in headerView.bottomScrollView.subviews {
                let tableview = subview as! UITableView
                tableview.isScrollEnabled = true
            }
        }else {
            headerView.y = 0
        }
        
        if offsetY <= 173 {
            for subview in headerView.bottomScrollView.subviews {
                let tableview = subview as! UITableView
                tableview.isScrollEnabled = false
            }
        }
        
    }
    
    
    func bottomView(clicked button: UIButton, bottomTab: BottomTab) {
        let bottomPushVC = UserDetailBottomPushController()
        bottomPushVC.navigationItem.title = "网页浏览"
        if bottomTab.children.count == 0 {
            
            
            bottomPushVC.url = bottomTab.value
            navigationController?.pushViewController(bottomPushVC, animated: true)
            
        }else {//弹出子试图
            let sb = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
            let popoverVC = sb.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
            popoverVC.children = bottomTab.children
            popoverVC.modalPresentationStyle = .custom
            popoverVC.didSelectedChild = { [weak self] in
               bottomPushVC.url = $0.value
                self!.navigationController?.pushViewController(bottomPushVC, animated: true)
                }
            let popoverAnimatorLL = popoverAnimator()
            // 转化 frame
            let rect = myBottomView.convert(button.frame, to: view)
//            print("rect = \(rect)")
            let popWidth = (screenWidth - CGFloat(userDetail!.bottom_tab.count + 1) * 20) / CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CGFloat(bottomTab.children.count) * 40 + 25
            popoverAnimatorLL.presentFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: screenWidth/3.0, height: popHeight)
            popoverVC.transitioningDelegate = popoverAnimatorLL
            present(popoverVC, animated: true, completion: {
                
            })
//        self.navigationController?.pushViewController(popoverVC, animated: true)
            
            
        }
        
        
        
    }
    
    
}
