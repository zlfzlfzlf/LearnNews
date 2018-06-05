//
//  MyFisrtSectionCell.swift
//  News
//
//  Created by zlf on 2018/5/8.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class MyFisrtSectionCell: UITableViewCell, RegistterCellOrNib {
    /// 点击了第几个 cell
    var myConcernSelected: ((_ myConcern: MyConcern)->())?
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    /// 分割线
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myConcerns = [MyConcern]() {
        didSet {
            collectionView.reloadData()
        }
    }
    var myCellModel = MyCellModel() {
        didSet {
            leftLabel.text = myCellModel.text
            rightLabel.text = myCellModel.grey_text
        }
    }
    
    /// 当只关注一个用户的时候，需要设置
    var myConcern = MyConcern() {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.collectionViewLayout = myConcernFlowLaout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.ym_registerCell(cell: MyConcernCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        
        /// 设置主题
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImage.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        topView.theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
   
    
}
extension MyFisrtSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReuseableCell(indexPath: indexPath) as MyConcernCell
        cell.myConcern = myConcerns[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myConcernSelected?(myConcerns[indexPath.item])
    }
    
}

class myConcernFlowLaout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = CGSize(width: 58, height: 74)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 )
        scrollDirection = .horizontal
    }
}
