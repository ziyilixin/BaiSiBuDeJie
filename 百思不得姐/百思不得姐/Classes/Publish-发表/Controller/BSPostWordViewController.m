//
//  BSPostWordViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/12/10.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSPostWordViewController.h"
#import "BSPlaceHolderTextView.h"

@interface BSPostWordViewController ()
@property (nonatomic,strong) BSPlaceHolderTextView *textView;
@end

@implementation BSPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNav];

    [self setupTextView];
}

- (void)setupNav
{
    self.navigationItem.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)setupTextView
{
    BSPlaceHolderTextView *textView = [[BSPlaceHolderTextView alloc] init];
    textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    BSLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
