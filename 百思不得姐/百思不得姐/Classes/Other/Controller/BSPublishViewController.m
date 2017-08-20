//
//  BSPublishViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/8/20.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSPublishViewController.h"
#import "BSVerticalButton.h"

@interface BSPublishViewController ()

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //添加标语
    UIImageView *sloganImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganImageView.y = kScreenH * 0.2;
    sloganImageView.centerX = kScreenW * 0.5;
    [self.view addSubview:sloganImageView];

    //数据
    NSArray *titlesArr = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *imagesArr = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];

    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartX = 20;
    CGFloat buttonStartY = (kScreenH - 2 * buttonH) * 0.5;
    CGFloat xMargin = (kScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);

    for (int i = 0; i < titlesArr.count; i++) {
        BSVerticalButton *button = [[BSVerticalButton alloc] init];

        //设置内容
        [button setTitle:titlesArr[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesArr[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        //设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (buttonW + xMargin);
        button.y = buttonStartY + row * buttonH;
        button.width = buttonW;
        button.height = buttonH;

        [self.view addSubview:button];
    }

}

- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
