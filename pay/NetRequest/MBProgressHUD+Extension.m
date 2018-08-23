//
//  MBProgressHUD+Extension.m
//  pay
//
//  Created by v2 on 2018/8/16.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+(MBProgressHUD *)showHUDAddedToWindowAnimated:(BOOL)animated{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
    
    return hud;
}

+(MBProgressHUD *)showHUDAddedToView:(UIView *)view animated:(BOOL)animated{
    
    MBProgressHUD *hud = nil;
    if (view != nil) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
        
    }else{
        hud = [MBProgressHUD showHUDAddedToWindowAnimated:animated];
        
    }
    return hud;
}
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showText:(NSString *)text toView:(UIView *)view
{
    [self show:text icon:@"" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  显示 HUD
 *
 *  @return 返回一个 MBProgressHud 对象
 */
+ (MB_INSTANCETYPE)showHUD
{
    return [self showHUDAddedTo:nil animated:YES];
}
//+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
//    
//    if (view==nil) {
//        view = (UIView*)[[[UIApplication sharedApplication]delegate]window];
//    }
//    MBProgressHUD *hud = [[self alloc] initWithView:view];
//    [view addSubview:hud];
//    [hud show:animated];
//    return hud;
//}
@end
