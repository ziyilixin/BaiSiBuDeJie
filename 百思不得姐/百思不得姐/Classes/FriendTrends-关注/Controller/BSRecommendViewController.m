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

@interface BSRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (nonatomic,strong) NSArray *categories;
@end

@implementation BSRecommendViewController

static NSString * const categoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryId];

    self.navigationItem.title = @"推荐关注";

    self.view.backgroundColor = BSGlobalBg;



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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryId];
    cell.category = self.categories[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
