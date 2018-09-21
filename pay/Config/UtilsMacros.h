//
//  UtilsMacros.h
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

#define RGB(r, g, b, a)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define CGRGB(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a].CGColor
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define getAppWindow()     ([[UIApplication sharedApplication]delegate]).window

#define countries @[@"中国大陆",@"中国香港",@"柬埔寨",@"新加坡",@"马来西亚",@"泰国",@"缅甸",@"印度尼西亚",@"菲律宾",@"越南",@"老挝",@"文莱"]
#define areaCode @[@"",@"852",@"855",@"65",@"60",@"66",@"95",@"62",@"63",@"84",@"856",@"673"]
#endif /* UtilsMacros_h */
