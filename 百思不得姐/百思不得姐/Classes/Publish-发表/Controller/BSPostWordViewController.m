//
//  BSPostWordViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/12/10.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSPostWordViewController.h"
#import "BSPlaceHolderTextView.h"
#import "BSAddTagToolbar.h"

@interface BSPostWordViewController ()<UITextViewDelegate>
//文本输入控件
@property (nonatomic,weak) BSPlaceHolderTextView *textView;
//工具条
@property (nonatomic,weak) BSAddTagToolbar *toolbar;
@end

@implementation BSPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNav];

    [self setupTextView];

    [self setupToolbar];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.textView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self.textView resignFirstResponder];
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
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setupToolbar
{
    BSAddTagToolbar *toolbar = [BSAddTagToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;

    [BSNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//监听键盘的弹出和隐藏
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 键盘最终的frame
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // 动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - kScreenH);
    }];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    BSLogFunc;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
