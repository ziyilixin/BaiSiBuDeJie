//
//  BSTopWindow.m
//  百思不得姐
//
//  Created by WCF on 2017/11/6.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopWindow.h"

static UIWindow *window_;

@implementation BSTopWindow

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, kScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

+ (void)hide
{
    window_.hidden = YES;
}

+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }

        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
