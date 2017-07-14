//
//  BSTabBarController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTabBarController.h"

@interface BSTabBarController ()

@end

@implementation BSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UINavigationBar appearance];

    //通过appearance统一设置UITabBarItem的文字的属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12.0];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    NSMutableDictionary *selectedAttrs = [[NSMutableDictionary alloc] init];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];

    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    UIViewController *oneVC = [[UIViewController alloc] init];
    oneVC.tabBarItem.title = @"精华";
    oneVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    oneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    oneVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:oneVC];

    UIViewController *twoVC = [[UIViewController alloc] init];
    twoVC.tabBarItem.title = @"新帖";
    twoVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    twoVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    twoVC.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:twoVC];

    UIViewController *threeVC = [[UIViewController alloc] init];
    threeVC.tabBarItem.title = @"关注";
    threeVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    threeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    threeVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:threeVC];

    UIViewController *fourVC = [[UIViewController alloc] init];
    fourVC.tabBarItem.title = @"我";
    fourVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    fourVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    fourVC.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:fourVC];

}

@end
