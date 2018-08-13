//
//  CGAFHttpRequest.h
//  pay
//
//  Created by v2 on 2018/8/9.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGNetworkingManager.h"

@interface CGAFHttpRequest : CGNetworkingManager

//单例请求类
+ (instancetype)shareRequest;

- (void)checkPhoneWithtelphone:(NSString *)telphone
               serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - **登录**
#pragma mark - 获取验证码
- (void)userLoginWithusername:(NSString *)username
                          pwd:(NSString *)pwd
                       aesKey:(NSString *)aesKey
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 用户注册
- (void)registerWithphone:(NSString *)phone
                 password:(NSString *)password
                 checkNum:(NSString *)checkNum
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 用户登录
- (void)loginWithphone:(NSString *)phone
              password:(NSString *)password
       serverSuccessFn:(void(^)(id dict))successFn
       serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 找回密码
- (void)findpswWithtelphone:(NSString *)telphone
                   checknum:(NSString *)checknum
            serverSuccessFn:(void(^)(id dict))successFn
            serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 重置密码
- (void)resetpwdWithtelphone:(NSString *)telphone
                    password:(NSString *)password
             serverSuccessFn:(void(^)(id dict))successFn
             serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 登陆后重置密码
- (void)loginResetpwdWithtelphone:(NSString *)telphone
                         password:(NSString *)password
                  serverSuccessFn:(void(^)(id dict))successFn
                  serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 实名认证
- (void)authenticationWithdatas:(NSString *)datas
                serverSuccessFn:(void(^)(id dict))successFn
                serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 汇率查看
- (void)queryAllWithserverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn;
@end
