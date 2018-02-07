//
//  NoticeDetailsViewController.m
//  YiLianGang
//
//  Created by 编程 on 2017/11/9.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import "NoticeDetailsViewController.h"
#import "Masonry.h"
#import "UIColor+RCColor.h"

@interface NoticeDetailsViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *releaseTimeLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation NoticeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"公告详情";
    self.navigationItem.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] init];
    //self.scrollView.backgroundColor = [UIColor blueColor];
//    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.titleStr;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"0x333333" alpha:1.f];
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.scrollView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.text = self.contentStr;
    self.contentLabel.textColor = [UIColor colorWithHexString:@"0x666666" alpha:1.f];
    [self.contentLabel setFont:[UIFont systemFontOfSize:15]];
    self.contentLabel.preferredMaxLayoutWidth = (self.view.frame.size.width -10.0 * 2);
    [self.contentLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    self.contentLabel.textAlignment = NSTextAlignmentJustified;
    self.contentLabel.numberOfLines =0;
    [self.scrollView addSubview:self.contentLabel];
    
    self.releaseTimeLabel = [[UILabel alloc] init];
    self.releaseTimeLabel.text = self.releaseTimeStr;
    self.releaseTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.releaseTimeLabel.textColor = [UIColor colorWithHexString:@"0x999999" alpha:1.f];
    [self.releaseTimeLabel setFont:[UIFont systemFontOfSize:10]];
    [self.scrollView addSubview:self.releaseTimeLabel];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        //make.top.right.left.equalTo(self.view);
        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.equalTo(self.contentLabel.mas_bottom);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.scrollView);
        //make.top.equalTo(self.scrollView.mas_top).with.offset(26);
        make.top.equalTo(self.scrollView).with.offset(15);
        make.left.equalTo(self.scrollView.mas_left).with.offset(20);
        make.height.mas_offset(18);
    }];
    
    [self.releaseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.titleLabel.mas_left);
        make.height.mas_offset(12);
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.top.equalTo(self.releaseTimeLabel.mas_bottom).with.offset(15);
    }];
    
   
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


