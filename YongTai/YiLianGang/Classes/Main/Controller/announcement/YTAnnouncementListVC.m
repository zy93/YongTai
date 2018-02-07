//
//  YTAnnouncementListVC.m
//  YongTai
//
//  Created by 张雨 on 2018/2/6.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import "YTAnnouncementListVC.h"
#import "YTAnnouncementCell.h"
#import "UIColor+RCColor.h"
#import "Masonry.h"
#import "NoticeRequestTool.h"
#import "UIImageView+WebCache.h"
#import "WN_YL_RequestTool.h"
#import "NoticeDetailsViewController.h"

@interface YTAnnouncementListVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * table;
@property (nonatomic, strong) NSArray * tableList;
@property (nonatomic, strong) NSMutableArray *imageUrlStrings;
@end

@implementation YTAnnouncementListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadViews];
    [self createRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadViews {
    self.navigationItem.title =  @"公告列表";
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee" alpha:1.f];
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    [self.table registerNib:[UINib nibWithNibName:@"YTAnnouncementCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YTAnnouncementCell"];
    
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
}

#pragma mark - request
-(void)createRequest
{
    [self.imageUrlStrings removeAllObjects];
    if (!self.imageUrlStrings) {
        self.imageUrlStrings = [NSMutableArray new];
    }
    [[NoticeRequestTool sharedNoticeTool] sendNoticeRequestWithResponse:^(NSDictionary *dict) {
        if ([[dict objectForKey:@"code"] intValue] == 200) {
            self.tableList = [dict objectForKey:@"msg"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        }else
        {
            NSLog(@"失败！！");
        }
    }];
}

#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0) return 220;
//    else if (indexPath.section==1) return 80;
//    else
        return 125;
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
    YTAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YTAnnouncementCell"];
    NSDictionary *dic = self.tableList[indexPath.row];
    [cell.iconIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.yiliangang.net:8012/Yongtai_community%@",dic[@"picture"]]]];
    [cell.titleLab setText:dic[@"title"]];
    [cell.contentLab setText:dic[@"content"]];
    [cell.timeLab setText:dic[@"releaseTime"]];
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.tableList[indexPath.row];
    NoticeDetailsViewController *vc = [[NoticeDetailsViewController alloc] init];
    vc.titleStr = dic[@"title"];
    vc.contentStr =dic[@"content"];
    vc.releaseTimeStr = dic[@"releaseTime"];
    [self.navigationController pushViewController:vc animated:YES];
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
