//
//  WOTShortcutMenuView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTShortcutMenuView.h"


@interface WOTShortcutMenuView ()
{
    NSArray *imageNameList;
    NSArray *titleList;
    
    NSMutableArray *buttonList;
    CGFloat buttonDefaultY;
    CGFloat lineDefaultHeight;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    
    
    NSArray *sbNameList;
    NSArray *vcNameList;
    
}

@end


@implementation WOTShortcutMenuView



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    //self.backgroundColor = UIColorFromRGB(0x8fc5f3);
    self.backgroundColor = [UIColor whiteColor];
    sbNameList = @[@"Main",@"",@"",@"",@"",
                   @"",@"",@"",];
    
    vcNameList = @[@"PayBillViewController",
                   @"",
                   @"PayMentViewController",
                   @"MaintenanceViewController",
                   @"",
                   @"",
                   @"",
                   @""];
    
    
    titleList = @[@"物业缴费", @"访客登记",@"家政服务",@"报修登记", @"送水服务", @"投诉建议", @"业主认证", @"社区公告"];
    imageNameList = @[@"property_pay_icon",
                      @"visitors_icon",
                      @"housekeeping_icon",
                      @"repairs_icon",
                      @"carrying_water_icon",
                      @"contact_us_icon",
                      @"auth_icon",
                      @"announcement_icon"];
    buttonDefaultY = 15;
    lineDefaultHeight = 10;
    buttonHeight = (200-(buttonDefaultY*2))/2;
    buttonWidth = SCREEN_WIDTH/4;
    
    for (int i = 0; i<titleList.count; i++) {
        UIButton *btn = [self createButtonWithTitle:titleList[i] imgName:imageNameList[i] i:i];
        [buttonList addObject:btn];
    }
}

-(UIButton *)createButtonWithTitle:(NSString *)title imgName:(NSString *)imgName i:(int)i
{
    
    NSInteger index = i%4;
    NSInteger line = i/4;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(index*buttonWidth, line*buttonHeight+buttonDefaultY+(line*lineDefaultHeight), buttonWidth, buttonHeight)];
    button.tag = i;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    [imgV setImage:img];
    imgV.center = CGPointMake(buttonWidth*0.5, buttonHeight*0.5-10);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame)+6, buttonWidth, 18)];
    lab.text = title;
    //lab.textColor = UICOLOR_WHITE;
    //lab.textColor = RGBA(72,134,236,1);
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15.f];
    
    
    [button addSubview:imgV];
    [button addSubview:lab];
    
    [self addSubview:button];
    return button;
}


-(void)clickButton:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(shortcutMenu:pushToVCWithStoryboardName:vcName:)]) {
        [_delegate shortcutMenu:self pushToVCWithStoryboardName:sbNameList[sender.tag] vcName:vcNameList[sender.tag]];
    }
}


@end
