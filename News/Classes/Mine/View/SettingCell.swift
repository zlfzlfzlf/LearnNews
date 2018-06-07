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
    
    func setFontAlterController() {
        let alterFont = UIAlertController(title: "调整字体大小", message: "Hello", preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bigFont = UIAlertAction(title: "大", style: .default) { (_) in
            self.rightTitleLabel.text = "大"
        }
        let midFont = UIAlertAction(title: "中", style: .default) { (_) in
            self.rightTitleLabel.text = "中"
        }
        let smallFont = UIAlertAction(title: "小", style: .default) { (_) in
            self.rightTitleLabel.text = "小"
        }
        alterFont.addAction(cancelBtn)
        alterFont.addAction(bigFont)
        alterFont.addAction(midFont)
        alterFont.addAction(smallFont)
      
    UIApplication.shared.keyWindow?.rootViewController?.present(alterFont, animated: true, completion: nil)
    
    }
    
    func setupPlayNoticeAlertController() {
        let alertController = UIAlertController(title: "非 WiFi 网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default, handler: { (_) in
            self.rightTitleLabel.text = "每次提醒"
        })
        let onceAction = UIAlertAction(title: "提醒一次", style: .default, handler: { (_) in
            self.rightTitleLabel.text = "提醒一次"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(everyAction)
        alertController.addAction(onceAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    /// 非 WiFi 网络流量
    func setupNetworkAlertController() {
        let alertController = UIAlertController(title: "非 WiFi 网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最小效果(下载大图)", style: .default, handler: { (_) in
            self.rightTitleLabel.text = "最小效果(下载大图)"
        })
        let betterAction = UIAlertAction(title: "较省流量(智能下图)", style: .default, handler: { (_) in
            self.rightTitleLabel.text = "较省流量(智能下图)"
        })
        let leastAction = UIAlertAction(title: "极省流量(智能下图)", style: .default, handler: { (_) in
            self.rightTitleLabel.text = "极省流量(智能下图)"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(bestAction)
        alertController.addAction(betterAction)
        alertController.addAction(leastAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
