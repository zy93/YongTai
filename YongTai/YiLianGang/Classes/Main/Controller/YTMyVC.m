//
//  YTMyVC.m
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import "YTMyVC.h"
#import "YTUserCell.h"
#import "YTOrderCell.h"
#import "YTOtherCell.h"
#import "Masonry.h"
#import "UIViewController+Extension.h"

@interface YTMyVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * table;
@property (nonatomic, strong) NSArray * tableList;
@property (nonatomic, strong) NSArray * imageList;

@end

@implementation YTMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self loadViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    [self configNaviBackItem];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)loadViews {
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    [self.table registerNib:[UINib nibWithNibName:@"YTUserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YTUserCell"];
    [self.table registerNib:[UINib nibWithNibName:@"YTOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YTOrderCell"];
    [self.table registerNib:[UINib nibWithNibName:@"YTOtherCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YTOtherCell"];
    
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
}


-(void)loadData
{
    self.tableList = @[@[@"user"],@[@"order"],@[@"我的订单", @"我的优惠券", @"我的物业服务", @"我的收货地址", @"登录密码管理", @"客服电话", @"关于社区"]];
    self.imageList = @[@"yt_order", @"yt_coupon", @"yt_service", @"yt_address", @"yt_password", @"yt_customer_services", @"yt_about"];
}


#pragma mark - action


#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.tableList[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) return 220;
    else if (indexPath.section==1) return 80;
    else return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.001;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        YTUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YTUserCell"];
        return cell;
    }
    else if (indexPath.section==1) {
        YTOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YTOrderCell"];
        return cell;
    }
    else {
        YTOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YTOtherCell"];
        NSArray *arr = self.tableList[indexPath.section];
        [cell.iconIV setImage:[UIImage imageNamed:self.imageList[indexPath.row]]];
        [cell.titleLab setText:arr[indexPath.row]];
        return cell;
    }
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
