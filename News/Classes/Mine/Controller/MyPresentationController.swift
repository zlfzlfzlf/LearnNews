//
//  MyPresentationController.swift
//  News
//
//  Created by zlf on 2018/6/27.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class MyPresentationController: UIPresentationController {
    var presentFrame: CGRect?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPresentedViewController), name: NSNotification.Name(rawValue: "zlfpop"), object: nil)
        
    }
    
   override func containerViewWillLayoutSubviews() {
    
    presentedView?.frame = presentFrame!
    let coverView = UIView(frame: UIScreen.main.bounds)
    coverView.backgroundColor = .clear
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedViewController))
    coverView.addGestureRecognizer(tap)
    containerView?.insertSubview(coverView, at: 0)
    
    
    }
    
    @objc func dismissPresentedViewController() {
        presentedViewController.dismiss(animated: false, completion: nil)
    }
}
