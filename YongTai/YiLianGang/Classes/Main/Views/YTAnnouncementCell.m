//
//  YTAnnouncementCell.m
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import "YTAnnouncementCell.h"
#import "UIColor+RCColor.h"

@implementation YTAnnouncementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLab.textColor = [UIColor colorWithHexString:@"0x666666" alpha:1.f];
    self.timeLab.textColor = [UIColor colorWithHexString:@"0x999999" alpha:1.f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
