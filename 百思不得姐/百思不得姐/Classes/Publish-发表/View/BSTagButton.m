//
//  BSTagButton.m
//  百思不得姐
//
//  Created by WCF on 2017/12/20.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTagButton.h"

@implementation BSTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = BSTagBg;
        self.titleLabel.font = BSTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];

    [self sizeToFit];

    self.width += 3 * BSTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.x = BSTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + BSTagMargin;
}

@end
