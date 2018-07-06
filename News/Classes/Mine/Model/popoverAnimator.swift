
//
//  popoverAnimator.swift
//  News
//
//  Created by zlf on 2018/6/27.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class popoverAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var presentFrame: CGRect?
    var isPresent: Bool = false
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let myPresentationController = MyPresentationController(presentedViewController: presented, presenting: presenting)
        myPresentationController.presentFrame = presentFrame!
        print("----\(myPresentationController.presentFrame)")
        return myPresentationController
    }
    /// 返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
     /// 展开关闭
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            let toView = transitionContext.view(forKey: .to)
            toView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            transitionContext.containerView.addSubview(toView!)
            //执行动画
            UIView.animate(withDuration: 0.25, animations: {
                toView?.transform = .identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
            
        }else {//关闭
            let fromView = transitionContext.view(forKey: .from)
            UIView.animate(withDuration: 0.25, animations: {
                fromView?.transform = CGAffineTransform(scaleX: 0, y: 0)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
    // 谁来负责modol 的消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
//        print("===\(self)")
        return self
    }
    
    /// 只要实现了这个方法，系统默认的动画就消失了，所有设置都需要我们自己来实现
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
   
    
}
