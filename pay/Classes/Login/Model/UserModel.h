//
//  UserModel.h
//  pay
//
//  Created by v2 on 2018/8/21.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//+ (UserModel *)sharedUserInfo;
@property(assign,getter=is_Login) BOOL login;           //登陆状态                     默认   NO
@property(nonatomic,assign) BOOL passportIsLogin; //passport登录
@property(nonatomic, copy) NSString *phone;             //手机号                      默认  @“”
@property(nonatomic, copy) NSString *userid;          //标识                        同上
@property(nonatomic, copy) NSString *username;        //用户名                       同上
@property(nonatomic,copy) NSString *idcard;         //身份证                       同上
@property(nonatomic, copy) NSString *password;    //密码                        同上
@property(nonatomic,copy)NSString *address;  //住址
@property(nonatomic,copy)NSString *birthday;  //生日
@property(nonatomic,copy)NSString *createtime;  //账户创建日期
@property(nonatomic,copy)NSString *email;  //邮箱
@property(nonatomic,copy)NSString *img;  //头像流
@property(nonatomic,copy)NSString *isauthentication;  //不知是啥
@property(nonatomic,copy)NSString *lasttime;  //最后登录时间
@property(nonatomic,copy)NSString *leavel;  //等级
@property(nonatomic,copy)NSString *num;  //???
@property(nonatomic,copy)NSString *type;  //类型

//@property(nonatomic,copy) NSString *bankacco;   //银行卡号                      同上
//@property(nonatomic,copy)NSString *sessionkey;        //登录成功返回的                   同上
//@property(nonatomic,copy)NSString *bankserial;// 银行编号
//@property(nonatomic,copy)NSString *yinliancdcard; //银联CD卡号
//@property(nonatomic,copy)NSString *identitytype; //证件类型
//@property(nonatomic,copy)NSString *tradeacco;//交易账号
//@property(nonatomic,copy)NSString *brachbank; //联行号
//@property(nonatomic,copy)NSString *bankname; //银行名
//@property(nonatomic,copy)NSString *passportUserID; //passportUserID 手机号码注册成功后返回的id
//@property(nonatomic,copy)NSString *passportLoginSuccessCode;//passport登录成功后返回的code保存，只在登陆成功后使用
//@property(nonatomic,copy)NSString *customerID;  //客户ID

@property(nonatomic,assign)BOOL isSecurityLogOut;

//- (void)setLogin:(BOOL)login;
//- (BOOL)getLogin;

- (instancetype)initWihtDefaultData;
@end
