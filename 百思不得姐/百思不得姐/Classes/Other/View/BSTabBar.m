//
//  BSTabBar.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTabBar.h"
#import "BSPublishViewController.h"
#import "BSPostWordViewController.h"
#import "BSNavigationController.h"

@interface BSTabBar ()
@property (nonatomic,weak) UIButton *publishButton;
@end

@implementation BSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        //设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick
{
    BSPublishViewController *publishVC = [[BSPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:YES completion:nil];

//    BSPostWordViewController *postWordVC = [[BSPostWordViewController alloc] init];
//    BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:postWordVC];
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [root presentViewController:nav animated:YES completion:nil];

}

- (void)layoutSubviews
{
    [super layoutSubviews];

    //标记按钮是否已经添加过监听器
    static BOOL added = NO;

    //设置发布按钮的frame
    CGFloat width = self.width;
    CGFloat height = self.height;
    self.publishButton.center = CGPointMake(width*0.5, height*0.5);

    //设置其它UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;

    NSInteger index = 0;
    
    for (UIControl *button in self.subviews) {

        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton)  continue;

        //计算按钮的X值
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        //增加索引
        index++;

        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    added = YES;
}

- (void)buttonClick
{
    //发出一个通知
    [BSNotificationCenter postNotificationName:BSTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
