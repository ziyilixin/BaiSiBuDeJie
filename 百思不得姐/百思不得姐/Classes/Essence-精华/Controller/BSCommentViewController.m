//
//  BSCommentViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/10/17.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSCommentViewController.h"
#import "BSTopic.h"
#import "BSTopicCell.h"
#import "BSComment.h"
#import "BSCommentHeaderView.h"
#import "BSCommentCell.h"

@interface BSCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论 */
@property (nonatomic,strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *latestComments;\
/** 保存帖子的top_cmt */
@property (nonatomic,strong) BSComment *saved_top_cmt;
/** 保存当前的页码 */
@property (nonatomic,assign) NSInteger page;
/** 管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

static NSString * const BSCommentId = @"comment";

@implementation BSCommentViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupBasic];

    [self setupHeader];

    [self setupRefresh];
}

- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSCommentCell class]) bundle:nil] forCellReuseIdentifier:BSCommentId];

    self.tableView.backgroundColor = BSGlobalBg;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, BSTopicCellMargin, 0);
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];

    //清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }

    BSTopicCell *cell = [BSTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.size = CGSizeMake(kScreenW, self.topic.cellHeight);
    [header addSubview:cell];

    header.height = self.topic.cellHeight + BSTopicCellMargin;

    self.tableView.tableHeaderView = header;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;

}

- (void)loadMoreComments
{
    //结束之前的所有请求
   [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    //页码
    NSInteger page = self.page + 1;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    BSComment *comment = [self.latestComments lastObject];
    params[@"lastcid"] = comment.ID;

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }

        //最新评论
        NSArray *newComments = [BSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];

        //页码
        self.page = page;

        //刷新数据
        [self.tableView reloadData];

        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {//全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
        else { //结束刷新
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

- (void)loadNewComments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        //最热评论
        self.hotComments = [BSComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latestComments = [BSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //页码
        self.page = 1;

        //刷新数据
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];

        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {//全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    //键盘显示|隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomSapce.constant = kScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画 及时更新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }

    //取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;

    if (hotCount) return 2;//有“最热评论” + “最新评论” 2组
    if (latestCount) return 1;//有最新评论 1组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCout = self.latestComments.count;

    //隐藏尾部控件
    tableView.mj_footer.hidden = (latestCout == 0);

    if (section == 0) {
        return hotCount ? hotCount : latestCout;
    }
    return latestCout;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BSCommentHeaderView *headerView = [BSCommentHeaderView headerViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        headerView.title = hotCount ? @"最热评论" : @"最新评论";
    }
    else {
        headerView.title = @"最新评论";
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (BSComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:BSCommentId];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableVieDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //显示MenuController
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
    else {
        //被点击的cell
        BSCommentCell *cell = (BSCommentCell *)[tableView cellForRowAtIndexPath:indexPath];

        //cell成为第一响应者
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[ding,replay,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
