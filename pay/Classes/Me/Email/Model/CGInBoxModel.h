//
//  CGInBoxModel.h
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGInBoxModel : NSObject
@property (nonatomic, strong) NSString *content;//内容
@property (nonatomic, strong) NSString *createTime;//时间
@property (nonatomic, strong) NSString *id;//唯一标识
@property (nonatomic, strong) NSString *messagetype;//0收件,1发件
@property (nonatomic, strong) NSString *title;//标题
@property (nonatomic, strong) NSString *userid;//用户ID
@property (nonatomic, strong) NSString *username;//用户名
@property (nonatomic, strong) NSString *visiable;//已读未读

@end
