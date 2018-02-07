//
//  AppDelegate.m
//  YiLianGang
//
//  Created by Way_Lone on 16/7/29.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "AppDelegate.h"

//#import "LoginTool.h"
#import "LoginNewTool.h"
#import "TabBarSetTool.h"
#import "WelcomeController.h"
#import "WelcomeView.h"
#import "StyleTool.h"
#import "WeatherTool.h"
#import "LoginNewViewController.h"
#import "HomePageController.h"
#import "WOTBaseNavigationController.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>
@property(nonatomic,strong) UIView *coverView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //LoginViewController *lvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self judgeIsNeedHidden];
    [self comfirmIfHasLoginSaved];
    //清楚通知小红点
    
    [[UINavigationBar appearance]setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:[[StyleTool sharedStyleTool]sessionSyle].naviColor];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    //注册推送
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge |JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginJPushSuccess:) name:kJPFNetworkDidLoginNotification object:nil];
    [JPUSHService setupWithOption:launchOptions appKey:@"a16bafc5f2fbe86415f6cca7" channel:@"APP Store" apsForProduction:NO ];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self refreshWeather];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"进入前台了！");
    //清楚小红点
    dispatch_async(dispatch_get_main_queue(), ^{
        [JPUSHService resetBadge];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        NSNotification *notification = [NSNotification notificationWithName:@"wifiNotification" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    });
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSLog(@"---Device Token:%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error
{
      NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - 外包代码

-(void)comfirmIfHasLoginSaved{
    NSLog(@"本地存储的用户信息：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]);
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"mobile"].length>0) {
        [LoginNewTool sharedLoginNewTool].userID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"mobile"] ;
        [self goToTabBar];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self goToLoginView];
        });
        
    }
}

-(void)goToLoginView{
    //先清除之前缓存
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userInfo"];
    LoginNewViewController *loginNewVC = [[LoginNewViewController alloc] init];
    self.window.rootViewController = loginNewVC;
}

-(void)addCoverViewAnimation{
    self.coverView = [[NSBundle mainBundle]loadNibNamed:@"WelcomeView" owner:nil options:nil].lastObject;
    self.coverView.frame = [UIScreen mainScreen].bounds;
    [self.window addSubview:self.coverView];
    [UIView animateWithDuration:1.5 animations:^{
        self.coverView.alpha = 0;
    }completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.coverView removeFromSuperview];
        });
    }];
}
/**设置tabBar*/
-(void)goToTabBar{
//    UIViewController *vc = [[TabBarSetTool sharedTabBarSetTool]getTabBarController];
    
    WOTBaseNavigationController *nav = [[WOTBaseNavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"HomePageController" bundle:nil] instantiateViewControllerWithIdentifier:@"HomePageController"]];
    self.window.rootViewController = nav;
    
}

+(BOOL)isNeedHidden{
      //  return NO;
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isNeedHidden"];
}
-(void)judgeIsNeedHidden{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [formatter dateFromString:dateTime];
    
    NSDate *date = [formatter dateFromString:@"06-11-2016-000000"];
    NSComparisonResult result = [currentDate compare:date];
    if (result == NSOrderedDescending) {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isNeedHidden"];
        
    }
    else if (result == NSOrderedAscending){
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNeedHidden"];
        
    }
    
}

-(void)refreshWeather{
    WeatherTool *weatherTool = [WeatherTool sharedWeatherTool];
//    if ([LoginTool sharedLoginTool].userID.length>0) {
//        [weatherTool sendWeatherRequest];
//    }
}

#pragma mark - JPush delegate

-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
    NSDictionary *userInfo= notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    NSDictionary *userInfo= response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();
}

#pragma mark - JPush Notification
-(void)loginJPushSuccess:(NSNotification *)notf
{
    if (!strIsEmpty([LoginNewTool sharedLoginNewTool].userTel)) {
        NSString *alias = [NSString stringWithFormat:@"%@%@",[LoginNewTool sharedLoginNewTool].userTel,@"B"];
        [JPUSHService setTags:[NSSet setWithObject:@"iOS"] alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            //NSLog(@"********set Alias:%@",alias);
        }];
    }
}


@end
