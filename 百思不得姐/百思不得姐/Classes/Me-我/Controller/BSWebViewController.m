//
//  BSWebViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/12/5.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSWebViewController.h"
#import <NJKWebViewProgress.h>

@interface BSWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwoardItem;
@property (nonatomic,strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation BSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    self.progress.webViewProxyDelegate = self;
    
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)onClickGoBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)onClickGoForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)onClickRefresh:(id)sender {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwoardItem.enabled = webView.canGoForward;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
