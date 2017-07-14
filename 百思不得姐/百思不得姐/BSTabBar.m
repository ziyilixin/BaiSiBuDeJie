//
//  BSTabBar.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTabBar.h"

@interface BSTabBar ()
@property (nonatomic,weak) UIButton *publishButton;
@end

@implementation BSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    //设置发布按钮的frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);

    //设置其它UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;

    NSInteger index = 0;

    for (UIView *button in self.subviews) {

        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton)  continue;

        //计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        //增加索引
        index++;

    }
}

@end
