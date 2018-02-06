//
//  YTUserCell.m
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import "YTUserCell.h"

@implementation YTUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconBGView.layer.cornerRadius = CGRectGetWidth(self.iconBGView.frame)/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
