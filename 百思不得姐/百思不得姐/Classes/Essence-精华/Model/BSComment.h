//
//  BSComment.h
//  百思不得姐
//
//  Created by WCF on 2017/9/25.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSUser;

@interface BSComment : NSObject
/** 音频文件的时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic,copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic,copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic,assign) NSInteger like_count;
/** 用户 */
@property (nonatomic,strong) BSUser *user;
@end
