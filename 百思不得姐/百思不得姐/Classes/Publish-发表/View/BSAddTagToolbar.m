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
//存放所有标签的label
@property (nonatomic, strong) NSMutableArray *tagLabels;
//添加标签
@property (nonatomic, weak) UIButton *addButton;
@end

@implementation BSAddTagToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    //添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.size = addButton.currentImage.size;
    addButton.x = BSTagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
}

- (void)addButtonClick
{
    BSAddTagViewController *addTagVC = [[BSAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [addTagVC setTagsBlock:^(NSArray *tags){
        [weakSelf createLabels:tags];
    }];
    addTagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addTagVC animated:YES];
}

/**
 * 创建标签
 */
- (void)createLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = BSTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = BSTagFont;
        //应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.width += 2 * BSTagMargin;
        tagLabel.height = BSTagHeigt;
        [self.topView addSubview:tagLabel];

        if (i == 0) { // 最前面的标签按钮
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签按钮
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + BSTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + BSTagMargin;
            }
        }
    }

    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + BSTagMargin;

    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + BSTagMargin;
    }
}

@end
