//
//  CGSelectBankCardViewController.h
//  pay
//
//  Created by 胡彦清 on 2018/9/12.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBaseViewController.h"

@interface CGSelectBankCardViewController : CGBaseViewController
@property (nonatomic, assign) NSInteger selectLine;//选中行
@property(nonatomic,strong)void(^selectbankcardblock)(NSDictionary *,NSInteger);

@end
