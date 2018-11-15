//
//  BSMeViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSMeViewController.h"
#import "BSMeCell.h"
#import "BSMeFootView.h"

@interface BSMeViewController ()

@end

static NSString * const meId = @"me";

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];

    [self setupTableView];
}

- (void)setupNav
{
    //设置导航栏标题
    self.navigationItem.title = @"我的";

    //设置导航栏左边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];

    self.navigationItem.rightBarButtonItems = @[
                                                settingItem,
                                                moonItem
                                                ];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = BSGlobalBg;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSMeCell class] forCellReuseIdentifier:meId];

    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = BSTopicCellMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(kNavigationBarHeight - 10, 0, 2*kScreenH, 0);
    self.tableView.tableFooterView = [[BSMeFootView alloc] init];
}

- (void)settingClick
{
    BSLogFunc;
}

- (void)moonClick
{
    BSLogFunc;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meId];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

@end
