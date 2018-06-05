//
//  UICollection+Extension.swift
//  News
//
//  Created by zlf on 2018/5/10.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

extension UICollectionView {
    func ym_registerCell <T: UICollectionViewCell> (cell: T.Type) where T: RegistterCellOrNib{
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    func ym_dequeueReuseableCell <T: UICollectionViewCell> (indexPath: IndexPath) -> T where T: RegistterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
