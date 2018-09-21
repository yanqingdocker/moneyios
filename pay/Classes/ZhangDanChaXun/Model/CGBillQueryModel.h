//
//  CGBillQueryModel.h
//  pay
//
//  Created by 胡彦清 on 2018/9/13.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGBillQueryModel : NSObject
@property(nonatomic,copy)NSString *countType;  //货币类型
@property(nonatomic,copy)NSString *countid;  //id
@property(nonatomic,copy)NSString *id;  //id
@property(nonatomic,copy)NSString *img;  //头像
@property(nonatomic,copy)NSString *num;  //金额
@property(nonatomic,copy)NSString *oi;  //收支标识1收入,0支出
@property(nonatomic,copy)NSString *operaIp;  //ip
@property(nonatomic,copy)NSString *operaTime;  //时间
@property(nonatomic,copy)NSString *operaType;  //类别
@property(nonatomic,copy)NSString *operaUser;  //用户名
@property(nonatomic,copy)NSString *servicebranch;  //类型
@property(nonatomic,copy)NSString *snumber;  //流水号

@end
