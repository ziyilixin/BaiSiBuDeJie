//
//  BSRecommendViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/7/18.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "BSRecommendCategory.h"
#import <MJExtension.h>
#import "BSRecommendCategoryCell.h"
#import "BSRecommendUser.h"
#import "BSRecommendUserCell.h"

@interface BSRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic,strong) NSArray *categories;
@end

@implementation BSRecommendViewController

static NSString * const categoryId = @"category";
static NSString * const userId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupTableView];

    //显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];

        self.categories = [BSRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];

        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (void)setupTableView
{

    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userId];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;

    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = BSGlobalBg;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    else {
        BSRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        BSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }
    else {
        BSRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userId];
        BSRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSRecommendCategory *category = self.categories[indexPath.row];

    if (category.users.count) {
        [self.userTableView reloadData];
    }
    else {

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(category.id);

        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *users = [BSRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [category.users addObjectsFromArray:users];
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            BSLog(@"%@",error);
        }];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
