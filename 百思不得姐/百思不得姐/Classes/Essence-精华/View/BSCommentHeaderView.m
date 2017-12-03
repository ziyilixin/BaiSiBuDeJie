//
//  BSCommentHeaderView.m
//  百思不得姐
//
//  Created by WCF on 2017/10/22.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSCommentHeaderView.h"

@interface BSCommentHeaderView ()
@property (nonatomic,weak) UILabel *label;
@end

@implementation BSCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    BSCommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headerView == nil) {
        headerView = [[BSCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = BSGlobalBg;

        UILabel *label = [[UILabel alloc] init];
        label.textColor = BSRGBColor(67, 67, 67);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];

    self.label.text = title;
}

@end
