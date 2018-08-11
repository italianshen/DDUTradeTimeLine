//
//  NSString+DDUExtension.h
//  DDU
//
//  Created by 沈士新 on 2017/5/11.
//  Copyright © 2017年 沈士新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DDUExtension)
- (unsigned long long)fileSize;

+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat;


-(BOOL) NSStringIsValidEmail:(NSString *)checkString;


/**
 *  根据url截取query生成字典数组
 */
-(NSArray *)transformParameterToJsonWithURL:(NSString *)URLString;


//去除字符串中的所有空格和换行
- (NSString *)removeSpaceAndNewline:(NSString *)str;
@end
