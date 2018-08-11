//
//  DDUFeedListViewCell.swift
//  DrugduAppSwift
//
//  Created by 沈士新 on 2018/7/31.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit

class DDUFeedListViewCell: UITableViewCell,RegisterCellFromNib {
    // 点击图片回调
    var didSelectCell: ((_ selectedIndex: Int)->())?
   //约束
    //副标题的高度
    @IBOutlet weak var MainTitleViewH: NSLayoutConstraint!
    
    //主副标题底部间距
    @IBOutlet weak var titleSubTitleMargin: NSLayoutConstraint!
    
    // 副标题高度
    @IBOutlet weak var subTitleViewH: NSLayoutConstraint!
    
   //副标题 底部的间距
    @IBOutlet weak var subTitleBottomMargin: NSLayoutConstraint!
    
    
    @IBOutlet weak var picLeftCons: NSLayoutConstraint!
    // 图片容器视图高度
    @IBOutlet weak var picContentViewH: NSLayoutConstraint!
    
    @IBOutlet weak var picContentViewW: NSLayoutConstraint!
    
    // location视图的高度
    @IBOutlet weak var locationViewH: NSLayoutConstraint!
    
    // view containers
    
    //标题容器视图
    @IBOutlet weak var titleContentView: UIView!
    
    //副标题容器视图
    @IBOutlet weak var subTitleContentView: UIView!
    
    //图片容器视图
    @IBOutlet weak var picContentView: UIView!
    
    
    @IBOutlet weak var locationContentView: UIView!
    
    
    @IBOutlet weak var infoContentView: UIView!
    
    
    //lazy loading

    /***********主标题****************/
    //懒加载titleView
    private lazy var mainTitleView = DDUFeedMainTitleView.loadViewFromNib()
    
    
    /*******副标题*****************/
    //新闻子标题 subTitleView DDUSubTitleView
    private lazy var subTitleView = DDUSubTitleView.loadViewFromNib()
    
    //子标题
    fileprivate lazy var subTitleLabel: UILabel = {
        let subTitleLabel:UILabel = UILabel.init();
        subTitleLabel.textAlignment = NSTextAlignment.left;
        subTitleLabel.numberOfLines = 0;
        subTitleLabel.textColor = UIColor(hexString: "#027bd6");
        subTitleLabel.font = UIFont.systemFont(ofSize: 12);
        return subTitleLabel;
    }()
    
    //moq subTitleView DDUFeedMOQView
    
    private lazy var moqView = DDUFeedMOQView.loadViewFromNib()
    
    //展会信息视图 DDUExhibitionSubtitleView
    private lazy var ehbitionInfoView = DDUExhibitionSubtitleView.loadViewFromNib()
    
    
  
    /// 懒加载 collectionView   九宫格图片
    private lazy var collectionView = FeedCollectionView.loadViewFromNib()
    ///视频视图 DDUVieoView
    private lazy var videoView = DDUVieoView.loadViewFromNib()
    //展会图片视图DDUExhBannerView 或者新闻
    private lazy var ehbitionBannerView = DDUExhBannerView.loadViewFromNib()
    
    
    /*******定位视图*****************/
    /// 懒加载 locationView
    private lazy var locationView = DDUFeedLocationView.loadViewFromNib()
    
    /*******头像视图*****************/
    /// 头像视图 DDUAvatarInfoView
    private lazy var avatarInfoView = DDUAvatarInfoView.loadViewFromNib()
    
    //DDUFeedCompanyInfoView
    private lazy var companyInfoView = DDUFeedCompanyInfoView.loadViewFromNib()
    
    /*******工具条*****************/
   
    /*******分割线*****************/
    
    
    
    /*
     * 1. titleContentView
     * 2. subTitleContentView
     * 3. picContentView
     * 4. locationContentView
     * 5. infoContentView
     */
    
    var feedModel = DDUHomeFeedListModel(){
        didSet{
            /*
             * 1. titleContentView
             * 2. subTitleContentView
             * 3. picContentView
             * 4. locationContentView
             * 5. infoContentView
             */
            for subView in titleContentView.subviews{
                subView.removeFromSuperview();
            }
            
            for subView in subTitleContentView.subviews{
                subView.removeFromSuperview();
            }
          
            for subView in picContentView.subviews{
                subView.removeFromSuperview();
            }
            
            for subView in locationContentView.subviews{
                subView.removeFromSuperview();
            }
            
            for subView in infoContentView.subviews{
                subView.removeFromSuperview();
            }
            
            /*
             * 1. titleContentView
             * 2. subTitleContentView  这个没有
             * 3. picContentView
             * 4. locationContentView
             * 5. infoContentView
             */
            
            //要更新的约束
            /*
             * 1.MainTitleViewH
             * 2.titleSubTitleMargin
             * 3.subTitleViewH
             * 4.subTitleBottomMargin
             * 5.picContentViewH
             * 6.locationViewH
             */
            
            if feedModel.cell_type == .picAndText {
                var titleH:CGFloat = feedModel.media_desc.boldTextHeight(fontSize: 14, width: (screenWidth - 30));
                if feedModel.media_desc.isEmpty{
                    titleH = 0.0;
                }
                MainTitleViewH.constant = titleH;
                titleSubTitleMargin.constant = 0.0;
                subTitleViewH.constant = 0.0;
                
                var subBottomMarginH:CGFloat = 10.0;
                if feedModel.media_desc.isEmpty {
                    subBottomMarginH = 0.0;
                }
                
                if feedModel.media_imgs.count == 0 {
                   subBottomMarginH = 0.0;
                }
                subTitleBottomMargin.constant = subBottomMarginH;
                
                //picH
                let picH = feedModel.picAndTextCollectionViewH;
                let picW = feedModel.picAndTextCollectionViewW;
                picContentViewW.constant = picW;
                picContentViewH.constant = picH;
                picLeftCons.constant = 15.0;
                // 定位视图
                var locationH = feedModel.locationViewH + 5.0;
                if feedModel.media_lbs_name.isEmpty{
                    locationH = 0.0;
                }
                
                locationViewH.constant = locationH;
                
                layoutIfNeeded();
                
                //视图更新
                if titleContentView.subviews.contains(mainTitleView){
                    mainTitleView.removeFromSuperview();
                }
                
                titleContentView.addSubview(mainTitleView);
                mainTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: titleH);
                mainTitleView.mainTitleLabel.text = String(format: "%@", feedModel.media_desc);
                
                //图片
                
                if picContentView.subviews.contains(collectionView){
                    collectionView.removeFromSuperview();
                }
                
                picContentView.addSubview(collectionView);
                collectionView.frame = CGRect(x: 0, y: 0, width: picW, height: picH);
                collectionView.thumbImages = feedModel.media_imgs;
//                collectionView.backgroundColor = UIColor.brown;
                collectionView.didSelect = { [weak self] (selectedIndex) in
                    self!.didSelectCell?(selectedIndex)
                };
                //定位
                if !feedModel.media_lbs_name.isEmpty{
                    if locationContentView.subviews.contains(locationView){
                        locationView.removeFromSuperview();
                    }
                    locationContentView.addSubview(locationView);
                    locationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: locationH);
                    locationView.locationLabel.text = String(format: "%@", feedModel.media_lbs_name);
                }
                
                //头像
                if infoContentView.subviews.contains(avatarInfoView){
                    avatarInfoView.removeFromSuperview();
                }
                
                infoContentView.addSubview(avatarInfoView);
                avatarInfoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: feedModel.avatarInfoViewH);
                
                avatarInfoView.feedModel = feedModel;
                
            }else if feedModel.cell_type == .video{
                
                var titleH:CGFloat = feedModel.media_desc.boldTextHeight(fontSize: 14, width: (screenWidth - 30));
                if feedModel.media_desc.isEmpty{
                    titleH = 0.0;
                }
                MainTitleViewH.constant = titleH;
                titleSubTitleMargin.constant = 0.0;
                subTitleViewH.constant = 0.0;
                
                var subBottomMarginH:CGFloat = 10.0;
                if feedModel.media_desc.isEmpty {
                    subBottomMarginH = 0.0;
                }
                subTitleBottomMargin.constant = subBottomMarginH;
                
                //picH
                let picH = feedModel.videoViewH;
                let picW = screenWidth;
                picContentViewW.constant = picW;
                picContentViewH.constant = picH;
                picLeftCons.constant = 0.0;
                // 定位视图
                var locationH = feedModel.locationViewH + 5.0;
                if feedModel.media_lbs_name.isEmpty{
                    locationH = 0.0;
                }
                
                locationViewH.constant = locationH;
                
                layoutIfNeeded();
                
                //视图更新
                if titleContentView.subviews.contains(mainTitleView){
                    mainTitleView.removeFromSuperview();
                }
                
                titleContentView.addSubview(mainTitleView);
                mainTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: titleH);
                mainTitleView.mainTitleLabel.text = String(format: "%@", feedModel.media_desc);
                //图片
                
                if picContentView.subviews.contains(videoView){
                    videoView.removeFromSuperview();
                }
                picContentView.addSubview(videoView);
                videoView.frame = CGRect(x: 15, y: 0, width: picW - 30, height: (picW - 30) * 0.4);
                videoView.backgroundColor = UIColor.grayColor132();
                //定位
                if !feedModel.media_lbs_name.isEmpty{
                    if locationContentView.subviews.contains(locationView){
                        locationView.removeFromSuperview();
                    }
                    locationContentView.addSubview(locationView);
                    locationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: locationH);
                    locationView.locationLabel.text = String(format: "%@", feedModel.media_lbs_name);
                }
                
                //头像
                if infoContentView.subviews.contains(avatarInfoView){
                    avatarInfoView.removeFromSuperview();
                }
                infoContentView.addSubview(avatarInfoView);
                avatarInfoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: feedModel.avatarInfoViewH);
                avatarInfoView.feedModel = feedModel;
            }else if feedModel.cell_type == .exhibition{
                var titleH:CGFloat = feedModel.info_title.boldTextHeight(fontSize: 14, width: (screenWidth - 30));
                if feedModel.info_title.isEmpty{
                    titleH = 0.0;
                }
                MainTitleViewH.constant = titleH;
                titleSubTitleMargin.constant = 6.0;
                
                let subTitleH:CGFloat = feedModel.info_intro.textHeight(fontSize: 12, width: (screenWidth - 30));
                
                subTitleViewH.constant = subTitleH;
                
                subTitleBottomMargin.constant = 10.0;
                
                //picH
                let picH = feedModel.exhibitionViewH;
                let picW = screenWidth;
                picContentViewW.constant = picW;
                picContentViewH.constant = picH;
                picLeftCons.constant = 0.0;
                // 定位视图
                var locationH = feedModel.locationViewH + 5.0;
                if feedModel.media_lbs_name.isEmpty{
                    locationH = 0.0;
                }
                locationViewH.constant = locationH;
                
                layoutIfNeeded();
                
                //视图更新
                if titleContentView.subviews.contains(mainTitleView){
                    mainTitleView.removeFromSuperview();
                }
                
                titleContentView.addSubview(mainTitleView);
                mainTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: titleH);
                mainTitleView.mainTitleLabel.text = String(format: "%@", feedModel.info_title);
                
                //副标题
                if subTitleContentView.subviews.contains(subTitleView){
                    subTitleView.removeFromSuperview();
                }
                subTitleContentView.addSubview(subTitleView);
                subTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: subTitleH);
                subTitleView.subTitleLabel.text = String(format: "%@", feedModel.info_intro);
                
                subTitleView.backgroundColor = UIColor.red;
                //图片
                
                if picContentView.subviews.contains(ehbitionBannerView){
                    ehbitionBannerView.removeFromSuperview();
                }
                
                picContentView.addSubview(ehbitionBannerView);
                ehbitionBannerView.frame = CGRect(x: 0, y: 0, width: picW, height: picH);
                ehbitionBannerView.backgroundColor = UIColor.green;
                let url =  URL(string: feedModel.info_img);
                ehbitionBannerView.iconView.kf.setImage(with: url);
                
                //定位
                if !feedModel.media_lbs_name.isEmpty{
                    if locationContentView.subviews.contains(locationView){
                        locationView.removeFromSuperview();
                    }
                    locationContentView.addSubview(locationView);
                    locationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: locationH);
                    locationView.locationLabel.text = String(format: "%@", feedModel.media_lbs_name);
                }
                
                //头像
                if infoContentView.subviews.contains(avatarInfoView){
                    avatarInfoView.removeFromSuperview();
                }
                infoContentView.addSubview(avatarInfoView);
                avatarInfoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: feedModel.avatarInfoViewH);
                avatarInfoView.feedModel = feedModel;
            }else if feedModel.cell_type == .news{
                //主标题副标题
                var titleH:CGFloat = feedModel.info_title.boldTextHeight(fontSize: 14, width: (screenWidth - 30));
                if feedModel.info_title.isEmpty{
                    titleH = 0.0;
                }
                MainTitleViewH.constant = titleH ;
                titleSubTitleMargin.constant = 6.0;
                
                let subTitleH:CGFloat = feedModel.info_intro.textHeight(fontSize: 12, width: (screenWidth - 30));
                
            
                subTitleViewH.constant = subTitleH;
                
                subTitleBottomMargin.constant = 10.0;
                
                //picH
                let picH = feedModel.exhibitionViewH;
                let picW = screenWidth;
                picContentViewW.constant = picW;
                picContentViewH.constant = picH;
                picLeftCons.constant = 0.0;
                // 定位视图
                var locationH = feedModel.locationViewH + 5.0;
                if feedModel.media_lbs_name.isEmpty{
                    locationH = 0.0;
                }
                locationViewH.constant = locationH;
                
                layoutIfNeeded();
                
                //视图更新
                if titleContentView.subviews.contains(mainTitleView){
                    mainTitleView.removeFromSuperview();
                }
                
                titleContentView.addSubview(mainTitleView);
                mainTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: titleH);
                mainTitleView.mainTitleLabel.text = String(format: "%@", feedModel.info_title);
                
                
                subTitleContentView.backgroundColor = UIColor.orange;
                if subTitleContentView.subviews.contains(subTitleView){
                    subTitleView.removeFromSuperview();
                }

                subTitleContentView.addSubview(subTitleView);
                subTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: subTitleH);
                
                subTitleView.subTitleLabel.text = String(format: "%@", feedModel.info_intro);
                
              
                //图片
                
                if picContentView.subviews.contains(ehbitionBannerView){
                    ehbitionBannerView.removeFromSuperview();
                }
                
                picContentView.addSubview(ehbitionBannerView);
                ehbitionBannerView.frame = CGRect(x: 0, y: 0, width: picW, height: picH);
//                ehbitionBannerView.backgroundColor = UIColor.green;
                let url =  URL(string: feedModel.info_img);
                ehbitionBannerView.iconView.kf.setImage(with: url);
                
                
                //定位
                if !feedModel.media_lbs_name.isEmpty{
                    if locationContentView.subviews.contains(locationView){
                        locationView.removeFromSuperview();
                    }
                    locationContentView.addSubview(locationView);
                    locationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: locationH);
                    locationView.locationLabel.text = String(format: "%@", feedModel.media_lbs_name);
                }
                
                //头像
                if infoContentView.subviews.contains(avatarInfoView){
                    avatarInfoView.removeFromSuperview();
                }
                infoContentView.addSubview(avatarInfoView);
                avatarInfoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: feedModel.avatarInfoViewH);
                avatarInfoView.feedModel = feedModel;
            }else if feedModel.cell_type == .product{
                // 产品
                //主标题副标题
                var titleH:CGFloat = feedModel.prd_title.boldTextHeight(fontSize: 14, width: (screenWidth - 30));
                if feedModel.prd_title.isEmpty{
                    titleH = 0.0;
                }
                MainTitleViewH.constant = titleH;
                titleSubTitleMargin.constant = 6.0;
                
                let subTitleH:CGFloat = 23.0;
                
                subTitleViewH.constant = subTitleH;
                
                subTitleBottomMargin.constant = 10.0;
                
                //picH
                let picH = feedModel.productCollectionViewH;
                let picW = feedModel.productCollectionViewW;
                picContentViewW.constant = picW;
                picContentViewH.constant = picH;
                picLeftCons.constant = 15.0;
                // 定位视图
                var locationH = feedModel.locationViewH + 5.0;
                if feedModel.media_lbs_name.isEmpty{
                    locationH = 0.0;
                }
                locationViewH.constant = locationH;
                
                layoutIfNeeded();
                
                //视图更新
                if titleContentView.subviews.contains(mainTitleView){
                    mainTitleView.removeFromSuperview();
                }
                
                titleContentView.addSubview(mainTitleView);
                mainTitleView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: titleH);
                mainTitleView.mainTitleLabel.text = String(format: "%@", feedModel.prd_title);
                
                if subTitleContentView.subviews.contains(moqView){
                    moqView.removeFromSuperview();
                }
                subTitleContentView.addSubview(moqView);
                moqView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 23.0);
                
                
                //图片
                
                if picContentView.subviews.contains(collectionView){
                    collectionView.removeFromSuperview();
                }
                
                picContentView.addSubview(collectionView);
                collectionView.frame = CGRect(x:0, y: 0, width: picW, height: picH);
                collectionView.thumbImages = feedModel.prd_imgs;
//                collectionView.backgroundColor = UIColor.orange;
                
                collectionView.didSelect = { [weak self] (selectedIndex) in
                    self!.didSelectCell?(selectedIndex)
                };
                //定位
                if !feedModel.media_lbs_name.isEmpty{
                    if locationContentView.subviews.contains(locationView){
                        locationView.removeFromSuperview();
                    }
                    locationContentView.addSubview(locationView);
                    locationView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: locationH);
                    locationView.locationLabel.text = String(format: "%@", feedModel.media_lbs_name);
                }
                
                //头像
                if infoContentView.subviews.contains(companyInfoView){
                    companyInfoView.removeFromSuperview();
                }
                infoContentView.addSubview(companyInfoView);
                companyInfoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: feedModel.avatarInfoViewH);
            }
        }
    }


}
