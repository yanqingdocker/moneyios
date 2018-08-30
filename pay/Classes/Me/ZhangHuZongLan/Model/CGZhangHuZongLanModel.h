//
//  CGZhangHuZongLanModel.h
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGZhangHuZongLanModel : NSObject

@property (nonatomic, strong) NSString *blance;//金额
@property (nonatomic, strong) NSString *cardId;//卡号
@property (nonatomic, strong) NSString *checkCode;//
@property (nonatomic, strong) NSString *countType;//账户类型
@property (nonatomic, strong) NSString *createTime;//创建时间
@property (nonatomic, strong) NSString *id;//账户ID
@property (nonatomic, strong) NSString *payPwd;//支付密码
@property (nonatomic, strong) NSString *state;//状态
@property (nonatomic, strong) NSString *userId;//用户ID
@end
