//
//  BSTestViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTestViewController.h"

@interface BSTestViewController ()

@end

@implementation BSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"BSTestViewController";
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.backgroundColor = BSRGBColor(200, 109, 100);
    [self.navigationController pushViewController:VC animated:YES];
}

@end
