//
//  BSTabBarController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/14.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTabBarController.h"
#import "BSEssenceViewController.h"
#import "BSNewViewController.h"
#import "BSFriendTrendsViewController.h"
#import "BSMeViewController.h"
#import "BSTabBar.h"

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

    [self setupWithViewController:[[BSEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    [self setupWithViewController:[[BSNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];

    [self setupWithViewController:[[BSFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];

    [self setupWithViewController:[[BSMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

    [self setValue:[[BSTabBar alloc] init] forKey:@"tabBar"];
}

/**
 * 初始化子控制器
 */

- (void)setupWithViewController:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    [self addChildViewController:VC];
}

@end
