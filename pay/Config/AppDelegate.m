//
//  AppDelegate.m
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "AppDelegate.h"
#import "CGLoginViewController.h"
#import "CGInitProcess.h"
#import "CGHomeViewController.h"

#import "CGGuidePagesViewController.h"

#import "CGTabBarController.h"

#import "CGLoginTabBarController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "XGPush.h"
#import "Reachability.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<selectDelegate,XGPushDelegate>
@property (nonatomic,strong) CGInitProcess* cgInitProcess;
@property (nonatomic,strong) Reachability *reachability;
/*
 当前的网络状态
 */
//@property(nonatomic,assign)int netWorkStatesCode;
@end

@implementation AppDelegate

#pragma mark - XGPushDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    UIViewController *ctr = [self.window rootViewController];
    if ([ctr isKindOfClass:[UINavigationController class]]) {
        CGLoginViewController *viewCtr = (CGLoginViewController *)[(UINavigationController *)ctr topViewController];
        [viewCtr updateNotification:[NSString stringWithFormat:@"%@%@", @"启动信鸽服务", (isSuccess?@"成功":@"失败")]];
    }
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    UIViewController *ctr = [self.window rootViewController];
    if ([ctr isKindOfClass:[UINavigationController class]]) {
        CGLoginViewController *viewCtr = (CGLoginViewController *)[(UINavigationController *)ctr topViewController];
        [viewCtr updateNotification:[NSString stringWithFormat:@"%@%@", @"注销信鸽服务", (isSuccess?@"成功":@"失败")]];
    }
    
}

- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    //网络监控
    [self netWorkChangeEvent];
    return YES;
}

#pragma mark - 检测网络状态变化
-(void)netWorkChangeEvent
{
    // 开启网络指示器
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
//    self.netWorkStatesCode =AFNetworkReachabilityStatusUnknown;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        self.netWorkStatesCode = status;
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"当前使用的是流量模式");
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"当前使用的是wifi模式");
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"断网了");
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"变成了未知网络状态");
//                break;
//
//            default:
//                break;
//        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkChangeEventNotification" object:@(status)];
    }];
    [manager.reachabilityManager startMonitoring];
}

#pragma mark - 释放应用
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"netWorkChangeEventNotification" object:nil];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    
    
    //如果程序窗口为nil，初始化为当前屏幕大小
    if (!self.window) {
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    
//    NSArray *images = @[@"bgLoginImg", @"bgLoginImg", @"bgLoginImg"];
//    BOOL y = [CGGuidePagesViewController isShow];
//    if (y) {
//        CGGuidePagesViewController *CG = [[CGGuidePagesViewController alloc] init];
//        self.window.rootViewController = CG;
//        [self.window makeKeyAndVisible];
//        CG.delegate = self;
//        [CG guidePageControllerWithImages:images];
//    }else{
        [self clickEnter];
//    }
    
    //判断是否第一次安装程序
//    NSInteger firstInstallTag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"kFirstKey"] integerValue];
//    if (firstInstallTag == 1) {
//        if ([self judgeGuideImageRefresh]) {
//            [self showGuideViewController];
//        } else {
////            [self initLoginController];
////            [self registerRemoteNotification];//注册通知
//        }
//    } else {//第一次安装APP
//        //握手
//        [AppSingletonManager checkHandShake];
//        [NetworkController requestGuideImages];
//        [self showGuideViewController];
//    }
    
    
    //信鸽推送
    [[XGPush defaultManager] setEnableDebug:YES];
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
    if (action1 && action2) {
        XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
        
        XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
        if (configure) {
            [[XGPush defaultManager] setNotificationConfigure:configure];
        }
    }
    
    [[XGPush defaultManager] startXGWithAppID:2200309966 appKey:@"I1FNT4992GGD" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    return YES;

}

- (void)clickEnter
{
    CGLoginTabBarController *loginView = [[CGLoginTabBarController alloc] init];
    _window.rootViewController = loginView;
    [self.window makeKeyAndVisible];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
}

/**
 收到通知消息的回调，通常此消息意味着有新数据可以读取（iOS 7.0+）
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"[XGDemo] click notification");
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    }
    
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif
@end
