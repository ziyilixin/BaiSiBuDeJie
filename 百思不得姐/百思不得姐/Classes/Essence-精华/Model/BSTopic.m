//
//  BSTopic.m
//  百思不得姐
//
//  Created by WCF on 2017/8/5.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopic.h"
#import <MJExtension.h>
#import "BSComment.h"
#import "BSUser.h"

@implementation BSTopic
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image":@"image0",
             @"middle_image":@"image1",
             @"large_image":@"image2",
             @"ID":@"id",
             @"top_cmt":@"top_cmt[0]"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : [BSComment class]};
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
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(kScreenW - 2 * BSTopicCellMargin, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;

        // cell的高度
        // 文字部分的高度
        _cellHeight = BSTopicCellTextY + textH + BSTopicCellMargin;

        // 根据段子的类型来计算cell的高度
        if (self.type == BSTopicTypePicture) { // 图片帖子
            // 图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= (kScreenH / 2)) { // 图片高度过长
                NSString *extension = self.large_image.pathExtension;
                //判断是否是GIF
                if (![extension.lowercaseString isEqualToString:@"gif"]) {
                    pictureH = BSTopicCellPictureBreakH;
                    self.bigPicture = YES; //大图
                }
                else {
                    self.bigPicture = NO;
                }
                
            }

            // 计算图片控件的frame
            CGFloat pictureX = BSTopicCellMargin;
            CGFloat pictureY = BSTopicCellTextY + textH + BSTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);

            _cellHeight += pictureH + BSTopicCellMargin;
        } else if (self.type == BSTopicTypeVoice) { // 声音帖子
            CGFloat voiceX = BSTopicCellMargin;
            CGFloat voiceY = BSTopicCellTextY + textH + BSTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + BSTopicCellMargin;
        }
        else if (self.type == BSTopicTypeVideo) { //视频帖子
            CGFloat videoX = BSTopicCellMargin;
            CGFloat videoY = BSTopicCellTextY + textH + BSTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);

            _cellHeight += videoH + BSTopicCellMargin;
        }

        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@:%@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += BSTopicCellTopCmtTitleH + contentH + BSTopicCellMargin;
        }

        // 底部工具条的高度
        _cellHeight += BSTopicCellBottomBarH + BSTopicCellMargin;
    }
    return _cellHeight;
}
@end
