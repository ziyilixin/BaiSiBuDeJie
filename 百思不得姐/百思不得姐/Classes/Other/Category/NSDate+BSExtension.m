//
//  NSDate+BSExtension.m
//  百思不得姐
//
//  Created by WCF on 2017/8/9.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "NSDate+BSExtension.h"

@implementation NSDate (BSExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];

    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}
@end
