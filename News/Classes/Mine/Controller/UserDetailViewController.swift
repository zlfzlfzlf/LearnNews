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
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)

        scrollView.addSubview(headerView)
        NetworkTool.loadUserDetail(userId: self.userId) { [weak self] userDetail in
            self?.userDetail = userDetail
            self?.headerView.userdetail = userDetail
            if userDetail.bottom_tab.count == 0 {
                self?.bottomViewBotom.constant = 0
                self?.bottomViewHeight.constant = 0
                self?.headerView.height = 979 - 34
//                self?.view.layoutIfNeeded()
            }else {
                self?.headerView.height = 969
                self?.bottomViewHeight.constant = 40;
                
             self?.bottomView.addSubview((self?.myBottomView)!)
//                self?.view.layoutIfNeeded()
                self?.myBottomView.bottomTabs = userDetail.bottom_tab
            }
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.loadFromNib()
        var cgrect: CGRect = headerView.frame
        print(cgrect)
        cgrect = CGRect(x: 0, y: 0, width: screenWidth, height: 300)
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
            
        }else {
            var alpha: CGFloat = (offsetY + 22)  / 1000
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
