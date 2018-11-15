//
//  BSSquareButton.m
//  百思不得姐
//
//  Created by WCF on 2017/12/4.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSSquareButton.h"
#import "BSSquare.h"
#import <UIButton+WebCache.h>

@implementation BSSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;

    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(BSSquare *)square
{
    _square = square;
    
    [self setTitle:_square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:_square.icon] forState:UIControlStateNormal];
}

@end
