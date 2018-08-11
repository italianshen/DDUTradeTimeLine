//
//  DDUCycleScrollView.swift
//  DrugduAppSwift
//
//  Created by Danny on 2018/7/16.
//  Copyright © 2018年 danny. All rights reserved.
// swift 跑马灯

import UIKit

//宏定义
let SMKMaxSections = 10


class DDUCycleScrollView: UIView {
   // MARK: - 模型数组
    var titleArray = [DDUEasySourcingModel](){
        didSet {
            if titleArray.isEmpty{
                self.removeTimer();
                return;
            }
            
            if titleArray.count == 1 {
                self.removeTimer();
            }
            
            if titleArray.count > 1 {
                self.removeTimer();
                self.addTimer();
                self.tableView.reloadData();
                //滚动到中间去
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: SMKMaxSections/2), at: UITableViewScrollPosition.top, animated: false);
            }
        }
    }
    
    // MARK: - 是否可以拖拽
    var isCanScroll:Bool = false{
        didSet{
            self.tableView.isScrollEnabled = isCanScroll;
        }
    }
    
    // MARK: - 字体颜色
    var titleColor:UIColor = UIColor.black;
    
    // MARK: - 背景颜色
    var backColor:UIColor = UIColor.white;
    
    //字体颜色
    var titleFont:UIFont = UIFont.systemFont(ofSize: 14.0);
    
    //点击block回调 ->闭包
    
    // MARK: - tableView
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped);
        tableView.sectionFooterHeight = 0;
        tableView.sectionHeaderHeight = 0;
        tableView.separatorStyle = .none;
        tableView.rowHeight = 61;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        tableView.isScrollEnabled = false;
        tableView.isPagingEnabled = true;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)");
        tableView.ym_registerCell(cell: DDUEasySourcingViewCell.self)
        self.addSubview(tableView);
        return tableView;
    }()
    

    var timer:Timer?
    
    
    //MARK: - 关闭定时器
    func removeTimer(){
        timer?.invalidate();
        self.timer = nil;
    }
    // MARK: - 添加定时器
    func addTimer(){
        timer = Timer.init(timeInterval: 6.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true);
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes);
    }
    
    deinit {
        timer?.invalidate();
        self.timer = nil;
    }
   
    
    // MARK: - init method
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        tableView.frame = self.bounds;
    }
    
    func setupUI() {
//        loadBundleEasySourcingData
        NetworkTool.loadBundleEasySourcingData { (result) in
            self.titleArray = result;
        }
        
        NetworkTool.loadEasySourcingServelData { (result) in
            self.titleArray = result;
        }
    }
    
    // MARK: - 重置IndexPath
    func resetIndexPath() -> IndexPath {
        let currentIndexPath = tableView.indexPathsForVisibleRows?.last;
        if currentIndexPath != nil {
            //马上显示回到中间那组的数据
            let currentIndexPathReset = IndexPath(row: 0, section: SMKMaxSections/2);
            tableView.scrollToRow(at: currentIndexPathReset, at: UITableViewScrollPosition.bottom, animated: false);
            return currentIndexPath!;
        }
        return IndexPath(row: 0, section: 0);
    }
    
    // MARK: - 下一页
    @objc func nextPage(){
        // 马上显示回最中间的那组数据
        let currentIndexPathReset = resetIndexPath();
        if currentIndexPathReset.section != 0 {
            // 2.计算出下一个需要展示的位置
            var nextItem = currentIndexPathReset.row + 1;
            var nextSection = currentIndexPathReset.section;
            if nextItem >= titleArray.count{
                nextItem = 0;
                nextSection += 1;
            }
            var nextIndexPath:IndexPath;
            
            if nextSection == SMKMaxSections{
                
                nextIndexPath = IndexPath(row: nextItem, section: (nextSection - 1));
            }else{
                nextIndexPath = IndexPath(row: nextItem, section: nextSection);
            }
            tableView.scrollToRow(at: nextIndexPath, at: UITableViewScrollPosition.bottom, animated: false);
        }
    }
}

extension  DDUCycleScrollView:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SMKMaxSections;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as DDUEasySourcingViewCell
        //绑定数据模型
        cell.model = titleArray[indexPath.row];
        return cell;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if titleArray.count > 1 {
            self.addTimer();
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeTimer();
    }
    

}


