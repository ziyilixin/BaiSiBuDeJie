//
//  BSPlaceHolderTextView.m
//  百思不得姐
//
//  Created by WCF on 2017/12/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSPlaceHolderTextView.h"

@implementation BSPlaceHolderTextView

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

- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [BSNotificationCenter removeObserver:self];
}

/**
 * 绘制占位文字，每次绘制占位文字之前，会自动清除之前绘制的内容
 */
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;

    rect.origin.x = 3;
    rect.origin.y = 7;
    rect.size.width -= 2*rect.origin.x;

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeHolderColor;
    [self.placeHolder drawInRect:rect withAttributes:attrs];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;

    [self setNeedsDisplay];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = [placeHolder copy];

    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];

    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];

    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];

    [self setNeedsDisplay];
}

@end
