//
//  UIColor+Extension.swift
//  News
//
//  Created by zlf on 2018/5/3.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
//        self.init(r: <#T##CGFloat#>, g: <#T##CGFloat#>, b: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func globalBackgroundColo() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
}
