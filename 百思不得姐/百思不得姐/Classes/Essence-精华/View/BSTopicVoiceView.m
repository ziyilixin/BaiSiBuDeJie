//
//  BSTopicVoiceView.m
//  百思不得姐
//
//  Created by WCF on 2017/8/30.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopicVoiceView.h"
#import "BSTopic.h"

@interface BSTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLab;
@end

@implementation BSTopicVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
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
