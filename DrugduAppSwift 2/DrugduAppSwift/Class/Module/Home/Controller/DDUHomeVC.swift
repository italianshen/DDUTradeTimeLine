//
//  DDUHomeVC.swift
//  DrugduAppSwift
//
//  Created by 沈士新 on 2018/6/21.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit
import Kingfisher;

class DDUHomeVC: UIViewController {
    // MARK: - 轮播图
    var cycleScrollView:WRCycleScrollView?
    
    //头部轮播图
    var headerView:DDUHomeTableHeaderView?
    
    //轮播图数据
    var image_urls :[String]?{
        didSet {
            headerView?.image_urls = image_urls;
        }
    }
    
    
    var feedList  = [DDUHomeFeedListModel](){
        didSet {
            tableView.reloadData()
        }
    }
    
    var pageIndex :Int = 0;
    
    
    
    // MARK: - tableView
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain);
        tableView.sectionFooterHeight = 0;
        tableView.sectionHeaderHeight = 0;
        
        tableView.estimatedSectionHeaderHeight = 0.1;
        tableView.estimatedSectionFooterHeight = 0.1;
        tableView.separatorStyle = .none;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.showsVerticalScrollIndicator = true;
        tableView.showsHorizontalScrollIndicator = false;
        //DDUFeedListViewCell
         tableView.ym_registerCell(cell: DDUFeedListViewCell.self)
        self.view.addSubview(tableView);
        return tableView;
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(hexString: "#D9E3ED");
        var navBarH:CGFloat = 64.0;
        let toolBarH:CGFloat = 49.0;
        if screenHeight == 812{
            navBarH = 88;
        }
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - (navBarH) - (toolBarH));
        let kScreenWidth = UIScreen.main.bounds.width;
        let hLoopViewheight:CGFloat = 150.0 * kScreenWidth / 375.0;
        let vLoopViewH:CGFloat = 61.0 * 2;
        let margin:CGFloat = 10.0;
        
        let headerH = hLoopViewheight + margin + vLoopViewH + margin;
        headerView = DDUHomeTableHeaderView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: headerH))
//        view.addSubview(headerView!);
        tableView.tableHeaderView = headerView;
        
        let footer = UIView();
        footer.backgroundColor = UIColor(hexString: "#D9E3ED");
        tableView.tableFooterView = footer;
        //设置上下拉刷新
        setupRefresh();
        loadNewData();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    
    func setupRefresh() {
        let header = RefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData));
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.isAutomaticallyChangeAlpha = true
        tableView.mj_header = header;
        
        let footer = RefreshAutoGifFooter(refreshingTarget: self, refreshingAction: #selector(loadMore));
        
        tableView.mj_footer = footer;
    }
    
    //下拉刷新
     @objc func loadNewData() {
        pageIndex = 1;
        weak var weakSelf = self;
        NetworkTool.loadHomeFeedListData(page: String(format: "%d", pageIndex)) { (result) in
            weakSelf?.feedList.removeAll();
            weakSelf?.feedList.append(contentsOf: result);
            weakSelf?.tableView.reloadData();
            weakSelf?.tableView.mj_header.endRefreshing();
            if result.count == 0{weakSelf?.tableView.mj_footer.endRefreshingWithNoMoreData();
            }else{
                weakSelf?.tableView.mj_footer.endRefreshing();
            }
        }
    }
    
    //上拉加载更多
    @objc func loadMore() {
        let cache = KingfisherManager.shared.cache;
        //清理内存缓存
        cache.clearMemoryCache()
        // 清理硬盘缓存，这是一个异步的操作
        cache.clearDiskCache()
        pageIndex += 1;
        weak var weakSelf = self;
        //删除缓存图片
        NetworkTool.loadHomeFeedListData(page: String(format: "%d", pageIndex), completionHandler: { (result) in
            weakSelf?.feedList.append(contentsOf: result);
            weakSelf?.tableView.reloadData();
            weakSelf?.tableView.mj_header.endRefreshing();
            if result.count == 0{
                weakSelf?.tableView.mj_footer.endRefreshingWithNoMoreData();
            }else{
                weakSelf?.tableView.mj_footer.endRefreshing();
            }
        }) { (error) in
            print("出错了" + "\(error)");
             weakSelf?.tableView.mj_footer.endRefreshing();
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        let cache = KingfisherManager.shared.cache;
        // 设置硬盘最大缓存50M ，默认无限
        cache.maxDiskCacheSize = 50 * 1024 * 1024
        // 设置硬盘最大保存3天 ， 默认1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
        //清理内存缓存
        cache.clearMemoryCache()
        // 清理硬盘缓存，这是一个异步的操作
        cache.clearDiskCache()
        // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
        cache.cleanExpiredDiskCache()
        print("home VC 收到内存警告了");
    }
}


// MARK: - extension
extension DDUHomeVC:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feedList.count == 0 {
            return 0;
        }
        return (feedList.count);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as DDUFeedListViewCell
        //绑定数据模型
        cell.feedModel = feedList[indexPath.row];
        cell.selectionStyle = .none;
        cell.didSelectCell = {[weak self] (selectedIndex) in
            let previewBigImageVC = PreviewDongtaiBigImageController()
            let feedModel = self!.feedList[indexPath.row];
            if feedModel.cell_type == .picAndText {
                previewBigImageVC.images = cell.feedModel.media_imgs;
            }else if feedModel.cell_type == .product{
                previewBigImageVC.images = cell.feedModel.prd_imgs;
            }
            previewBigImageVC.selectedIndex = selectedIndex
            self!.present(previewBigImageVC, animated: false, completion: nil)
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let feedModel:DDUHomeFeedListModel = feedList[indexPath.row];
        return feedModel.cellHeight;
    }
    
    
    
}
