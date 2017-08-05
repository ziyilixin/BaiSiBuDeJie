//
//  BSWordViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/8/3.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSWordViewController.h"
#import "BSTopic.h"

@interface BSWordViewController ()
/** 帖子数据 */
@property (nonatomic,strong) NSMutableArray *topics;

@property (nonatomic,strong) NSString *maxtime;

@property (nonatomic,strong) NSMutableDictionary *params;
/** 页码 */
@property (nonatomic,assign) NSInteger page;
@end

@implementation BSWordViewController

/**
 * 懒加载
 */
- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置刷新
    [self setUpRefresh];

}

/**
 * 设置刷新
 */
- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopics
{
    //结束上拉刷新
    [self.tableView.mj_footer endRefreshing];

    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params = params;

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;

        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];

        //字典数组转模型数组
        self.topics = [BSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //刷新数据
        [self.tableView reloadData];

        //结束刷新
        [self.tableView.mj_header endRefreshing];

        //清空页码
        self.page = 0;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;

        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopic
{
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];

    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"maxtime"] = self.maxtime;
    NSInteger page = self.page;
    params[@"page"] = @(page + 1);
    self.params = params;

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;

        //字典数组转模型数组
        NSArray *topicsArr = [BSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:topicsArr];

        self.maxtime = responseObject[@"info"][@"maxtime"];

        //刷新数据
        [self.tableView reloadData];

        //结束刷新
        [self.tableView.mj_footer endRefreshing];

        self.page++;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;

        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    BSTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}

@end
