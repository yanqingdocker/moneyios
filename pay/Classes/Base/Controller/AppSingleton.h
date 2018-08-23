//
//  AppSingleton.h
//  pay
//
//  Created by v2 on 2018/8/2.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface AppSingleton : NSObject <MBProgressHUDDelegate>


/**
 *  获取单例对象
 *
 *  @return 单例对象
 */
//+ (id)sharedInstance;
//
//#pragma mark --------------------- hud
///**
// *  显示加载转圈视图
// */
//- (void)showLoadingHUD;
//
///**
// *  显示带文字的hud
// *
// *  @param title 文字
// */
//- (void)showHUDWithTitle:(NSString *)title;
//
///**
// *  显示带文字+标题的hud
// *
// *  @param title 文字
// */
//- (void)showAnimationTitleView:(NSString *)title;
//
///**
// *  隐藏hud
// */
//- (void)hideHUD;

@end


