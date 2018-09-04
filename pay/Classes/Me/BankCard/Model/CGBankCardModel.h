//
//  CGBankCardModel.h
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGBankCardModel : NSObject
@property (nonatomic, strong) NSString *bankCard;//银行卡号
@property (nonatomic, strong) NSString *bankType;//银行卡类型
@property (nonatomic, strong) NSString *cardAddress;//地址
@property (nonatomic, strong) NSString *createTime;//创建时间
@property (nonatomic, strong) NSString *id;//账户ID
@property (nonatomic, strong) NSString *idCard;//身份证
@property (nonatomic, strong) NSString *phone;//手机号
@property (nonatomic, strong) NSString *userId;//用户ID
@property (nonatomic, strong) NSString *username;//用户名

@end
