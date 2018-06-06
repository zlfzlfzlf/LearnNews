//
//  SettingCell.swift
//  News
//
//  Created by zlf on 2018/6/5.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class SettingCell: UITableViewCell, RegistterCellOrNib {

    
    var setting = settingModel() {
        didSet {
            titleLabel.text = setting.title
            subtitleLabel.text = setting.subtitle
            arrowImageView.isHidden = setting.isHiddenRightArraw
            switchView.isHidden = setting.isHiddenSwitch
            if !setting.isHiddenSubtitle {
                subtitleLabelHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    
    @IBOutlet weak var subtitleLabelHeight: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        bottomLine.theme_backgroundColor = "colors.separatorViewColor"
        titleLabel.theme_textColor = "colors.black"
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        arrowImageView.theme_image = "images.cellRightArrow"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SettingCell {
    func calculateDiskCashSize() {
        let cach = KingfisherManager.shared.cache
        cach.calculateDiskCacheSize { (size) in
            let sizeM = Double(size) / 1024 / 1024
            self.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        }
        
    }
    func clearCacheAlertController() {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let SureBtn = UIAlertAction(title: "确定", style: .default) { (_) in
            let cach = KingfisherManager.shared.cache
            cach.clearDiskCache()
            cach.clearMemoryCache()
            cach.cleanExpiredDiskCache()
            self.rightTitleLabel.text = "0.00M"
            
        }
        
        alertController.addAction(cancelBtn)
        alertController.addAction(SureBtn)
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }
}
