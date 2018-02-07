//
//  YTAnnouncementCell.h
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTAnnouncementCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
