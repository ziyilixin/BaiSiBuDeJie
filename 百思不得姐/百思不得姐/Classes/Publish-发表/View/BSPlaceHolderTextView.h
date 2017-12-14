//
//  BSPlaceHolderTextView.h
//  百思不得姐
//
//  Created by WCF on 2017/12/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSPlaceHolderTextView : UITextView
/**
 * 占位文字
 */
@property (nonatomic,copy) NSString *placeHolder;
/**
 * 占位文字颜色
 */
@property (nonatomic,strong) UIColor *placeHolderColor;
@end
