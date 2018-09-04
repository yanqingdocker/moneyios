//
//  CGInitProcess.m
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGInitProcess.h"
#import "CGGuidePagesViewController.h"
#import "CGTabBarController.h"
#import "CGLoginTabBarController.h"
@interface CGInitProcess ()<selectDelegate>
@end
@implementation CGInitProcess

-(instancetype)init
{
    if (self = [super init]) {
        [self addObserver];
    }
    return self;
}

-(BOOL)startupProcessWithApplication:(UIApplication *)application andOptions:(NSDictionary *)launchOptions
{
    
    

    
    self.application = application;
    self.launchOptions = launchOptions;
    
    //如果程序窗口为nil，初始化为当前屏幕大小
    if (!application.delegate.window) {
        application.delegate.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    //进入主框架界面
//    _cgLoginViewController = [[CGLoginViewController alloc]init];
//    application.delegate.window.rootViewController = _cgLoginViewController;
//
//    [application.delegate.window makeKeyAndVisible];
    
    
    
    NSArray *images = @[@"引导页1", @"引导页2", @"引导页3"];
    BOOL y = [CGGuidePagesViewController isShow];
    if (y) {
        CGGuidePagesViewController *CG = [[CGGuidePagesViewController alloc] init];
        
        application.delegate.window.rootViewController = CG;
        CG.delegate = self;
        [CG guidePageControllerWithImages:images];
        [application.delegate.window makeKeyAndVisible];
    }else{
        
        CGLoginTabBarController *vc = [[CGLoginTabBarController alloc] init];
        application.delegate.window.rootViewController = vc;
//        getAppWindow().rootViewController = vc;
        
//        _cgLoginViewController = [[CGLoginViewController alloc]init];
//        application.delegate.window.rootViewController = _cgLoginViewController;
        
        [application.delegate.window makeKeyAndVisible];

    }
    
    return YES;
}

//- (void)clickEnter
//{
//    CGLoginViewController *loginView = [[CGLoginViewController alloc] init];
//    _window.rootViewController = loginView;
//    
//    
//    
//}

//启动前广播消息
-(void)addObserver
{
    //添加需要的消息
    
}

@end
