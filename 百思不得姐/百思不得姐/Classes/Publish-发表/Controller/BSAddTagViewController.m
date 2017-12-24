//
//  BSAddTagViewController.m
//  百思不得姐
//
//  Created by WCF on 2017/12/17.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSAddTagViewController.h"
#import "BSTagButton.h"
#import "BSTagTextField.h"

@interface BSAddTagViewController ()<UITextFieldDelegate>
//内容
@property (nonatomic,weak) UIView *contentView;
//文本输入框
@property (nonatomic,weak) BSTagTextField *textField;
//添加按钮
@property (nonatomic,weak) UIButton *addButton;
//所有的标签按钮
@property (nonatomic,strong) NSMutableArray *tagButtons;
@end

@implementation BSAddTagViewController

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = BSTagFont;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, BSTagMargin, 0, BSTagMargin);
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = BSTagBg;
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

    [self setupTags];
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
    contentView.x = BSTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + BSTagMargin;
    contentView.height = kScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField
{
    __weak typeof(self) weakSelf = self;
    BSTagTextField *textField = [[BSTagTextField alloc] init];
    textField.width = self.contentView.width;
    textField.delegate = self;
    textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return;
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }
}

- (void)textDidChange
{
    //更新TextField的frame
    [self updateTextFieldFrame];

    if (self.textField.hasText) {//有文字
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + BSTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];

        //获取最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len -1];
        if ([lastLetter isEqualToString:@"，"] || [lastLetter isEqualToString:@","]) {
            //去除逗号
            self.textField.text = [text substringToIndex:len -1];

            [self addButtonClick];
        }
    }
    else {//没有文字
        self.addButton.hidden = YES;
    }

}

- (void)done
{
    //传递tags给这个block
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);

    [self.navigationController popViewControllerAnimated:YES];
}

//监听“添加按钮”点击
- (void)addButtonClick
{

    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return;
    }

    // 添加一个"标签按钮"
    BSTagButton *tagButton = [BSTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];

    // 清空textField文字
    self.textField.text = nil;
    self.addButton.hidden = YES;

    // 更新标签按钮的frame
    [self updateTagButtonFrame];

    //更新TextField的frame
    [self updateTextFieldFrame];

}

//更新标签按钮的frame
- (void)updateTagButtonFrame
{
    // 更新标签按钮的frame
    for (int i = 0; i<self.tagButtons.count; i++) {
        BSTagButton *tagButton = self.tagButtons[i];

        if (i == 0) { // 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { // 其他标签按钮
            BSTagButton *lastTagButton = self.tagButtons[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + BSTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) { // 按钮显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            } else { // 按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + BSTagMargin;
            }
        }
    }
}

//更新TextField的frame
- (void)updateTextFieldFrame
{
    // 最后一个标签按钮
    BSTagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + BSTagMargin;

    // 更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + BSTagMargin;
    }
}

//标签按钮的点击
- (void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];

    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

//textField的文字宽度
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}

#pragma mark - UITextFieldDelegate
/**
 * 监听键盘最右下角按钮的点击（return key， 比如“换行”、“完成”等等）
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
