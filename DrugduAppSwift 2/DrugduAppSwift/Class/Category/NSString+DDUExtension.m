//
//  NSString+DDUExtension.m
//  DDU
//
//  Created by 沈士新 on 2017/5/11.
//  Copyright © 2017年 沈士新. All rights reserved.
//

#import "NSString+DDUExtension.h"

@implementation NSString (DDUExtension)

- (unsigned long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 是否为文件夹
    BOOL isDirectory = NO;
    
    // 路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
    
    if (isDirectory) { // 文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    } else { // 文件
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return size;
}



/**
 *  根据时间格式返回日期字符串
 *
 *  @param date       日期对象
 *  @param dateFormat 时间格式
 *
 *  @return  组装好的字符串
 */
+ (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}


/**
 *  检查字符串是否是邮箱
 */
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;//Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


-(NSArray *)transformParameterToJsonWithURL:(NSString *)URLString{
    
    NSMutableArray * dataArray =[NSMutableArray array];
    //用来作为函数的返回值，数组里里面可以存放每个url转换的字典
    NSMutableArray *arrayData = [NSMutableArray arrayWithCapacity:6];
    
    //获取数组，数组里装得是url
    NSMutableArray *arrayURL = [NSMutableArray arrayWithObject:URLString];
    NSLog(@"获取到得URL数组如下：n%@", arrayURL);
    //循环对数组中的每个url进行处理，把参数转换为字典
    for (int i = 0; i < arrayURL.count; i ++)
    {
        NSLog(@"第%d个URL的处理过程：%@", i+1, arrayURL[i]);
        //获取问号的位置，问号后是参数列表
        NSRange range = [arrayURL[i] rangeOfString:@"?"];
        NSLog(@"参数列表开始的位置：%d", (int)range.location);
        //获取query参数列表
        NSString *propertys = [arrayURL[i] substringFromIndex:(int)(range.location+1)];
        NSLog(@"截取的参数列表：%@", propertys);
        //进行字符串的拆分，通过&来拆分，把每个参数分开
        /*
         截取的参数列表：ID=31679&imgurl=http://img03.qstatic.drugdu.com/company/0_425427b3beee86c468bebd3cd5a9030c.png&supplier_name=Hefei Hengmai Imp&Exp Co.,Ltd
         
         */
        NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
        NSLog(@"把每个参数列表进行拆分，返回为数组：n%@", subArray);
        
        //把subArray转换为字典
        //tempDic中存放一个URL中转换的键值对
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
        for (int j = 0 ; j < subArray.count; j++)
        {
            //在通过=拆分键和值
            NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
            NSLog(@"再把每个参数通过=号进行拆分：n%@", dicArray);
            //给字典加入元素
            [tempDic setObject:dicArray[1] forKey:dicArray[0]];
        }
        NSLog(@"打印参数列表生成的字典：n%@", tempDic);
        [arrayData addObject:tempDic];
    }
    NSLog(@"打印参数字典生成的数组：n%@", arrayData);
    for (int i = 0; i < arrayData.count; ++i) {
        NSDictionary *dict = arrayData[i];
        
        NSLog(@"dict ====>%@",dict);
//        NSString *ID = dict[@"ID"];
//        
//        NSLog(@"ID ====>%@",ID);
        
    }
    //dataArray
     NSLog(@"dataArray ====>%@",dataArray);
    return  arrayData;
}


- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
