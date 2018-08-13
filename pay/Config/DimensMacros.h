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

#endif /* DimensMacros_h */
