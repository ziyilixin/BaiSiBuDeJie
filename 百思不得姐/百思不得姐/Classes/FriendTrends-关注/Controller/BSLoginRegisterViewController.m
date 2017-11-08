//
//  BSLoginRegisterViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/27.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSLoginRegisterViewController.h"

@interface BSLoginRegisterViewController ()
/** 登录框距离控制器View左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation BSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (IBAction)back:(id)sender {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)button {

    //退出键盘
    [self.view endEditing:YES];

    if (self.loginViewLeftMargin.constant == 0) {//显示注册页面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
    }
    else {//显示登录页面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

}

@end
