//
//  BSTextField.m
//  百思不得姐
//
//  Created by WCF on 2017/7/27.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTextField.h"
#import <objc/runtime.h>

static NSString * const BSPlaceHolderColorKeyPath = @"_placeholderLabel.textColor";

@implementation BSTextField

+ (void)initialize
{
    [self getIvars];
}

+ (void)getIvars
{
    unsigned int count = 0;
    //拷贝出所有成员变量的值
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        //取出成员变量
        Ivar ivar = ivars[i];
        //打印成员变量名字
        BSLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }

    //释放
    free(ivars);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //设置光标颜色和文字颜色一样
    self.tintColor = self.textColor;

    //不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:BSPlaceHolderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 挡墙文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:BSPlaceHolderColorKeyPath];
    return [super resignFirstResponder];
}

@end
