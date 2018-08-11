//
//  NetworkTool.swift
//  DrugduAppSwift
//
//  Created by 沈士新 on 2018/6/21.
//  Copyright © 2018年 danny. All rights reserved.
// http://m.betaddu.drugdu.com/moni?t=molay

import UIKit
import Alamofire
import SwiftyJSON
protocol NetworkToolProtocol{
   
    // MARK: 首页顶部新闻标题的数据
    static func loadHomeFeedsNewsList(completionHandler: @escaping (_ newsTitles: [DDUHomeActivityModel]) -> ())
    
    // MARK: 首页banner图数组
    static func loadHomeBannerDataList(completionHandler: @escaping (_ banners: [DDUHomeBanner]) -> ())

    // MARK: - 加载首页easysourcing 沙盒数据 DDUEasySourcingModel
    static func loadBundleEasySourcingData(completionHandler: @escaping (_ banners: [DDUEasySourcingModel]) -> ())
    
    // MARK: - 加载easySourcing数据
    static func loadEasySourcingServelData(completionHandler: @escaping (_ banners: [DDUEasySourcingModel]) -> ())
    
    // MARK: - 加载首页feed数据 //api/app/feeds-new/list.json
    static func loadHomeFeedListData(page:String,completionHandler: @escaping (_ feedsList: [DDUHomeFeedListModel]) -> ())
    
    // 加载首页数据 成功 失败
    static func loadHomeFeedListData(page:String,completionHandler: @escaping (_ feedsList: [DDUHomeFeedListModel]) -> (),failureHandler: @escaping (_ error: Error) -> ())
    
}


extension  NetworkToolProtocol{
    
    static func loadHomeFeedsNewsList(completionHandler: @escaping (_ newsTitles: [DDUHomeActivityModel]) -> ()){
        //网络请求
        //http://m.betaddu.drugdu.com/api/data/base_banner.json?appid=1&ver=1&hash=376c1047e08ebc55ba6a5e95ca9988f1&token=1
        //BASE_URL
        let url = BASE_URL + "/api/data/base_banner.json?";
        let params = ["appid": "1",
                      "ver"  : "1",
                      "token": "1",
                      "hash"  : "376c1047e08ebc55ba6a5e95ca9988f1"];
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            //网络错误的提示信息
            guard response.result.isSuccess else{
                return;
            }
            //解析json
            if let value = response.result.value{
                let json = JSON(value);
                guard json["code"] .intValue == 200 else{
                    let str =  String.init(format:"failed %@",json["code"].stringValue);
                    print(str);
                    return;
                }
                if let dataDict = json["rt"].dictionary{
                   //再提取里面的banner  DDUHomeBanner
                    if let bannerDatas = dataDict["banner_list"]?.arrayObject{
                        //再提取里面的banner  DDUHomeBanner
                       //datas.compactMap({ DongtaiUserDigg.deserialize(from: $0 as? Dictionary)
                        
                        var bannerList = [DDUHomeBanner]();
                        bannerList.append(DDUHomeBanner.deserialize(from: "{\"img_url\": \"\", \"link\": \"\",\"sort_id\": \"\"}")!);
                        bannerList += bannerDatas.compactMap({ DDUHomeBanner.deserialize(from: $0 as? Dictionary) })
//                        completionHandler(bannerList)
                    }
                }
            }
        }
    }
    // MARK: - 加载首页数据成功或者失败
    static func loadHomeFeedListData(page:String,completionHandler: @escaping (_ feedsList: [DDUHomeFeedListModel]) -> (),failureHandler: @escaping (_ error: Error) -> ()){
        
        let url = BASE_URL + "/api/app/feeds-new/list.json?";
        let params = ["appid": "1",
                      "ver"  : "1",
                      "token": "1",
                      "hash" : "1",
                      "v"    : "",
                      "page" :page];
        //请求
        Alamofire.request(url, method: .post, parameters: params,encoding:URLEncoding.default, headers:nil).responseJSON { (response) in
            //网络错误的提示信息
            guard response.result.isSuccess else{
                //调用failure
                print("failure:" + "\(response)" + "Reason:" + "\(response.result.description)");
                let err = response.result.error
                failureHandler(err!);
                return;
            }
            //解析json
            if let value = response.result.value{
                let json = JSON(value);
                guard json["code"] .intValue == 200 else{
                    let str =  String.init(format:"failed %@",json["code"].stringValue);
                    print(str);
                    return;
                }
                
                if let dataDict = json["rt"].dictionary{
                    //存储v
                    let serverV = dataDict["v"]?.string;
                    
                    UserDefaults.standard.setValue(serverV, forKey: DDUHomeFeedVersionKey);
                    UserDefaults.standard.synchronize();
                    //再提取里面的data -->feedlist
                    if let feedDatas = dataDict["data"]?.arrayObject{
                        var feedList = [DDUHomeFeedListModel]();
                        feedList += feedDatas.compactMap({ DDUHomeFeedListModel.deserialize(from: $0 as? Dictionary) });
                        //feedList给类型
                        for item in feedList{
                            if item.type == "1"{
                                if item.media_type == "1"{
                                    item.cell_type = .picAndText;
                                }else if item.media_type == "2"{
                                    item.cell_type = .video;
                                }
                            }else if item.type == "2"{
                                if item.info_type == "1"{
                                    item.cell_type = .news;
                                }else if item.info_type == "2"{
                                    item.cell_type = .exhibition;
                                }
                            }else if item.type == "3"{
                                item.cell_type = .product;
                            }
                        }
                        completionHandler(feedList);
                    }
                }
            }
        }
        
    }
    // MARK: - banners
    static func loadHomeBannerDataList(completionHandler: @escaping (_ banners: [DDUHomeBanner]) -> ()){
        //网络请求
        //http://m.betaddu.drugdu.com/api/data/base_banner.json?appid=1&ver=1&hash=376c1047e08ebc55ba6a5e95ca9988f1&token=1
        //BASE_URL
        let url = BASE_URL + "/api/data/base_banner.json?";
        let params = ["appid": "1",
                      "ver"  : "1",
                      "token": "1",
                      "hash" : "376c1047e08ebc55ba6a5e95ca9988f1"];
        Alamofire.request(url, parameters:params).responseJSON { (response) in
            //网络错误的提示信息
            guard response.result.isSuccess else{
                return;
            }
            //解析json
            if let value = response.result.value{
                let json = JSON(value);
                guard json["code"] .intValue == 200 else{
                    let str =  String.init(format:"failed %@",json["code"].stringValue);
                    print(str);
                    return;
                }
                if let dataDict = json["rt"].dictionary{
                    //再提取里面的banner  DDUHomeBanner
                    if let bannerDatas = dataDict["banner_list"]?.arrayObject{
                        var bannerList = [DDUHomeBanner]();
                    bannerList.append(DDUHomeBanner.deserialize(from: "{\"img_url\": \"\", \"link\": \"\",\"sort_id\": \"\"}")!);
                        bannerList += bannerDatas.compactMap({ DDUHomeBanner.deserialize(from: $0 as? Dictionary) })
                        completionHandler(bannerList)
                    }
                }
            }
        }
    }
    // MARK: - 加载首页easysourcing 沙盒数据 DDUEasySourcingModel
    static func loadBundleEasySourcingData(completionHandler: @escaping (_ banners: [DDUEasySourcingModel]) -> ()){
        //easysourcing
        let path = Bundle.main.path(forResource: "easysourcing", ofType: "json")
        let data = NSData.init(contentsOfFile: path!);
        
        let jsonDic:NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        let array = jsonDic.object(forKey: "data") as! NSArray;
        var sections = [DDUEasySourcingModel]();
        sections += array.compactMap({ DDUEasySourcingModel.deserialize(from: $0 as? Dictionary) })
        print("\(sections)");
        completionHandler(sections);
    }
    
   
    // MARK: - 加载easySourcing数据
    static func loadEasySourcingServelData(completionHandler: @escaping (_ banners: [DDUEasySourcingModel]) -> ()){
        //BASE_URL "/api/data/base_banner.json?";
//        let url = BASE_URL + "/api/app/easy_sourcing.json?";
        let url = BASE_URL + "/api/app/easy_sourcing.json?";
        let params = ["appid": "1",
                      "ver"  : "1",
                      "token": "1",
                      "hash" : "1"];
        
        Alamofire.request(url, method: .post, parameters: params,encoding:URLEncoding.default, headers:nil).responseJSON { (response) in
            //网络错误的提示信息
            guard response.result.isSuccess else{
                return;
            }
            //解析json
            if let value = response.result.value{
                let json = JSON(value);
                guard json["code"] .intValue == 200 else{
                    let str =  String.init(format:"failed %@",json["code"].stringValue);
                    print(str);
                    return;
                }
                
                if let dataDict = json["rt"].dictionary{
                    //再提取里面的banner  DDUHomeBanner
                    if let bannerDatas = dataDict["data"]?.arrayObject{
                        var bannerList = [DDUEasySourcingModel]();
                        bannerList += bannerDatas.compactMap({ DDUEasySourcingModel.deserialize(from: $0 as? Dictionary) })
                        completionHandler(bannerList)
                    }
                }
            }
        }
    }
    
    
    // MARK: - 加载首页feed数据 //api/app/feeds-new/list.json
    static func loadHomeFeedListData(page:String,completionHandler: @escaping (_ feedsList: [DDUHomeFeedListModel]) -> ()){
        
        let url = BASE_URL + "/api/app/feeds-new/list.json?";
//        let cacheV = "";
//        if (UserDefaults.standard.string(forKey: DDUHomeFeedVersionKey)) != nil {
//            cacheV = String(format: "%@", UserDefaults.standard.value(forKey: DDUHomeFeedVersionKey) as! CVarArg);
//        }
//        //DDUHomeFeedVersionKey
//        var currentV = cacheV;
//        if page == "1" {
//            currentV = "";
//        }
        let params = ["appid": "1",
                      "ver"  : "1",
                      "token": "1",
                      "hash" : "1",
                      "v"    : "",
                      "page" :page];
        //请求
        Alamofire.request(url, method: .post, parameters: params,encoding:URLEncoding.default, headers:nil).responseJSON { (response) in
            //网络错误的提示信息
            guard response.result.isSuccess else{
                //调用failure
                print("failure:" + "\(response)" + "Reason:" + "\(response.result.description)");
                return;
            }
            //解析json
            if let value = response.result.value{
                let json = JSON(value);
                guard json["code"] .intValue == 200 else{
                    let str =  String.init(format:"failed %@",json["code"].stringValue);
                    print(str);
                    return;
                }
                
                if let dataDict = json["rt"].dictionary{
                    //存储v
                    let serverV = dataDict["v"]?.string;

                    UserDefaults.standard.setValue(serverV, forKey: DDUHomeFeedVersionKey);
                    UserDefaults.standard.synchronize();
                    //再提取里面的data -->feedlist
                    if let feedDatas = dataDict["data"]?.arrayObject{
                        var feedList = [DDUHomeFeedListModel]();
                        feedList += feedDatas.compactMap({ DDUHomeFeedListModel.deserialize(from: $0 as? Dictionary) });
                        //feedList给类型
                        for item in feedList{
                            if item.type == "1"{
                                if item.media_type == "1"{
                                   item.cell_type = .picAndText;
                                }else if item.media_type == "2"{
                                   item.cell_type = .video;
                                }
                            }else if item.type == "2"{
                                if item.info_type == "1"{
                                    item.cell_type = .news;
                                }else if item.info_type == "2"{
                                    item.cell_type = .exhibition;
                                }
                            }else if item.type == "3"{
                                item.cell_type = .product;
                            }
                        }
                        completionHandler(feedList);
                    }
                }
            }
        }
        
    }
    
}

struct NetworkTool: NetworkToolProtocol {}
