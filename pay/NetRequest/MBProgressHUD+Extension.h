//
//  MBProgressHUD+Extension.h
//  pay
//
//  Created by v2 on 2018/8/16.
//  Copyright © 2018年 v2. All rights reserved.
//
#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showText:(NSString *)text toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

/**
 *  显示 HUD
 *
 *  @return 返回一个 MBProgressHud 对象
 */
+ (MB_INSTANCETYPE)showHUD;
//+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+(MBProgressHUD *)showHUDAddedToWindowAnimated:(BOOL)animated;
+(MBProgressHUD *)showHUDAddedToView:(UIView *)view animated:(BOOL)animated;
@end
