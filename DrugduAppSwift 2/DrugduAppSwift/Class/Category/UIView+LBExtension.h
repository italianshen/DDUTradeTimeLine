//
//  UIView+LBExtension.h
//  
//
//  Created by Danny on 16/5/28.
//  Copyright © 2016年 Danny. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (LBExtension)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;

@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;

@property (nonatomic,assign) CGPoint origin;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;


//寻找分类
- (UIView*)subViewOfClassName:(NSString*)className;

@end
