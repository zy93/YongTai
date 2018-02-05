//
//  MaintenanceContentView.h
//  YiLianGang
//
//  Created by 张雨 on 2017/3/20.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * @下单
 */
//#define StateOrderPlacement   @"待维修"
#define StateOrderPlacement   @"待处理"
#define StateOrderReceiving   @"处理中"
#define StateOrderMaintenance @"完成"
#define StateOrderComplete    @"维修完成"
#define StateOrderOver        @"订单结束"

@interface MaintenanceContentView : UIView

-(void)setData:(NSDictionary *)dic;

@end
