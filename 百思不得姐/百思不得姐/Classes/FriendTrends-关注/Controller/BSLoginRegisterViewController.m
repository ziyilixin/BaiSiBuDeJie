//
//  BSLoginRegisterViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/27.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSLoginRegisterViewController.h"

@interface BSLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@end

@implementation BSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    //NSAttributedString：带有属性的文字（富文本）
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    self.phoneTextField.attributedPlaceholder = placeholder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 设置当前控制器对应的状态栏为白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
