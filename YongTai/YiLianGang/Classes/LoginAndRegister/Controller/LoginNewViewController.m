//
//  LoginNewViewController.m
//  YiLianGang
//
//  Created by 编程 on 2017/11/24.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import "LoginNewViewController.h"
#import "Masonry.h"
#import "UIImage+ImageColorChange.h"
#import "MBProgressHUDUtil.h"
#import "LoginNewTool.h"
#import "JPUSHService.h"
#import "TabBarSetTool.h"
#import "HomePageController.h"
#import "AppDelegate.h"

@interface LoginNewViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView *userTelView;
@property (nonatomic, strong) UIImageView *userTelImageView;
@property (nonatomic, strong) UITextField *userTelField;
@property (nonatomic, strong) UIButton *verificationCodeButton;

@property (nonatomic, strong) UIView *verificationCodeView;
@property (nonatomic, strong) UIImageView *verificationCodeImageView;
@property (nonatomic, strong) UITextField *verificationCodeField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yt_icon"]];
//    self.logoImageView.image = [self.logoImageView.image imageChangeColor:[UIColor colorWithRed:35.0f/255.0f green:124.0f/255.0f blue:223.0f/255.0f alpha:1]];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.logoImageView];
    
    self.userTelView = [UIView new];
    self.userTelView.backgroundColor = [UIColor whiteColor];
    self.userTelView.layer.cornerRadius = 5.f;
    [self.view addSubview:self.userTelView];
    
    
    self.userTelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usericon"]];
    self.userTelImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.userTelView addSubview:self.userTelImageView];
    
    self.userTelField = [[UITextField alloc] init];
    self.userTelField.placeholder = @"请输入手机号";
    [self.userTelView addSubview:self.userTelField];
    
    self.verificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verificationCodeButton addTarget:self action:@selector(getVerificationCodeMethod) forControlEvents:UIControlEventTouchDown];
    [self.verificationCodeButton setTitleColor:[UIColor colorWithRed:35.0f/255.0f green:124.0f/255.0f blue:223.0f/255.0f alpha:1] forState:UIControlStateNormal];
    self.verificationCodeButton.titleLabel.font = [UIFont systemFontOfSize: 15];
    [self.verificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.userTelView addSubview:self.verificationCodeButton];
    
    
    self.verificationCodeView = [UIView new];
    self.verificationCodeView.backgroundColor = [UIColor whiteColor];
    self.verificationCodeView.layer.cornerRadius = 5.f;
    [self.view addSubview:self.verificationCodeView];
    
    self.verificationCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwdicon"]];
    self.verificationCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.verificationCodeView addSubview:self.verificationCodeImageView];
    
    self.verificationCodeField = [[UITextField alloc] init];
    self.verificationCodeField.placeholder = @"请输入验证码";
    [self.verificationCodeView addSubview:self.verificationCodeField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton addTarget:self action:@selector(loginButtonMethod) forControlEvents:UIControlEventTouchDown];
    [self.loginButton setBackgroundColor:[UIColor colorWithRed:35.0f/255.0f green:124.0f/255.0f blue:223.0f/255.0f alpha:1]];
    self.loginButton.layer.cornerRadius = 5.f;
    self.loginButton.layer.borderColor =[UIColor colorWithRed:35.0f/255.0f green:124.0f/255.0f blue:223.0f/255.0f alpha:1].CGColor;
    self.loginButton.layer.borderWidth = 1.f;
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
//    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
//    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewDidLayoutSubviews
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
//        make.height.mas_equalTo(50);
    }];
    
    [self.userTelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(50);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [self.userTelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTelView);
        make.centerY.equalTo(self.userTelView);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    [self.verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTelView);
        make.right.equalTo(self.userTelView);
        //make.left.equalTo(self.userTelField.mas_right);
        make.bottom.equalTo(self.userTelView);
        make.width.mas_equalTo(100);
    }];
    
    [self.userTelField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTelView);
        make.left.equalTo(self.userTelImageView.mas_right);
        make.right.equalTo(self.verificationCodeButton.mas_left);
        make.bottom.equalTo(self.userTelView);
        
    }];
    
    [self.verificationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userTelView.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [self.verificationCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verificationCodeView);
        make.centerY.equalTo(self.verificationCodeView);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(21);
    }];
    
    [self.verificationCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationCodeView);
        make.left.equalTo(self.verificationCodeImageView.mas_right);
        make.right.equalTo(self.verificationCodeView);
        make.bottom.equalTo(self.verificationCodeView);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationCodeView.mas_bottom).with.offset(30);
        make.left.equalTo(self.view).with.offset(40);
        make.right.equalTo(self.view).with.offset(-40);
        make.height.mas_equalTo(37);
    }];
    
}

#pragma mark - 获取验证码
-(void)getVerificationCodeMethod
{
    //判断手机号是否添加
    if ([self.userTelField.text isEqualToString:@""] || self.userTelField.text==NULL) {
        [MBProgressHUDUtil showMessage:@"请填写手机号！" toView:self.view];
        return;
    }
    
    if (![self isMobileNumber:self.userTelField.text]) {
        [MBProgressHUDUtil showMessage:@"手机号格式不正确！" toView:self.view ];
        return;
    }
    
    [self openCountdown:self.verificationCodeButton];
    
    //调用验证码接口
    [LoginNewTool sharedLoginNewTool].urlString = @"Yongtai_community/Userinfo/sendVerify";
    [LoginNewTool sharedLoginNewTool].parameterDict = @{@"mobile":self.userTelField.text
                                                        };
    [[LoginNewTool sharedLoginNewTool] sendGetVerificationCodeRequestWithResponse:^(NSDictionary *dict) {
        NSLog(@"打印返回信息：%@",dict);
        if (dict) {
            if ([[dict objectForKey:@"code"] intValue] == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUDUtil showMessage:@"发送成功" toView:self.view];
                });
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUDUtil showMessage:[dict objectForKey:@"result"] toView:self.view];
                });
            }
        }else
        {
            [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
        }
        
    }];
}

#pragma mark - 登录方法
-(void)loginButtonMethod
{
    if ([self.userTelField.text isEqualToString:@""] || self.userTelField.text == NULL) {
        [MBProgressHUDUtil showMessage:@"请填写手机号！" toView:self.view];
        return;
    }
    
    if ([self.verificationCodeField.text isEqualToString:@""] || self.verificationCodeField.text == NULL) {
        [MBProgressHUDUtil showMessage:@"请填写验证码！" toView:self.view];
        return;
    }
    //调用登陆接口
    [LoginNewTool sharedLoginNewTool].urlString = @"/Yongtai_community/Userinfo/logIn";
    [LoginNewTool sharedLoginNewTool].parameterDict = @{@"mobile":self.userTelField.text,
                                                        @"verifyNum":self.verificationCodeField.text
                                                        };
    
    [[LoginNewTool sharedLoginNewTool] sendLoginNewRequestWithResponse:^(NSDictionary *dict) {
        NSLog(@"打印返回信息：%@",dict);
        if (dict) {
            if ([[dict objectForKey:@"code"] intValue] == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //登陆成功！
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[LoginNewTool sharedLoginNewTool] setUserIDWithOriginDict:dict];
                        NSDictionary *userInfoDict = [dict objectForKey:@"msg"];
                        NSDictionary *data = [NSDictionary dictionaryWithDictionary:userInfoDict];
                        [[NSUserDefaults standardUserDefaults]setObject:[LoginNewTool sharedLoginNewTool].userTel forKey:@"mobile"];
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:data forKey:@"userInfo"];
                        [defaults synchronize];
                        NSLog(@"存储在本地：%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"mobile"]);
                        NSLog(@"存储在本地的用户信息：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]);
                        NSString *alias = [NSString stringWithFormat:@"%@B",self.userTelField.text];
                        [JPUSHService setTags:nil alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                        }];
                        [self loginDidSuccess];
                    });
                });
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUDUtil showMessage:[dict objectForKey:@"result"] toView:self.view];
                });
            }
        }else
        {
            [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
        }
    }];
}

-(void)loginDidSuccess
{
    NSNotification *notification = [NSNotification notificationWithName:kJPFNetworkDidLoginNotification object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate) goToTabBar];
}

#pragma mark - 获取验证码倒计时
-(void)openCountdown:(UIButton *)button
{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [button setTitle:@"重新发送" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:36.f/255.f green:149.f/255.f blue:253.f/255.f alpha:1] forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [button setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 判断手机号
-(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
