//
//  BSAllViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/8/3.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSAllViewController.h"

@interface BSAllViewController ()

@end

@implementation BSAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSLog(@"%@",NSStringFromUIEdgeInsets(tableView.contentInset));
    BSLog(@"%@",NSStringFromCGRect(tableView.frame));
}

@end
