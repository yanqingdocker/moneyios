//
//  CGHttpHelper.m
//  pay
//
//  Created by v2 on 2018/9/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGHttpHelper.h"
#import "CGLoginViewController.h"
#import "CGLoginTabBarController.h"
#import "XGPush.h"
#import "AppDelegate.h"

@implementation CGHttpHelper
+(void)isNeedReLoginWithHttpCode:(NSString *)httpcode message:(NSString *)message
{
    if([httpcode isEqualToString:@"1001"])
    {
        //注销信鸽
        [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:[GlobalSingleton Instance].currentUser.userid type:XGPushTokenBindTypeAccount];
        
        //登录超时，sessionkey无效，需要重新登录
        UIViewController *viewC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CGLoginTabBarController *tabbar = [[CGLoginTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
        }];
        
        [alertController addAction:skipAction];
        
        [viewC presentViewController:alertController animated:YES completion:nil];
    }else{
        [MBProgressHUD showText:message toView:[UIApplication sharedApplication].keyWindow];
    }
    
//    int code = httpcode.intValue;
//    switch (code) {
//        case 200:
//            
//            break;
//        case 400:
//            
//            break;
//        case 401:
//            
//            break;
//        case 403:
//            
//            break;
//        case 404:
//            
//            break;
//        case 405:
//            
//            break;
//        case 500:
//            
//            break;
//        case 501:
//            
//            break;
//        case 502:
//            
//            break;
//            
//            
//        default:
//            break;
//    }
}
@end
