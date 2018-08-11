//
//  FeedCollectionView.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/27.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit
class FeedCollectionView:  UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, NibLoadable  {

    // MARK: - 点击图片回调
    var didSelect: ((_ selectedIndex: Int)->())?
    // 图片
    var thumbImages = [String]() {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        backgroundColor = .clear
        collectionViewLayout = DongtaiCollectionViewFlowLayout()
        ym_registerCell(cell: DDUFeedPhotoCellCollectionViewCell.self);
        isScrollEnabled = true
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as DDUFeedPhotoCellCollectionViewCell
        cell.image_url = thumbImages[indexPath.item];
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("collectionView:" + "\(thumbImages)" + NSStringFromCGSize(Calculate.detailCollectionViewCellSize(thumbImages)));
        
        if thumbImages.count == 4 {//数量为4的时候UI有问题
            return Calculate.collectionViewCellSize(thumbImages.count);
        }
        // 4张计算出来是170 170
        return Calculate.detailCollectionViewCellSize(thumbImages);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       didSelect?(indexPath.item);
    }
    
    
    

}



class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        if screenWidth > 375 {
            minimumLineSpacing = 2.5
            minimumInteritemSpacing = 2.5
        }else{
            minimumLineSpacing = 5.0
            minimumInteritemSpacing = 5.0
        }
       
    }
}
