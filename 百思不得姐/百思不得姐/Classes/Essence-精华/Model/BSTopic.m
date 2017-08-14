//
//  BSTopic.m
//  百思不得姐
//
//  Created by WCF on 2017/8/5.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopic.h"

@implementation BSTopic
{
    CGFloat _cellHeight;
}
- (NSString *)created_at
{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *createDate = [formatter dateFromString:_created_at];
    
    if ([createDate isThisYear]) { //今年
        if ([createDate isToday]) { //今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:createDate];
            if (cmps.hour >= 1) { //*小时前
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }
            else if (cmps.minute >= 1) { //*分钟前
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }
            else { //刚刚
                return @"刚刚";
            }
        }
        else if ([createDate isYesterday]) { // 昨天
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }
        else { //其它
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }
    }
    else { //非今年
        return _created_at;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        BSLogFunc;
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*BSTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //cell的高度
        _cellHeight = BSTopicCellTextY + textH + BSTopicCellBottomBarH + 2*BSTopicCellMargin;
    }
    return _cellHeight;
}
@end
