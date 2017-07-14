//
//  BSFriendTrendsViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSFriendTrendsViewController.h"

@interface BSFriendTrendsViewController ()

@end

@implementation BSFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏标题
    self.navigationItem.title = @"我的关注";

    //设置导航栏左边的按钮
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    friendButton.size = friendButton.currentBackgroundImage.size;
    [friendButton addTarget:self action:@selector(friendClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendButton];
}

- (void)friendClick
{
    BSLogFunc;
}

@end
