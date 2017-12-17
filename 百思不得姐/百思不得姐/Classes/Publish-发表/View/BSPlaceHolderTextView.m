//
//  BSPlaceHolderTextView.m
//  百思不得姐
//
//  Created by WCF on 2017/12/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSPlaceHolderTextView.h"

@interface BSPlaceHolderTextView ()
@property (nonatomic,weak) UILabel *placeHolderLab;
@end

@implementation BSPlaceHolderTextView

- (UILabel *)placeHolderLab
{
    if (!_placeHolderLab) {
        UILabel *placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.x = 4;
        placeHolderLab.y = 7;
        placeHolderLab.numberOfLines = 0;
        [self addSubview:placeHolderLab];
        _placeHolderLab = placeHolderLab;
    }
    return _placeHolderLab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;

        //默认文字
        self.font = [UIFont systemFontOfSize:15];

        //默认文字的占位颜色
        self.placeHolderColor = [UIColor grayColor];

        //监听文字改变
        [BSNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];

    }
    return self;
}

//监听占位文字改变
- (void)textDidChange
{
    self.placeHolderLab.hidden = self.hasText;
}

- (void)dealloc
{
    [BSNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.placeHolderLab.width = self.width - 2 * self.placeHolderLab.x;
    [self.placeHolderLab sizeToFit];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;

    self.placeHolderLab.textColor = placeHolderColor;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];

    self.placeHolderLab.text = placeHolder;

    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];

    self.placeHolderLab.font = font;

    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];

    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];

    [self textDidChange];
}

/**
 * setNeedsDisplay方法 : 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout方法 : 会在恰当的时刻调用layoutSubviews方法
 */

@end
