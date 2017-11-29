//
//  BSCommentCell.m
//  百思不得姐
//
//  Created by WCF on 2017/10/24.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSCommentCell.h"
#import "BSComment.h"
#import "BSUser.h"

@interface BSCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImgeView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation BSCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)setComment:(BSComment *)comment
{
    _comment = comment;

    [self.headImgeView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexImgeView.image = [comment.user.sex isEqualToString:BSUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLab.text = comment.content;
    self.nameLab.text = comment.user.username;
    self.likeCountLab.text = [NSString stringWithFormat:@"%zd",comment.like_count];

    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    }
    else {
        self.voiceButton.hidden = YES;
    }

}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = BSTopicCellMargin;
    frame.size.width -= 2*BSTopicCellMargin;

    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
