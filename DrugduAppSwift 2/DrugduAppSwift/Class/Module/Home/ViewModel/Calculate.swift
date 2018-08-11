//
//  Calculate.swift
//  News
//
//  Created by Danny on 2017/12/10.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol Calculatable {
    // MARK: 计算宽度
    static func collectionViewWidth(_ count: Int) -> CGFloat
    // MARK: 计算高度
    static func collectionViewHeight(_ count: Int) -> CGFloat
    // MARK: 计算 collectionViewCell 的大小
    static func collectionViewCellSize(_ count: Int) -> CGSize
    // MARK: 计算富文本的高度
    static func attributedTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat
    // MARK: 计算文本的高度
    static func textHeight(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat
    // MARK: 计算文本的宽度
    static func textHieght(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat
    // MARK: 从文本内容中获取 uid 和 用户名
    // MARK: 计算详情里的 collectionViewCell 的大小
    static func detailCollectionViewCellSize(_ thumbImages: [String]) -> CGSize
    // MARK: 计算详情里的高度
    static func detailCollectionViewHieght(_ thumbImages: [String]) -> CGFloat
}

extension Calculatable {
    
    /// 计算高度
    static func detailCollectionViewHieght(_ thumbImages: [String]) -> CGFloat {
        switch thumbImages.count {
        case 1:
//            let thumbImage = thumbImages.first!
            let height = (screenWidth - 30) * 0.4;
//            return (screenWidth - 30) * thumbImage.height / thumbImage.width
            return height;
        case 2: return (screenWidth - 35) * 0.5
        case 3: return image3Width + 5
        case 4: return (screenWidth - 3)
        case 5, 6: return (image3Width + 5) * 2
        case 7...9: return (image3Width + 5) * 3
        default: return 0
        }
    }
    
    /// 计算情里的 collectionViewCell 的大小
    static func detailCollectionViewCellSize(_ thumbImages: [String]) -> CGSize {
        switch thumbImages.count {
        case 1:
//            let thumbImage = thumbImages.first!
            //根据url区获取宽高
//            let height = (screenWidth - 30) * thumbImage.height / thumbImage.width
            let height = (screenWidth - 30) * 0.4;
            return CGSize(width: (screenWidth - 30), height: height)
        case 2, 4:
            let image2W = (screenWidth - 35) * 0.5
            return CGSize(width: image2W, height: image2W)
        case 3, 5...9: return CGSize(width: image3Width, height: image3Width)
        default: return .zero
        }
    }
   
    
    /// 计算宽度
    static func collectionViewWidth(_ count: Int) -> CGFloat {
        switch count {
        case 1, 2: return (image2Width + 5) * 2
        case 3, 5...9: return screenWidth - 30
        case 4: return (image3Width + 5) * 2
        default: return 0
        }
    }
    
    /// 计算高度
    static func collectionViewHeight(_ count: Int) -> CGFloat {
        switch count {
        case 1: return (screenWidth - 30) * 0.4
        case 2: return image2Width
        case 3: return image3Width + 5
        case 4: return (image3Width + 5) * 2
        case 5...6: return (image3Width + 5) * 2
        case 7...9: return (image3Width + 5) * 3
        default: return 0
        }
    }
    /// 计算 collectionViewCell 的大小
    static func collectionViewCellSize(_ count: Int) -> CGSize {
        switch count {
        case 1: return CGSize(width: image2Width, height: (screenWidth - 30) * 0.4)
        case 2: return CGSize(width: image2Width, height: image2Width)
//        case 1, 2: return CGSize(width: image2Width, height: image2Width)
        case 3...9: return CGSize(width: image3Width, height: image3Width)
        default: return .zero
        }
    }
    
    /// 计算富文本的高度
    static func attributedTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size.height + 5.0
    }
    
    /// 计算文本的高度
    static func textHeight(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height + 5.0
    }
    
    /// 计算文本的宽度
    static func textHieght(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
}

struct Calculate: Calculatable {}
