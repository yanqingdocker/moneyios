//
//  GlobalSingleton.h
//  pay
//
//  Created by v2 on 2018/8/21.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface GlobalSingleton : NSObject
@property(readonly, copy, nonatomic) NSString *clientVersion;//APP版本号

@property(nonatomic, getter=is_RegistNotification) BOOL registNotification;//是否初始化注册通知

+ (GlobalSingleton *)Instance;

/**
 *  当前登录的用户
 */
@property(nonatomic, strong) UserModel *currentUser;


/**
 *  客户端是否是第一次运行
 */
- (BOOL)isFirstRun;

/**
 *  用户是否已经登录
 */
- (BOOL)hasLogin;

#pragma -mark
/**
 *  清空所有数据
 */
-(void)removeAll;

///**
// *  md5签名
// */
//- (NSString *)md5:(NSString *)str;
/**
 *  随机生成24位key
 */
-(NSString *)ret24bitString;


@end
