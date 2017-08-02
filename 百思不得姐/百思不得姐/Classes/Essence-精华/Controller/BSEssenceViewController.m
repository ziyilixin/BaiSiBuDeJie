//
//  BSEssenceViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSRecommendTagsViewController.h"

@interface BSEssenceViewController ()
/** 底部的红色指示器 */
@property (nonatomic,weak) UIView *indicatorView;
/** 选中的按钮 */
@property (nonatomic,weak) UIButton *selectedButton;
@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏
    [self setUpNav];

    //设置顶部的标签栏
    [self setTitlesView];

}

/**
 * 设置顶部的标签栏
 */
- (void)setTitlesView
{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.width = self.view.width;
    titlesView.height = 35.0;
    titlesView.y = 64;
    [self.view addSubview:titlesView];

    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;

    //内部的子控件
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width/titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];

        //默认选中第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;

            //让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }

}

- (void)titleClick:(UIButton *)button
{
    //修改按钮的状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;

    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}

/**
 *设置导航栏
 */
- (void)setUpNav
{
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
