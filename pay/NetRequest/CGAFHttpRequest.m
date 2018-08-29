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

#pragma mark - **登录模块**
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
- (void)resetpwdmodeWitholdpassword:(NSString *)oldpassword
                        newpassword:(NSString *)newpassword
                    serverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"oldpassword"] = oldpassword;//手机号码
    params[@"newpassword"] = newpassword;//用户密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,RESETPWDMODE]
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
    
    params[@"datas"] = datas;
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,AUTHENTICATION]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 上传头像
- (void)uploadimgAllWithimg:(NSString *)img
            serverSuccessFn:(void(^)(id dict))successFn
            serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"img"] = img;//头像文件
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,UPLOADIMG]
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

#pragma mark - **账户模块**
#pragma mark - 创建账户
- (void)createCountWithcountType:(NSString *)countType
                          payPwd:(NSString *)payPwd
                 serverSuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"countType"] = countType;//账户类型(USD,CNY)
    params[@"payPwd"] = payPwd;//支付密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,CREATECOUNT]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 修改账户状态(未调通)
- (void)startOrstopCountWithID:(NSString *)ID
                          State:(NSString *)State
                 serverSuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ID"] = ID;//账户id
    params[@"State"] = State;//状态值（0:去激活,1:激活）
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,STSRTORSTOPCOUNT]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}


//#pragma mark - 修改账户余额(通了,项目没正式跑过)
//- (void)updateBlanceWithtelphone:(NSString *)telphone
//                        checkNum:(NSString *)checkNum
//                        password:(NSString *)password
//                              id:(NSString *)ID
//                          blance:(NSString *)blance
//               serverSuccessFn:(void(^)(id dict))successFn
//               serverFailureFn:(void(^)(NSError *error))failureFn
//{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//
//    params[@"telphone"] = telphone;//手机号
//    params[@"checkNum"] = checkNum;//验证码
//    params[@"password"] = password;//密码
//    params[@"id"] = ID;//id
//    params[@"blance"] = blance;//
//
//    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,UPDATEBLANCE]
//                     WithParams:params
//                        success:successFn
//                        failure:failureFn
//                        showHUD:YES];
//}

#pragma mark - 注销账户
- (void)logoutCountWithID:(NSString *)ID
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ID"] = ID;//id
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,LOGOUTCOUNT]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 根据电话查询账户信息
- (void)getuserbyTelphoneWithtelphone:(NSString *)telphone
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//电话
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,GETUSERBYTELPHONE]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - **账户模块**
#pragma mark - 查询当前用户下的所有支付宝账户
- (void)querybyUseridWithID:(NSString *)ID
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ID"] = ID;//id
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYBYUSERID]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 根据类型查询单个汇率
- (void)getSingleRateWithtype:(NSString *)type
                   serverSuccessFn:(void(^)(id dict))successFn
                   serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"type"] = type;//type=USDCNY(两种货币类型)
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,GETSINGLERATE]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 查询单个用户下的所有类型账户
- (void)queryCountByUseridWithserverSuccessFn:(void(^)(id dict))successFn
                              serverFailureFn:(void(^)(NSError *error))failureFn
{
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYCOUNTBYUSERID]
                     WithParams:nil
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 根据流水号查询交易详情
- (void)queryByIdWithid:(NSString *)ID
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"id"] = ID;//流水号
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYBYID]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

//#pragma mark - 查询所有账户
//- (void)queryAllCountWithserverSuccessFn:(void(^)(id dict))successFn
//                              serverFailureFn:(void(^)(NSError *error))failureFn
//{
//    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYALLCOUNT]
//                    WithParams:nil
//                       success:successFn
//                       failure:failureFn
//                       showHUD:YES];
//}

#pragma mark - 查询单个用户下的所有银行卡
- (void)queryWithserverSuccessFn:(void(^)(id dict))successFn
                              serverFailureFn:(void(^)(NSError *error))failureFn
{
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERY]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 查询单个账户
- (void)queryCountWithID:(NSString *)ID
                     serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"id"] = ID;//id
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYCOUNT]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 查询账户业务记录
- (void)operaQueryByUseridWithserverSuccessFn:(void(^)(id dict))successFn
                              serverFailureFn:(void(^)(NSError *error))failureFn
{
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,OPERAQUERYBYUSERID]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 查询单个信息接口
- (void)queryMessageWithserverID:(NSString *)ID
                     SuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ID"] = ID;//id
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYMESSAGE]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 查询所有货币类型
- (void)queryMoneyTypeWithserverSuccessFn:(void(^)(id dict))successFn
                              serverFailureFn:(void(^)(NSError *error))failureFn
{
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYMONEYTYPE]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 查询单个账户
- (void)getuserWithserverSuccessFn:(void(^)(id dict))successFn
                   serverFailureFn:(void(^)(NSError *error))failureFn
{
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,GETUSER]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark **接口模块**
#pragma mark - 话费充值接口
- (void)payMentWithcountId:(NSString *)countId
                   cardNum:(NSString *)cardNum
                     phone:(NSString *)phone
           serverSuccessFn:(void(^)(id dict))successFn
           serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"countId"] = countId;//账户id
    params[@"cardNum"] = cardNum;//充值金额
    params[@"phone"] = phone;//充值手机号
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,REGISTER]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 账户充值接口
- (void)rechargeWithtradeMoney:(NSString *)tradeMoney
                       payType:(NSString *)payType
                       countId:(NSString *)countId
               serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"tradeMoney"] = tradeMoney;//充值金额
//    params[@"payType"] = payType;//类型
//    params[@"countId"] = countId;//充值账户ID
    
    NSDictionary *song2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1",@"tradeMoney",
                           @"CNY",@"payType",
                           @"688485602369",@"countId",
                           nil];//貌似是两个参数,不需要payType

    
    params[@"datas"] = song2;//账户id
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,RECHARGE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 获取银行卡类型接口
- (void)getTypeWithbankcardid:(NSString *)bankcardid
               serverSuccessFn:(void(^)(id dict))successFn
               serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"bankcardid"] = bankcardid;//银行卡号
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,GETTYPE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 绑定银行卡接口
- (void)bindBankCardWithdatas:(NSString *)datas
                serverSuccessFn:(void(^)(id dict))successFn
                serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"datas"] = datas;
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,BINDBANKCARD]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 解绑银行卡接口
- (void)bindBankCardWithID:(NSString *)ID
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ID"] = ID;
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,UNBIND]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 发送接口信息
- (void)sendCardWithreceivecount:(NSString *)receivecount
                           title:(NSString *)title
                         content:(NSString *)content
                 serverSuccessFn:(void(^)(id dict))successFn
                 serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"receivecount"] = receivecount;//收件人电话
    params[@"title"] = title;//标题
    params[@"content"] = content;//内容
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,SEND]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 获取发送信息接口
- (void)querysendWithserverSuccessFn:(void(^)(id dict))successFn
                     serverFailureFn:(void(^)(NSError *error))failureFn

{
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,SEND]
                    WithParams:nil
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 获取收件信息接口
- (void)queryreceiveWithserverSuccessFn:(void(^)(id dict))successFn
                     serverFailureFn:(void(^)(NSError *error))failureFn

{
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,QUERYRECEIVE]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 标记发送信息接口
- (void)marksendWithID:(NSString *)ID
           serverSuccessFn:(void(^)(id dict))successFn
           serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"id"] = ID;
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,MARKSEND]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 标记收件信息接口
- (void)markreceiveWithID:(NSString *)ID
       serverSuccessFn:(void(^)(id dict))successFn
       serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"id"] = ID;
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,MARKRECEIVE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 删除信息接口
- (void)messagedeleteWithID:(NSString *)ID
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"id"] = ID;
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,MESSAGEDELETE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 批量删除信息接口
- (void)batchdeleteWithids:(NSString *)ids
     serverSuccessFn:(void(^)(id dict))successFn
     serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"ids"] = ids;//1,2,3
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,BATCHDELETE]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 转账接口
- (void)switchWithcountid:(NSString *)countid
              receivecount:(NSString *)receivecount
                 moneynum:(NSString *)moneynum
                   payPwd:(NSString *)payPwd
          serverSuccessFn:(void(^)(id dict))successFn
          serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"countid"] = countid;//支出的账户id
    params[@"receivecount"] = receivecount;///转入账户的手机号
    params[@"moneynum"] = moneynum;//待转金额
    params[@"payPwd"] = payPwd;//支付密码
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,SWITCH]
                    WithParams:params
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

//srcountid:(NSString *)srcountid
//destcountid:(NSString *)destcountid
//srcmoney:(NSString *)srcmoney
//destmoney:(NSString *)destmoney
//paypwd:(NSString *)paypwd
#pragma mark - 兑换接口
- (void)exchangeWithdatas:(NSString *)datas
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"datas"] = datas;
    
//    params[@"srcountid"] = srcountid;//原账户id
//    params[@"destcountid"] = destcountid;///目标账户id
//    params[@"srcmoney"] = srcmoney;//需要兑换的额度
//    params[@"destmoney"] = destmoney;//兑换后的额度
//    params[@"paypwd"] = paypwd;//支付密码
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,EXCHANGE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 请求修改支付密码
- (void)countCheckPhoneWithtelphone:(NSString *)telphone
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//手机号
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,COUNTCHECKPHONE]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 确认修改账户支付密码
- (void)updateCountpwdWithtelphone:(NSString *)telphone
                           checknum:(NSString *)checknum
                                 id:(NSString *)ID
                             payPwd:(NSString *)payPwd
                     serverSuccessFn:(void(^)(id dict))successFn
                     serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"telphone"] = telphone;//手机号
    params[@"checknum"] = checknum;//手机验证码
    params[@"id"] = ID;//账户id
    params[@"payPwd"] = payPwd;//支付密码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,UPDATECOUNTPWD]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 修改手机号接口
- (void)updatephoneWithchecknum:(NSString *)checknum
                           newphone:(NSString *)newphone
                    serverSuccessFn:(void(^)(id dict))successFn
                    serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"newphone"] = newphone;//手机号
    params[@"checknum"] = checknum;//手机验证码
    
    [self postDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,UPDATECOUNTPWD]
                     WithParams:params
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 查询个人借贷
- (void)borrowQueryAllWithserverSuccessFn:(void(^)(id dict))successFn
                          serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,BORROWQUERYALL]
                     WithParams:nil
                        success:successFn
                        failure:failureFn
                        showHUD:YES];
}

#pragma mark - 申请开通VIP
- (void)applyVipWithserverSuccessFn:(void(^)(id dict))successFn
                          serverFailureFn:(void(^)(NSError *error))failureFn
{
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,APPLYVIP]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

#pragma mark - 外币提现接口
- (void)getOutCashWithcountid:(NSString *)countid
                      cardnum:(NSString *)cardnum
                     banktype:(NSString *)banktype
                          num:(NSString *)num
                     username:(NSString *)username
                       paypwd:(NSString *)paypwd
              serverSuccessFn:(void(^)(id dict))successFn
              serverFailureFn:(void(^)(NSError *error))failureFn
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"countid"] = countid;//账户id
    params[@"cardnum"] = cardnum;//银行卡号
    params[@"banktype"] = banktype;//银行卡类型
    params[@"num"] = num;//提现金额
    params[@"username"] = username;//持卡人姓名
    params[@"paypwd"] = paypwd;//指出账户密码
    
    [self getDataWithURLString:[NSString stringWithFormat:@"%@%@",BASEURL,APPLYVIP]
                    WithParams:nil
                       success:successFn
                       failure:failureFn
                       showHUD:YES];
}

@end
