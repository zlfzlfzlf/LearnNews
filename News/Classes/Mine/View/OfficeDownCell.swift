//
//  OfficeDownCell.swift
//  News
//
//  Created by zlf on 2018/6/11.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class OfficeDownCell: UITableViewCell,RegistterCellOrNib {

    
    
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var stateImage: UIImageView!
    
    var HomeTitle: HomeNewsTitle? {
        didSet {
            title_label.text = HomeTitle?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
