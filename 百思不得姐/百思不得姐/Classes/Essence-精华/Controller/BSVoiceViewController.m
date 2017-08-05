//
//  BSVoiceViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/8/3.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSVoiceViewController.h"

@interface BSVoiceViewController ()

@end

@implementation BSVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setUpTableView];
}

- (void)setUpTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = BSTitlesViewH + BSTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%zd",[self class],indexPath.row];
    return cell;
}

@end
