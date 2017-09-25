//
//  BSTopicCell.m
//  百思不得姐
//
//  Created by WCF on 2017/8/6.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopicCell.h"
#import "BSTopic.h"
#import "BSTopicPictureView.h"
#import "BSTopicVoiceView.h"
#import "BSTopicVideoView.h"
#import "BSComment.h"
#import "BSUser.h"

@interface BSTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像
@property (weak, nonatomic) IBOutlet UILabel *nickaNameLabel;//昵称
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间
@property (weak, nonatomic) IBOutlet UIButton *dingButton;//顶
@property (weak, nonatomic) IBOutlet UIButton *caiButton;//踩
@property (weak, nonatomic) IBOutlet UIButton *shareButton;//分享
@property (weak, nonatomic) IBOutlet UIButton *commentButton;//评论
@property (weak, nonatomic) IBOutlet UIImageView *sinavImageView;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/** 图片帖子中间的内容 */
@property (nonatomic,weak) BSTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (nonatomic,weak) BSTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (nonatomic,weak) BSTopicVideoView *videoView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@end

@implementation BSTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UIImageView *backGroundView = [[UIImageView alloc] init];
    backGroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backGroundView;

}

- (BSTopicPictureView *)pictureView
{
    if (!_pictureView) {
        BSTopicPictureView *pictureView = [BSTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (BSTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        BSTopicVoiceView *voiceView = [BSTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (BSTopicVideoView *)videoView
{
    if (!_videoView) {
        BSTopicVideoView *videoView = [BSTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;

    //加V
    self.sinavImageView.hidden = !topic.isSina_v;

    //头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    //名字
    self.nickaNameLabel.text = topic.name;

    //设置帖子的创建时间
    self.timeLabel.text = topic.created_at;

    [self setUpButton:self.dingButton count:topic.ding placeHolder:@"顶"];
    [self setUpButton:self.caiButton count:topic.cai placeHolder:@"踩"];
    [self setUpButton:self.shareButton count:topic.repost placeHolder:@"分享"];
    [self setUpButton:self.commentButton count:topic.comment placeHolder:@"评论"];

    // 设置帖子的文字内容
    self.text_Label.text = topic.text;

    //根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == BSTopicTypePicture) {// 图片帖子
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }
    else if (topic.type == BSTopicTypeVoice) {//声音帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
    }
    else if (topic.type == BSTopicTypeVideo) {//视频帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
    }
    else { //段子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }

    // 处理最热评论
    BSComment *comment = [topic.top_cmt firstObject];
    if (comment) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@:%@",comment.user.username,comment.content];
    }
    else {
        self.topCmtView.hidden = YES;
    }

}

- (void)setUpButton:(UIButton *)button count:(NSInteger)count placeHolder:(NSString *)placeHolder
{
    if (count > 10000) {
        placeHolder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }
    else if (count > 0) {
        placeHolder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeHolder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = BSTopicCellMargin;
    frame.size.width -= 2*BSTopicCellMargin;
    frame.size.height -= BSTopicCellMargin;
    frame.origin.y += BSTopicCellMargin;

    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
