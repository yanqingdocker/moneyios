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
//登录模块
#define BASEURL             @"http://47.52.196.190:443"//基础地址
//#define BASEURL             @"http://192.168.31.12:443"//yanqing地址
//#define BASEURL             @"http://192.168.1.3:8082"//自己家地址
#define CHECKPHONE          @"/user/checkPhone"//获取验证码
#define REGISTER            @"/user/register"//用户注册
#define LOGIN               @"/user/login"//用户登录
#define LOGOUT              @"/user/logout"//用户退出
#define FINDPSW             @"/user/findpsw"//找回密码
#define RESETPWD            @"/user/resetpwd"//重置密码
#define LOGINRESETPWD       @"/user/loginResetpwd"//登录前重置密码
#define RESETPWDMODE        @"/user/resetpwdmode"//登录后重置密码
#define UPDATEDEFAULTCOUNT  @"/user/updatedefaultcount"//更改显示默认账户类型
#define AUTHENTICATION      @"/user/authentication"//实名认证
#define UPLOADIMG           @"/user/uploadimg"//上传头像
#define QUERYAll            @"/rate/queryAll"//汇率查看
#define GETUSERBYTELPHONE   @"/user/getuserbyTelphone"//汇率查看

//账户模块
#define CREATECOUNT         @"/count/createCount"//创建账户
#define STSRTORSTOPCOUNT    @"/count/startOrstopCount"//修改账户状态
//#define UPDATEBLANCE      @"/count/updateBlance"//修改账户余额
#define LOGOUTCOUNT         @"/count/logoutCount"//注销账户
#define AUTHCOUNTPWD        @"/count/authCountpwd"//认证原始支付密码
#define UPDATECOUNTPWD      @"/count/updateCountpwd"//修改支付密码
#define GETPERSONCOUNT      @"/count/getPersonCount"//获取我的页面信息

//查询模块
#define QUERYBYUSERID       @"/appliy/querybyUserid"//查询当前用户下的所有支付宝账户
#define GETSINGLERATE       @"/rate/getSingleRate"//根据类型查询单个汇率
#define QUERYBYID           @"/opera/queryById"//根据流水号查询交易详情
#define QUERYCOUNTBYUSERID  @"/count/queryCountByUserid"//查询单个用户下的所有类型账户
#define QUERYALLCOUNT       @"/count/queryAllCount"//查询所有账户
#define QUERY               @"/bank/query"//查询单个用户下的所有银行卡
#define QUERYCOUNT          @"/count/queryCount"//查询单个账户
#define OPERAQUERYBYUSERID  @"/opera/queryByUserid"//查询账户业务记录
#define QUERYBYDATE         @"/opera/queryByDate"//根据日期查询账单
#define QUERYBYTYPE         @"/opera/queryByType"//根据交易类型查询账单
#define QUERYMESSAGE        @"/message/queryMessage"//查询单个信息接口
#define QUERYMONEYTYPE      @"/count/queryMoneyType"//查询所有货币类型
#define GETUSER             @"/user/getuser"//查询单个账户

//接口模块
#define PAYMENT             @"/mobile/payMent"//话费充值接口
#define RECHARGE            @"/pay/recharge"//账户充值接口
#define GETTYPE             @"/bank/getType"//获取银行卡类型接口
#define BINDBANKCARD        @"/bank/bindBankCard"//绑定银行卡接口
#define UNBIND              @"/bank/unbind"//解绑银行卡接口
#define SEND                @"/message/send"//发送接口信息
#define QUERYSEND           @"/message/querysend"//获取发送信息接口
#define QUERYRECEIVE        @"/message/queryreceive"//获取收件信息接口
#define MARKSEND            @"/message/marksend"//标记发送信息接口
#define MARKRECEIVE         @"/message/markreceive"//标记收件信息接口
#define MESSAGEDELETE       @"/message/delete"//删除信息接口
#define BATCHDELETE         @"/message/batchdelete"//批量删除信息接口
#define SWITCH              @"/count/switch"//转账接口
#define EXCHANGE            @"/count/exchange"//兑换接口

//支付模块
#define COUNTCHECKPHONE     @"/count/checkPhone"//请求修改支付密码
#define UPDATECOUNTPWD      @"/count/updateCountpwd"//确认修改账户支付密码
#define UPDATEPHONE         @"/user/updatephone"//修改手机号接口
#define BORROWQUERYALL      @"/borrow/queryAll"//查询个人借贷
#define APPLYVIP            @"/user/applyVip"//开通VIP
#define GETOUTCASH          @"/count/getOutCash"//外币提现接口
#define ORDERPAY            @"/api/orderPay"//支付宝充值

#else
//正式地址
#define kNetAddress         @"wbg.cib.com.cn:9002"

#endif

#endif

#endif /* APIStringMacros_h */
