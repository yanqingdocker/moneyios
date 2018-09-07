//
//  CGZhuanZhangConfirmViewController.h
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBaseViewController.h"

@interface CGZhuanZhangConfirmViewController : CGBaseViewController
@property(nonatomic,strong)NSString *moneynum;//金额
@property(nonatomic,strong)NSData *imgdata;//头像data
@property(nonatomic,strong)NSString *receivecount;//电话
@property(nonatomic,strong)NSString *username;//名称
@property(nonatomic,strong)NSString *type;//资金类型
//@property(nonatomic,strong)NSMutableArray *typeArray;//资金类型

@end
