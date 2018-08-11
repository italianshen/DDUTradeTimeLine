//
//  DongtaiCollectionViewCell.swift
//  News
//
//  Created by Danny on 2017/12/10.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class DongtaiCollectionViewCell: UICollectionViewCell, RegisterCellFromNib {
    

    var largeImage = String() {
        didSet {
            thumbImageView.kf.setImage(with: URL(string: largeImage), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                let progress = Float(receivedSize) / Float(totalSize)
                SVProgressHUD.showProgress(progress)
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(UIColor.white)
            }) { (image, error, cacheType, url) in
                SVProgressHUD.dismiss()
            }
        }
    }
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var iconButton: UIButton!
    
    @IBOutlet weak var gifLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.theme_borderColor = "colors.grayColor230"
        thumbImageView.layer.borderWidth = 1
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

}
