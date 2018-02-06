//
//  YTOrderCell.m
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import "YTOrderCell.h"

@implementation YTOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(orderCell:selectBtn:)]) {
        [_delegate orderCell:self selectBtn:((UIButton *)sender).titleLabel.text];
    }
}

@end
