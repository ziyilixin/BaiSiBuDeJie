//
//  BSEssenceViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSRecommendTagsViewController.h"
#import "BSTestView.h"

@interface BSEssenceViewController ()

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BSTestView *testView = [BSTestView testView];
    testView.backgroundColor = [UIColor redColor];
    testView.frame = CGRectMake(100, 100, 20, 50);
    [self.view addSubview:testView];

    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

    self.view.backgroundColor = BSGlobalBg;
}

- (void)tagClick
{
    BSRecommendTagsViewController *tagsVC = [[BSRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tagsVC animated:YES];
}

@end
