//
//  BSRecommendCategory.m
//  百思不得姐
//
//  Created by WCF on 2017/7/20.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSRecommendCategory.h"

@implementation BSRecommendCategory
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
