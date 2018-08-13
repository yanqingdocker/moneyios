//
//  CGAFHttpRequest.m
//  pay
//
//  Created by v2 on 2018/8/9.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGAFHttpRequest.h"

@implementation CGAFHttpRequest

+ (instancetype)shareRequest
{
    static CGAFHttpRequest *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[CGAFHttpRequest alloc]init];
    });
    return request;
}

#pragma mark - **登录**
#pragma mark - 获取验证码
- (void)checkPhoneWithtelphone:(NSString *)telphone
               serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//用户名
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,CHECKPHONE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 用户注册
- (void)registerWithphone:(NSString *)phone
                 password:(NSString *)password
                 checkNum:(NSString *)checkNum
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"telphone"] = phone;//手机号码
    params[@"password"] = password;//用户密码
    params[@"checkNum"] = checkNum;//短信验证码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,REGISTER]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 用户登录
- (void)loginWithphone:(NSString *)phone
              password:(NSString *)password
       serverSuccessFn:(void(^)(id dict))successFn
       serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = phone;//手机号码
    params[@"password"] = password;//用户密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,LOGIN]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 找回密码
- (void)findpswWithtelphone:(NSString *)telphone
                   checknum:(NSString *)checknum
            serverSuccessFn:(void(^)(id dict))successFn
            serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//手机号码
    params[@"checknum"] = checknum;//用户密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,FINDPSW]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 重置密码
- (void)resetpwdWithtelphone:(NSString *)telphone
                    password:(NSString *)password
             serverSuccessFn:(void(^)(id dict))successFn
             serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//手机号码
    params[@"password"] = password;//用户密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,RESETPWD]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 登录后重置密码
- (void)loginResetpwdWithtelphone:(NSString *)telphone
                    password:(NSString *)password
             serverSuccessFn:(void(^)(id dict))successFn
             serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//手机号码
    params[@"password"] = password;//用户密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,LOGINRESETPWD]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 实名认证
- (void)authenticationWithdatas:(NSString *)datas
                serverSuccessFn:(void(^)(id dict))successFn
                serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"datas"] = datas;//手机号码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,AUTHENTICATION]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 汇率查看
- (void)queryAllWithserverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYAll]
                     WithParams:Nil
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}
@end
