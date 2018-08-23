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

@interface AppDelegate ()<selectDelegate>
@property (nonatomic,strong) CGInitProcess* cgInitProcess;
@end

@implementation AppDelegate


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
    return YES;
    
    
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
}

- (void)clickEnter
{
    CGLoginViewController *loginView = [[CGLoginViewController alloc] init];
    _window.rootViewController = loginView;
    [self.window makeKeyAndVisible];
//    CGLoginViewController *vc = [[CGLoginViewController alloc] init];
//    self.window.rootViewController = vc;
//    [self.window.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:2.0f];
    
//    _cgInitProcess = [[CGInitProcess alloc]init];
//    self.window.rootViewController = _cgInitProcess;
//    return [_cgInitProcess startupProcessWithApplication:application andOptions:launchOptions];

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


@end
