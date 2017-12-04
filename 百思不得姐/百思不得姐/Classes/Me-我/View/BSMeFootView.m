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
- (void)createSquares:(NSArray *)squares
{
    //一行最多4列
    int maxCols = 4;

    //宽度和高度
    CGFloat buttonW = kScreenW / maxCols;
    CGFloat buttonH = buttonW;

    for (int i = 0; i < squares.count; i++) {
        BSSquareButton *button = [BSSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        button.square = squares[i];
        [self addSubview:button];

        int col = i % maxCols;
        int row = i / maxCols;

        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }

    //总页数 = （总个数 + 每页的最大数 - 1） / 每页的最大数
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;

    self.height = rows * buttonH;

    //重绘
    [self setNeedsDisplay];

}

- (void)buttonClick:(BSSquareButton *)button
{

}

@end
