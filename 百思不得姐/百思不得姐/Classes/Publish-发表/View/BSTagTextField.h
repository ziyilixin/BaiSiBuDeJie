//
//  BSTagTextField.h
//  百思不得姐
//
//  Created by WCF on 2017/12/24.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTagTextField : UITextField
//按了删除按钮的回调
@property (nonatomic,copy) void (^deleteBlock)();
@end
