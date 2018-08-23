//
//  UserModel.m
//  pay
//
//  Created by v2 on 2018/8/21.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "UserModel.h"
//static UserModel *shareUI = nil;
@implementation UserModel

//+ (UserModel *)sharedUserInfo
//{
//    if (!shareUI) {
//        @synchronized(self) {
//            if (!shareUI) {
//                shareUI = [[self alloc] init];
//                [shareUI setLogin:NO];
//
//            }
//        }
//    }
//    return shareUI;
//}

//- (BOOL)getLogin{
//    return _login;
//}
//
//- (void)setLogin:(BOOL)login{
//    _login =login;
//}

- (instancetype)initWihtDefaultData
//-(id)init
{
    self = [super init];
    if (self) {
        self.login=NO;                      //默认未登录
        self.phone=@"";                       //手机号
        self.userid=@"";                    //用户ID
        self.username=@"";                  //用户名
        self.idcard=@"";                  //身份证
        self.password=@"";              //密码
        self.address = @""; //住址
        self.birthday = @""; //生日
        self.createtime = @""; //账户创建日期
        self.email = @""; //邮箱
        self.img = @""; //头像
        self.isauthentication = @""; //不知是啥
        self.lasttime = @""; //最后登录时间
        self.leavel = @""; //等级
        self.num = @""; //?
        self.type = @""; //类型
        
        self.isSecurityLogOut = NO; //是否从设置里退出
        self.passportIsLogin = NO;
        
//        self.bankacco=@"";            //银行卡号
//        self.sessionkey=@"" ;       //登录成功返回的
//        self.bankserial = @"";   //银行编号
//        self.tradeacco = @"";
//        self.brachbank = @"";
//        self.bankname = @"";
//        self.yinliancdcard=@"";
//        self.identitytype=@"";
//        self.passportUserID=@"";
//        self.passportLoginSuccessCode=@"";
//        self.customerID=@"";
    }
    return self;
}
@end
