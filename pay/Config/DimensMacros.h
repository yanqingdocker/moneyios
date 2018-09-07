//
//  DimensMacros.h
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h

/* 屏幕相关
 */
// 屏幕尺寸
#define SCREEN_BOUNDS        [[UIScreen mainScreen] bounds]
// 屏幕宽
#define SCREEN_WIDTH         [[UIScreen mainScreen]bounds].size.width
// 屏幕高
#define SCREEN_HEIGHT        [[UIScreen mainScreen]bounds].size.height
//状态栏高度
#define STATUSBAR_HEIGHT                    ([[UIApplication sharedApplication] statusBarFrame].size.height)
//状态栏+导航栏高
#define NAVIGATIONBAR_HEIGHT                (STATUSBAR_HEIGHT+44)
//tabbar高
#define TABBAR_HEIGHT                       (([[UIApplication sharedApplication] statusBarFrame].size.height)>20?83:49)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)




#endif /* DimensMacros_h */
