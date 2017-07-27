//
//  BSTextField.m
//  百思不得姐
//
//  Created by WCF on 2017/7/27.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTextField.h"

@implementation BSTextField

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, rect.size.height) withAttributes:@{
                         NSForegroundColorAttributeName:[UIColor grayColor],
                         NSFontAttributeName:self.font
                                                 }];
}

@end
