//
//  CGHttpHelper.h
//  pay
//
//  Created by v2 on 2018/9/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CGHttpHelper : NSObject
//判断登录是否超时
+(void)isNeedReLoginWithHttpCode:(NSString *)httpcode message:(NSString *)message;
@end
