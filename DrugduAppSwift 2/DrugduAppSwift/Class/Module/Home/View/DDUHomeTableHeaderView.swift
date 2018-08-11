//
//  DDUHomeTableHeaderView.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/24.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit

class DDUHomeTableHeaderView: UIView {

    // MARK: - 轮播图
    var cycleScrollView:WRCycleScrollView?
    
    
    //轮播图数据
    var image_urls :[String]?{
        didSet {
            cycleScrollView?.serverImgArray = image_urls;
            cycleScrollView?.reloadData();
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        prepareUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepareUI() -> () {
        self.backgroundColor = UIColor(hexString: "#d9e3ed");
        
        //添加轮播图
        let image_urls = ["http://img09.static.betaddu.drugdu.com/audit/0_2f962d8d48305ea40e909e202bdaf37a.jpg","http://img09.static.betaddu.drugdu.com/audit/0_2f962d8d48305ea40e909e202bdaf37a.jpg","http://img09.static.betaddu.drugdu.com/audit/0_2f962d8d48305ea40e909e202bdaf37a.jpg"];
        
        let kScreenWidth = UIScreen.main.bounds.width;
        let height = 150.0 * kScreenWidth / 375.0;
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: height)
        // 可加载网络图片或者本地图片
        // 构造方法
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: image_urls);
        addSubview(cycleScrollView!)
        // 添加代理
       cycleScrollView?.delegate = self
        
        //DDUCycleScrollView
        let loopView = DDUCycleScrollView(frame: CGRect.init(x: 0, y: height + 10, width: self.bounds.width, height: 61 * 2.0));

        addSubview(loopView);
        
        
        //加载banner数据
        loadBannerData();
    }
    
    
    // MARK: - 加载轮播数据
    func  loadBannerData()  {
        NetworkTool.loadHomeBannerDataList { (response) in
            var image_url_arr = [String]();
            for item:DDUHomeBanner in response{
                print("image_url:" + item.img_url);
                if !item.img_url.isEmpty{
                    image_url_arr.append(item.img_url);
                }
            }
            self.image_urls = image_url_arr;
        }
    }

}

// MARK: - extension
extension DDUHomeTableHeaderView : WRCycleScrollViewDelegate{
    /// 点击图片回调
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView){
        print("click:" + "\(index)");
    }
    /// 图片滚动回调
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView){
        print("click1:" + "\(index)");
    }
}
