//
//  BSAddTagViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/12/17.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSAddTagViewController.h"

@interface BSAddTagViewController ()
//内容
@property (nonatomic,weak) UIView *contentView;
//文本输入框
@property (nonatomic,weak) UITextField *textField;
//添加按钮
@property (nonatomic,weak) UIButton *addButton;
@end

@implementation BSAddTagViewController

- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, BSTopicCellMargin, 0, BSTopicCellMargin);
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = BSRGBColor(74, 139, 209);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupNav];

    [self setupContentView];

    [self setupTextField];
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = BSTopicCellMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + BSTopicCellMargin;
    contentView.height = kScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.width = kScreenW;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)textDidChange
{
    if (self.textField.hasText) {//有文字
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame);
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
    }
    else {//没有文字
        self.addButton.hidden = YES;
    }
}

- (void)done
{

}

- (void)addButtonClick
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
