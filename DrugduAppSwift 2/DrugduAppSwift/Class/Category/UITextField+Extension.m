//
//  UITextField+Extension.m
//  DDUGloTask
//
//  Created by 沈士新 on 2017/11/18.
//  Copyright © 2017年 沈士新. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>
static NSString *adjust = @"adjust";
@implementation UITextField (Extension)
-(void)setTintAjust:(CGFloat )tintAjust{
    objc_setAssociatedObject(self, &adjust, @(tintAjust), OBJC_ASSOCIATION_ASSIGN);
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(tintAjust,0,tintAjust,self.frame.size.height)];
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
-(CGFloat)tintAjust{
    id  value = objc_getAssociatedObject(self, &adjust);
    return  [value floatValue ];
}



@end
