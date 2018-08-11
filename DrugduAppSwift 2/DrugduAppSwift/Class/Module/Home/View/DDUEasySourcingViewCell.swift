//
//  DDUEasySourcingViewCell.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/24.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit
import Kingfisher
//RegisterCellFromNib
class DDUEasySourcingViewCell: UITableViewCell,RegisterCellFromNib {
    var model:DDUEasySourcingModel?{
        didSet{
            product_name_lbl.text = model?.product_name;
            company_name_lbl.text = model?.company_name;
            //http://public.static.drugdu.com/v2/images/guoqi/%@.png
            
            let str = String(format: "/http://public.static.drugdu.com/v2/images/guoqi/%@.png", (model?.country_code)!);
            let url =  URL(string: str);
            flagView.kf.setImage(with: url);
            
            //flagView
            quotes_lbl.text = String(format: "just got %@ quotes", (model?.quotes_num)!);
            
        }
    }
    
    
    @IBOutlet weak var product_name_lbl: UILabel!
    
    
    @IBOutlet weak var company_name_lbl: UILabel!
    
    
    @IBOutlet weak var flagView: UIImageView!
    
    
    @IBOutlet weak var quotes_lbl: UILabel!
    
    
    @objc func easySourcingViewCell() ->DDUEasySourcingViewCell{
        return Bundle.main.loadNibNamed("DDUEasySourcingViewCell", owner: nil, options: nil)?.last as! DDUEasySourcingViewCell;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        product_name_lbl.text = "Hahah";
        company_name_lbl.text = "Drugdu Technology.Ltd";
        quotes_lbl.text = "just got 9 quotes.";
    }
    
}
