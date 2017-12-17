//
//  BSTopicVoiceView.m
//  百思不得姐
//
//  Created by WCF on 2017/8/30.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopicVoiceView.h"
#import "BSTopic.h"
#import "BSShowPictureController.h"

@interface BSTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLab;
@end

@implementation BSTopicVoiceView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;

    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
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

    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];

    //播放次数
    self.playCountLab.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //播放时间
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.playTimeLab.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
