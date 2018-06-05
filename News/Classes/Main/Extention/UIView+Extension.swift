//
//  UIView+Extension.swift
//  News
//
//  Created by zlf on 2018/5/10.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
protocol RegistterCellOrNib {}

extension RegistterCellOrNib{
    static var identifier: String {
        return "\(self)"
    }
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
