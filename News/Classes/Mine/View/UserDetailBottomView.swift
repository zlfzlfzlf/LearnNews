//
//  UserDetailBottomView.swift
//  News
//
//  Created by zlf on 2018/6/26.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

protocol UserDetailBottomViewDelegate: class{
    func bottomView(clicked button: UIButton, bottomTab: BottomTab)
}

class UserDetailBottomView: UIView {
    
weak var delegate: UserDetailBottomViewDelegate?
    
    var bottomTabs = [BottomTab]() {
        didSet {
            let buttonWith = (screenWidth - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            for (index, bottomTab) in bottomTabs.enumerated() {
                let button = UIButton(frame: CGRect(x: CGFloat(index) * (buttonWith + 1), y: 0, width: buttonWith, height: height))
                button.setTitle(bottomTab.name, for: .normal)
                button.tag = index
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
                button.addTarget(self, action: #selector(bottomTabButtonClicked), for: .touchUpInside)
               addSubview(button)
                
                if index < bottomTabs.count - 1 {
                    let separatorView = UIView(frame: CGRect(x: buttonWith * CGFloat(index + 1), y: 6, width: 1.0, height: 32))
                    separatorView.theme_backgroundColor = "colors.separatorViewColor"
                    addSubview(separatorView)
                }
                
            }
            
        }
    }
    
    @objc func bottomTabButtonClicked(button: UIButton) {
//        print(delegate)
//        print(<#T##items: Any...##Any#>)
        delegate?.bottomView(clicked: button, bottomTab: bottomTabs[button.tag])
        if bottomTabs.count  == 0 {
            
        }else {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
