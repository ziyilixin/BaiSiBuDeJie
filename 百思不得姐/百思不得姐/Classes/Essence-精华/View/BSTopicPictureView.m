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

    /**
     在不知道图片扩展名的情况下, 如何知道图片的真实类型?
     * 取出图片数据的第一个字节, 就可以判断出图片的真实类型
     */
    
    //设置图片
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

    //判断是否是gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];

    // 判断是否显示"点击查看全图"
    if (topic.bigPicture) {// 大图
        self.seeBigButton.hidden = NO;
        self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    else {//非大图
        self.seeBigButton.hidden = YES;
        self.pictureImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}
@end
