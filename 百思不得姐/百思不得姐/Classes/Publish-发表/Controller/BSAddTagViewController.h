//
//  BSAddTagViewController.h
//  百思不得姐
//
//  Created by WCF on 2017/12/17.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSAddTagViewController : UIViewController
//获取tags的block
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);
/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;
@end
