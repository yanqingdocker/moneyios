//
//  APIStringMacros.h
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h

#ifdef __OBJC__
//#define __OPTIMIZE__//打开注释为切换为生产地址

#ifndef __OPTIMIZE__  //debug release 判断
//测试地址
#define BASEURL         @"http://47.52.196.190"//基础地址
#define CHECKPHONE      @"/user/checkPhone"//获取验证码
#define REGISTER        @"/user/register"//用户注册
#define LOGIN           @"/user/login"//用户登录
#define FINDPSW         @"/user/findpsw"//找回密码
#define RESETPWD        @"/user/resetpwd"//重置密码
#define LOGINRESETPWD   @"/user/loginResetpwd"//登录后重置密码
#define AUTHENTICATION  @"/user/authentication"//实名认证

#define QUERYAll        @"/rate/queryAll"//汇率查看


#else
//正式地址
#define kNetAddress         @"wbg.cib.com.cn:9002"

#endif

#endif

#endif /* APIStringMacros_h */
