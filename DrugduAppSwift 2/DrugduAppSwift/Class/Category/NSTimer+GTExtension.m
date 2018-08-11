//
//  NSTimer+GTExtension.m
//  DDUGloTask
//
//  Created by 沈士新 on 2017/11/30.
//  Copyright © 2017年 沈士新. All rights reserved.
//

#import "NSTimer+GTExtension.h"

@implementation NSTimer (GTExtension)


/**
 暂停
 */
-(void)pauseTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
}


/**
 继续
 */
-(void)resumeTimer{
    if (![self isValid]) {
        return ;
    }
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setFireDate:[NSDate date]];
}

@end
