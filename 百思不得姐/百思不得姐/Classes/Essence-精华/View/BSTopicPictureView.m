//
//  BSTopicPictureView.m
//  百思不得姐
//
//  Created by WCF on 2017/8/16.
//  Copyright © 2017年 WCF. All rights reserved.
//

#import "BSTopicPictureView.h"
#import "BSTopic.h"

@interface BSTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@end

@implementation BSTopicPictureView
+ (instancetype)pictureView
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
    
    //设置图片
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
}
@end
