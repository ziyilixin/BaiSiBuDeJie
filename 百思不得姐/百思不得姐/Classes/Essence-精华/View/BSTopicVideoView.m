//
//  BSTopicVideoView.m
//  百思不得姐
//
//  Created by WCF on 2017/8/30.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopicVideoView.h"
#import "BSTopic.h"
#import "BSShowPictureController.h"

@interface BSTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLab;

@end

@implementation BSTopicVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;

    self.videoImageView.userInteractionEnabled = YES;
    [self.videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    BSShowPictureController *showPictureVC = [[BSShowPictureController alloc] init];
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;

    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];

    //播放次数
    self.playCountLab.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //播放时间
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.playTimeLab.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
