//
//  BSTagTextField.m
//  百思不得姐
//
//  Created by WCF on 2017/12/24.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTagTextField.h"

@implementation BSTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = BSTagHeigt;
    }
    return self;
}

- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();

    [super deleteBackward];
}

@end
