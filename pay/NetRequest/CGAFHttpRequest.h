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

#pragma mark - **登录模块**
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

#pragma mark - 用户退出
- (void)logoutWithserverSuccessFn:(void(^)(id dict))successFn
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
- (void)resetpwdmodeWitholdpassword:(NSString *)oldpassword
                        newpassword:(NSString *)newpassword
                    serverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 更改显示默认账户类型
- (void)updatedefaultcountWithcounttype:(NSString *)counttype
                        serverSuccessFn:(void(^)(id dict))successFn
                        serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 实名认证
- (void)authenticationWithdatas:(NSString *)datas
                serverSuccessFn:(void(^)(id dict))successFn
                serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 上传头像
- (void)uploadimgAllWithimg:(NSString *)img
            serverSuccessFn:(void(^)(id dict))successFn
            serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 汇率查看
- (void)queryAllWithserverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 根据电话查询账户信息
- (void)getuserbyTelphoneWithtelphone:(NSString *)telphone
                      serverSuccessFn:(void(^)(id dict))successFn
                      serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - **账户模块**
#pragma mark - 创建账户
- (void)createCountWithcountType:(NSString *)countType
                          payPwd:(NSString *)payPwd
                 serverSuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 修改账户状态
- (void)startOrstopCountWithID:(NSString *)ID
                         State:(NSString *)State
               serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 注销账户
- (void)logoutCountWithID:(NSString *)ID
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;


#pragma mark - **查询模块**
#pragma mark - 查询当前用户下的所有支付宝账户
- (void)querybyUseridWithID:(NSString *)ID
            serverSuccessFn:(void(^)(id dict))successFn
            serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 根据类型查询单个汇率
- (void)getSingleRateWithtype:(NSString *)type
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 查询单个用户下的所有类型账户
- (void)queryCountByUseridWithserverSuccessFn:(void(^)(id dict))successFn
                              serverFailureFn:(void(^)(NSError *error))failureFn;

//#pragma mark - 查询所有账户
//- (void)queryAllCountWithserverSuccessFn:(void(^)(id dict))successFn
//                         serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 根据流水号查询交易详情
- (void)queryByIdWithid:(NSString *)ID
        serverSuccessFn:(void(^)(id dict))successFn
        serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 查询单个用户下的所有银行卡
- (void)queryWithserverSuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 查询单个账户
- (void)queryCountWithID:(NSString *)ID
                serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn;


#pragma mark - 查询账户业务记录
- (void)operaQueryByUseridWithpage:(NSInteger )page
                   serverSuccessFn:(void(^)(id dict))successFn
                   serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 根据日期查询账单
- (void)queryByDateWithdate:(NSString *)date
                       page:(NSInteger )page
            serverSuccessFn:(void(^)(id dict))successFn
            serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 根据交易类型查询账单
- (void)queryByTypeWithtype:(NSString *)type
page:(NSInteger )page
                        serverSuccessFn:(void(^)(id dict))successFn
                  serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 查询单个信息接口
- (void)queryMessageWithserverID:(NSString *)ID
                       SuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn;


#pragma mark - 查询所有货币类型
- (void)queryMoneyTypeWithserverSuccessFn:(void(^)(id dict))successFn
                          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 查询单个账户
- (void)getuserWithserverSuccessFn:(void(^)(id dict))successFn
                   serverFailureFn:(void(^)(NSError *error))failureFn;


#pragma mark - 话费充值接口
- (void)payMentWithcountId:(NSString *)countId
                   cardNum:(NSString *)cardNum
                     phone:(NSString *)phone
                    payPwd:(NSString *)payPwd
           serverSuccessFn:(void(^)(id dict))successFn
           serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 账户充值接口
- (void)rechargeWithdatas:(NSString *)datas
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 获取银行卡类型接口
- (void)getTypeWithbankcardid:(NSString *)bankcardid
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 绑定银行卡接口
- (void)bindBankCardWithdatas:(NSString *)datas
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 解绑银行卡接口
- (void)unbindWithID:(NSString *)ID
           serverSuccessFn:(void(^)(id dict))successFn
           serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 发送接口信息
- (void)sendCardWithreceivecount:(NSString *)receivecount
                           title:(NSString *)title
                         content:(NSString *)content
                 serverSuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 获取发送信息接口
- (void)querysendWithserverSuccessFn:(void(^)(id dict))successFn
                     serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 获取收件信息接口
- (void)queryreceiveWithserverSuccessFn:(void(^)(id dict))successFn
                        serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 标记发送信息接口
- (void)marksendWithID:(NSString *)ID
       serverSuccessFn:(void(^)(id dict))successFn
       serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 标记收件信息接口
- (void)markreceiveWithID:(NSString *)ID
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 删除信息接口
- (void)messagedeleteWithID:(NSString *)ID
     serverSuccessFn:(void(^)(id dict))successFn
     serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 批量删除信息接口
- (void)batchdeleteWithids:(NSString *)ids
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 转账接口
- (void)switchWithcountid:(NSString *)countid
             receivecount:(NSString *)receivecount
                 moneynum:(NSString *)moneynum
                   payPwd:(NSString *)payPwd
              receivetype:(NSString *)receivetype
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 兑换接口
- (void)exchangeWithdatas:(NSString *)datas
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 请求修改支付密码
- (void)countCheckPhoneWithtelphone:(NSString *)telphone
                     serverSuccessFn:(void(^)(id dict))successFn
                     serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 确认修改账户支付密码
- (void)updateCountpwdWithtelphone:(NSString *)telphone
                    serverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 修改手机号接口
- (void)updatephoneWithchecknum:(NSString *)checknum
                       newphone:(NSString *)newphone
                serverSuccessFn:(void(^)(id dict))successFn
                serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 查询个人借贷
- (void)borrowQueryAllWithserverSuccessFn:(void(^)(id dict))successFn
                          serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 申请开通VIP
- (void)applyVipWithserverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 外币提现接口
- (void)getOutCashWithcountid:(NSString *)countid
                      cardnum:(NSString *)cardnum
                     banktype:(NSString *)banktype
                          num:(NSString *)num
                     username:(NSString *)username
                       paypwd:(NSString *)paypwd
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 认证原始支付密码
- (void)authCountpwdWithid:(NSString *)ID
                    payPwd:(NSString *)payPwd
           serverSuccessFn:(void(^)(id dict))successFn
           serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 修改支付密码
- (void)updateCountpwdWithid:(NSString *)ID
                      payPwd:(NSString *)payPwd
             serverSuccessFn:(void(^)(id dict))successFn
             serverFailureFn:(void(^)(NSError *error))failureFn;

#pragma mark - 获取我的页面信息
- (void)getPersonCountWithserverSuccessFn:(void(^)(id dict))successFn
                          serverFailureFn:(void(^)(NSError *error))failureFn;
@end
