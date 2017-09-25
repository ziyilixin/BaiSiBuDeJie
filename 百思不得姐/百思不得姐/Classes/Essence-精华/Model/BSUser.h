//
//  BSUser.h
//  百思不得姐
//
//  Created by WCF on 2017/9/26.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUser : NSObject
/** 用户名 */
@property (nonatomic,copy) NSString *username;
/** 性别 */
@property (nonatomic,copy) NSString *sex;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;
@end
