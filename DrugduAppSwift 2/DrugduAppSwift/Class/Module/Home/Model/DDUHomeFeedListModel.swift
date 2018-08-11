//
//  DDUHomeFeedListModel.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/26.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit
import HandyJSON

class DDUHomeFeedListModel: HandyJSON {

      required init(){}
    
      var ad_promotionid: String = ""
      var addud_url: String = ""
      var comment_num: String = ""
      var id: String = ""
      var info_exh_date: String = ""
      var info_exh_place: String = ""
      var info_id: String = ""
      var info_img: String = ""
      var info_intro: String = ""
      var info_title: String = ""
      var info_intro_detail: String = ""//资讯副标题
      var info_type: String = ""
      var info_url: String = ""
      var is_addud: Bool = false;
      var is_liked: Bool = false;
      var like_num: String = "";
      var link_info: String = "";
      var link_type: String = "";
      var media_desc: String = "";
      var media_id: String = "";
      var media_imgs:[String] = [String]();
      var media_lbs_lat: String = "";
      var media_lbs_location: String = "";
      var media_lbs_lon: String = "";
      var media_lbs_name: String = "";
      var media_link: String = "";
      var media_status: String = "";
      var media_type: String = "";
      var media_user_head: String = "";
      var media_user_id: String = "";
      var media_user_name: String = "";
      var media_video_url: String = "";
      var prd_comp_logo: String = "";
      var prd_comp_name: String = "";
      var prd_fob: String = "";
      var prd_id: String = "";
      var prd_imgs:[String] = [String]();
      var prd_imgs_big:[String] = [String]();
      var prd_imgs_mid:[String] = [String]();
      var prd_imgs_small:[String] = [String]();
      var prd_min_order: String = "";
      var prd_title: String = "";
      var push_time: String = "";
      var verified_icons: [String] = [String]();
      var view_num: String = "";
      var type: String = "";
    
      //cell类型
      var cell_type: CellType = .picAndText;
    
      //媒体标题的高度
      var media_desc_contentH: CGFloat { return media_desc.boldTextHeight(fontSize: 14, width: screenWidth - 30)}
      //图片容器的高度
    /// 图文 collectionView 高度
    var picAndTextCollectionViewH: CGFloat {
        return Calculate.collectionViewHeight(media_imgs.count)
    }
    
    var productCollectionViewH: CGFloat {
        return Calculate.collectionViewHeight(prd_imgs.count)
    }
    
    var productCollectionViewW: CGFloat {
        return Calculate.collectionViewWidth(prd_imgs.count)
    }
    
    // 1 ,2 3  5,6 7 8 9
    /// collectionView 宽度
    var picAndTextCollectionViewW: CGFloat {
        return Calculate.collectionViewWidth(media_imgs.count)
    }
    
    /// locationView 高度 左右30 图标16 margin 9
    var locationViewH: CGFloat {
        
        var height:CGFloat = 16.0;
        
        if (media_lbs_name.textHeight(fontSize: 14, width: (screenWidth - 30 - 16 - 9)) + 5.0) > height {
            height = (media_lbs_name.textHeight(fontSize: 14, width: (screenWidth - 30 - 16 - 9)) + 5.0);
        }
        
        // 上下加10的间距
        return height;
    }
    //avatarInfoView
    var avatarInfoViewH: CGFloat {
        return 50;
    }
    //avatarInfoView
    
    var videoViewH: CGFloat {
        return (screenWidth - 30) * 0.4;
    }
    
    //展会图标的高度
    var exhibitionViewH: CGFloat {
        return (screenWidth - 30) * 0.4;
    }
    
    //新闻图片的高度
    var newsIconViewH: CGFloat {
        return (screenWidth - 30) * 0.4;
    }
    
    var cellHeight: CGFloat {
        var height:CGFloat = 0.0;
        let toolBarH:CGFloat = 35.0;
        let lineH:CGFloat = 10.0;
        var locationH:CGFloat = locationViewH + 5.0;
        if media_lbs_name.isEmpty{
            locationH = 0.0;
        }
        
        if cell_type == .picAndText {
            
            var titleBottomMargin:CGFloat = 10.0;
            if media_imgs.count == 0{
                titleBottomMargin = 0.0;
            }
            
            if media_desc.isEmpty{
                titleBottomMargin = 0.0;
            }
        
            var titleH = media_desc_contentH;
            if media_desc.isEmpty{
                titleH = 0.0;
            }
            
            var picH = picAndTextCollectionViewH;
            if  media_imgs.count == 0{
                picH = 0.0;
            }
            
          // 文本高度
            height = 12.0 + titleH + titleBottomMargin + picH + locationH + avatarInfoViewH + toolBarH + lineH;
            
        }else if cell_type == .video{
            // 文本高度
            var titleBottomMargin:CGFloat = 10.0;
            if media_imgs.count == 0{
                titleBottomMargin = 0.0;
            }
            
            if media_desc.isEmpty{
                titleBottomMargin = 0.0;
            }
            
            var titleH = media_desc_contentH;
            if media_desc.isEmpty{
                titleH = 0.0;
            }
            
            height = 12.0 + titleH + titleBottomMargin + (videoViewH) + (locationH) + avatarInfoViewH + toolBarH + lineH;
        }else if cell_type == .exhibition{
            let info_titleH = info_title.boldTextHeight(fontSize: 14, width: screenWidth - 30);
            let sub_info_titleH = info_intro.textHeight(fontSize: 12, width: screenWidth - 30);
            // 文本高度
            height = 12 + info_titleH + 6 + sub_info_titleH + 10.0 + videoViewH  + avatarInfoViewH + toolBarH + lineH;
        }else if cell_type == .news{
            let info_titleH = info_title.boldTextHeight(fontSize: 14, width: screenWidth - 30);
            let info_title_detailH = info_intro.textHeight(fontSize: 12, width: screenWidth - 30);
            // 显示的时候少了15
            height = 12 + info_titleH + 6 + info_title_detailH + 10 + videoViewH + (locationH) + avatarInfoViewH + toolBarH + lineH;
        }else if cell_type == .product{
            let prdTitleH = prd_title.boldTextHeight(fontSize: 14, width: screenWidth - 30) ;
            
            let moqViewH:CGFloat = 23.0;
            
            // 文本高度
            height = 12 + prdTitleH + 6.0 + moqViewH + 10.0 + productCollectionViewH + locationH + avatarInfoViewH + toolBarH + lineH;
        }
        return height;
    }
    

}

enum CellType: Int, HandyJSONEnum {
    //图文
    case picAndText = 1
    
    ///视频
    case video = 2
    
    /// 展会
    case exhibition = 3
    
    /// 新闻
    case news = 4
    
    /// 产品
    case product = 5

}
