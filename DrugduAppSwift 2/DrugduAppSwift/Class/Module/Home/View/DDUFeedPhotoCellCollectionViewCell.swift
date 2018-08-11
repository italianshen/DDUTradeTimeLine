//
//  DDUFeedPhotoCellCollectionViewCell.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/27.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher
class DDUFeedPhotoCellCollectionViewCell: UICollectionViewCell,RegisterCellFromNib {
    
    @IBOutlet weak var iconView: UIImageView!
    
    var image_url = String(){
        didSet{
            let placeHolder:UIImage = UIImage(named: "product_bg")!;
            iconView.kf.setImage(with: URL(string: image_url), placeholder: placeHolder, options: nil, progressBlock: { (receivedSize, totalSize) in
                let progress = Float(receivedSize) / Float(totalSize)
                SVProgressHUD.showProgress(progress)
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(UIColor.white)
            }) { (image, error, cacheType, url) in
                SVProgressHUD.dismiss();
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconView.contentMode = .scaleAspectFill;
        iconView.clipsToBounds = true;
        
    }
    
    
    
    
    

}
