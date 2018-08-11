//
//  DDUAvatarInfoView.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/27.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit

class DDUAvatarInfoView: UIView ,NibLoadable{

   
    @IBOutlet weak var avatarView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        avatarView.layer.cornerRadius = 15.0;
        avatarView.layer.masksToBounds = true;
    }
    
    var feedModel = DDUHomeFeedListModel(){
        didSet{
            let placeHolder = UIImage(named: "mydrugdu_user_bg");
            var url = URL(string: feedModel.media_user_head);
            if feedModel.media_user_head.isEmpty {
               url = URL(string: feedModel.prd_comp_logo);
            }
            
            avatarView.kf.setImage(with: url, placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: nil)
            
            
//            avatarView.kf.setImage(with: url);
            nameLabel.text = String(format: "%@", feedModel.media_user_name);
            if feedModel.media_user_name.isEmpty {
              nameLabel.text = String(format: "%@", feedModel.prd_comp_name);
            }
            timeLabel.text = String(format: "%@", feedModel.push_time);
        }
    }
}
