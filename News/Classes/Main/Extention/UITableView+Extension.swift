//
//  UITableView+Extension.swift
//  News
//
//  Created by zlf on 2018/5/10.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

extension UITableView {
    func ym_registerCell <T: UITableViewCell> (cell: T.Type) where T: RegistterCellOrNib{
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    func ym_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegistterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T

    }
}
