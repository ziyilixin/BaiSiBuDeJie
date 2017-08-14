//
//  BSTopicViewController.h
//  百思不得姐
//
//  Created by WCF on 2017/8/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BSTopicTypeAll = 1,
    BSTopicTypePicture = 10,
    BSTopicTypeWord = 29,
    BSTopicTypeVoice = 31,
    BSTopicTypeVideo = 41,
} BSTopicType;

@interface BSTopicViewController : UITableViewController
@property (nonatomic,assign) BSTopicType type;
@end
