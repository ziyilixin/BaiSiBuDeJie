//
//  BSCommentHeaderView.h
//  百思不得姐
//
//  Created by WCF on 2017/10/22.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCommentHeaderView : UITableViewHeaderFooterView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) NSString *title;
@end
