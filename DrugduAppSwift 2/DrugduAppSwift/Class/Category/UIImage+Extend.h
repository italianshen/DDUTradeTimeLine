//
//  UIImage+Extend.h
//  ZNB
//
//  Created by znb_iOS on 16/6/3.
//  Copyright © 2016年 znb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor: (UIColor *)color imageSize:(CGSize)size;

+ (UIImage*)convertViewToImage:(UIView*)view;

- (UIImage*)scaleToSize:(CGSize)size;

- (UIImage *)zoomToSize:(CGSize)size;

- (UIImage *)fixOrientation;

- (UIImage *)cutFromRect:(CGRect)rect;

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

//计算图片的尺寸大小
-(void)caculateTheImageStorageSize;


-(UIImage *)dduZoomImage;


/**
 调整图片 到尺寸

 @param img 需要压缩的对象
 @param size 限制最高数据量KB
 @param delta 每循环一次步进值
 @return 二进制数据
 */
+ (NSData *)adjustImageSize:(UIImage *)img limitSize:(NSInteger)size step:(float)delta;

@end
