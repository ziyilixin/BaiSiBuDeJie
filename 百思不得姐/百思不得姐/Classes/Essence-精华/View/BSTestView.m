//
//  BSTestView.m
//  百思不得姐
//
//  Created by WCF on 2017/7/24.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTestView.h"

@implementation BSTestView

+ (instancetype)testView
{
    return [[self alloc] init];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(100, 100);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size = CGSizeMake(100, 100);
    [super setBounds:bounds];
}

@end
