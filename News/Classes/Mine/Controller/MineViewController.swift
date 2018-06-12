//
//  MineViewController.swift
//  News
//
//  Created by 杨蒙 on 2017/9/6.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class MineViewController: UITableViewController {
    fileprivate let disposeBag = DisposeBag()
    // 存储 cell的数据
    var sections = [[MyCellModel]]()
    // 存储我的关注数据
    var concerns = [MyConcern]()

    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor.globalBackgroundColo()
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.ym_registerCell(cell: MyFisrtSectionCell.self)
        tableView.ym_registerCell(cell: MyOtherCell.self)
        //获取cell的数据
        NetworkTool.loadMyCellData { (sections) in
            let string: String = "{\"text\":\"我\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
            // 我的关注数据
//            NetworkTool.loadMyConcern(completionHandler: { concerns in
//                self.concerns = concerns;
//                let indexSet = IndexSet(integer: 0)
//                self.tableView.reloadSections(indexSet, with: .automatic)
//
//            })
            NetworkTool.loadMyConcern(completionHandler: {
                self.concerns = $0
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            })
        }
        
        /// 更多按钮点击
        headerView.moreLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let loginView = MoreLoginViewController()
                //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
//                self?.present(loginView, animated: true, completion: nil)
                self?.present(loginView, animated: true, completion: {
                    
                })
              
//                let moreLoginVC = UIStoryboard(name: String(describing: MoreLoginViewController()), bundle: nil)

            })
            .disposed(by: disposeBag)
    }
        
        
//        headerView.moreLoginButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController()), bundle: nil)
//                let moreLoginVC = storyboard.instantiateViewController(withIdentifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
//
////                moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
//                self!.present(moreLoginVC, animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)

    }
    
    
    /// 懒加载 头部
fileprivate var headerView: NoLoginHeaderView = {
        let headerView = NoLoginHeaderView.headerViewXIB()
        return headerView

    }()
    
    
var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


extension MineViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        view.backgroundColor = UIColor(r: 247, g: 248, b: 249)
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as MyFisrtSectionCell
            
            let section = sections[indexPath.section]
            cell.myCellModel = section[indexPath.row]
            cell.collectionView.isHidden = (concerns.count == 0 || concerns.count == 1)
            if concerns.count == 1 { cell.myConcern = concerns[0] }
            if concerns.count > 1 { cell.myConcerns = concerns }
            
           
            return cell
            
        }
        let cell  = tableView.ym_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
       
        cell.leftLabel.text = myCellModel.text//"ceshi"
        cell.rightLabel.text = myCellModel.grey_text 
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 0 {
            let databaseVC = TestDatabaseController()
            databaseVC.navigationItem.title = "数据库测试"
            navigationController?.pushViewController(databaseVC, animated: true)
        }
        if indexPath.section == 3 {
            if indexPath.row == 1 {
                let settingVC = SettingViewController()
                settingVC.navigationItem.title = "设置"
                navigationController?.pushViewController(settingVC, animated: true)
                
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / kMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
            
        }
        
    }
}
