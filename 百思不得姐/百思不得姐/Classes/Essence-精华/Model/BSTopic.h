//
//  BSTopic.h
//  百思不得姐
//
//  Created by WCF on 2017/8/5.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTopic : NSObject
/** 名称 */
@property (nonatomic,copy) NSString *name;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic,copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic,copy) NSString *text;
/** 订的数量 */
@property (nonatomic,assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic,assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic,assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic,assign) NSInteger comment;
@end
