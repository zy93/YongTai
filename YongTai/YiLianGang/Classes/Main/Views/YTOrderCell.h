//
//  YTOrderCell.h
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTButton.h"

@class YTOrderCell;

@protocol YTOrderCellDelegate <NSObject>
-(void)orderCell:(YTOrderCell *)cell selectBtn:(NSString *)btnTitle;
@end

@interface YTOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet WOTButton *notPayBtn;
@property (weak, nonatomic) IBOutlet WOTButton *notSendBtn;
@property (weak, nonatomic) IBOutlet WOTButton *notRceiveBtn;
@property (weak, nonatomic) IBOutlet WOTButton *notEvaluationBtn;
@property (weak, nonatomic) IBOutlet UIView *line1View;
@property (weak, nonatomic) IBOutlet UIView *line2View;
@property (weak, nonatomic) IBOutlet UIView *line3View;

@property (nonatomic, strong) id <YTOrderCellDelegate>  delegate;

@end
