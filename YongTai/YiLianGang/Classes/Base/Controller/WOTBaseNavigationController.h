//
//  WOTBaseNavigationController.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTBaseNavigationController : UINavigationController <UINavigationControllerDelegate>
//获取前一个VC
-(UIViewController *)getPreviousViewController;
@end
