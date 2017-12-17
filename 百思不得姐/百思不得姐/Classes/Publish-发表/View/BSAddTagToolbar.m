//
//  BSAddTagToolbar.m
//  百思不得姐
//
//  Created by WCF on 2017/12/17.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSAddTagToolbar.h"
#import "BSAddTagViewController.h"

@interface BSAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@end

@implementation BSAddTagToolbar

- (void)awakeFromNib
{
    [super awakeFromNib];

    //添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.size = addButton.currentImage.size;
    addButton.x = BSTopicCellMargin;
    [self.topView addSubview:addButton];
}

- (void)addButtonClick
{
    BSAddTagViewController *addTagVC = [[BSAddTagViewController alloc] init];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addTagVC animated:YES];
}

@end
