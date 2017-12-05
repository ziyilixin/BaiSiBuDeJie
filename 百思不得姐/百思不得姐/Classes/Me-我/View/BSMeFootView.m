//
//  BSMeFootView.m
//  百思不得姐
//
//  Created by WCF on 2017/12/4.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSMeFootView.h"
#import "BSSquare.h"
#import "BSSquareButton.h"
#import "BSWebViewController.h"

@implementation BSMeFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";

        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [BSSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        }];

    }
    return self;
}

//创建方块
- (void)createSquares:(NSArray *)sqaures
{
    //一行最多4列
    int maxCols = 4;

    // 宽度和高度
    CGFloat buttonW = kScreenW / maxCols;
    CGFloat buttonH = buttonW;

    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        BSSquareButton *button = [BSSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];

        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;

        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }

    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;

    // 计算footer的高度
    self.height = rows * buttonH;

    // 重绘
    [self setNeedsDisplay];
}

- (void)buttonClick:(BSSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http:"]) return;

    BSWebViewController *webVC = [[BSWebViewController alloc] init];
    webVC.navigationItem.title = button.square.name;
    webVC.url = button.square.url;

    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
    [nav pushViewController:webVC animated:YES];
}

@end
