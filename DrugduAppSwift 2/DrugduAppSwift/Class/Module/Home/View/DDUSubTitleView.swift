//
//  DDUSubTitleView.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/31.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit

class DDUSubTitleView: UIView,NibLoadable {

   
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var feedModel = DDUHomeFeedListModel(){
        didSet{
            subTitleLabel.text = String(format: "%@", feedModel.info_title);
        }
    }
    
    
}
