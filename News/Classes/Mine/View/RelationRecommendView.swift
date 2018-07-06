//
//  RelationRecommendView.swift
//  News
//
//  Created by zlf on 2018/7/5.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class RelationRecommendView: UIView, NibLoadable {
    @IBOutlet weak var collectionView: UICollectionView!
    var userCards = [UserCard]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super .awakeFromNib()
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = RelationRecommendViewLayout()
        collectionView.ym_registerCell(cell: RelationRecommendCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

extension RelationRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(userCards.count)
        return (userCards.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as RelationRecommendCell
        let cell = collectionView.ym_dequeueReuseableCell(indexPath: indexPath) as RelationRecommendCell
        cell.userCard = userCards[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }


}



class RelationRecommendViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
      
        sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
    
    }
}
