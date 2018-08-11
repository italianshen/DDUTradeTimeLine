//
//  DrugduConst.swift
//  DrugduAppSwift
//
//  Created by 沈士新 on 2018/6/21.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit

let BASE_URL = "http://m.betaddu.drugdu.com";


/// 屏幕的宽度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕的高度
let screenHeight = UIScreen.main.bounds.height

let isIPhoneX: Bool = screenHeight == 812 ? true : false

//版本号的key
let DDUHomeFeedVersionKey = "DDUHomeFeedVersionKey";


/// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = screenWidth * 0.5
let image2Width: CGFloat = (screenWidth - 35) * 0.5
let image3Width: CGFloat = (screenWidth - 40) / 3
