//
//  CGConfirmPaymentView.h
//  pay
//
//  Created by v2 on 2018/8/7.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGConfirmPaymentView : UIViewController
@property(nonatomic,strong)void(^selectbankcardblock)(NSString *);
@property (nonatomic,strong)NSArray *tuanModel;
@property (nonatomic,strong)NSString *cellTextLabel1;
@property (nonatomic,strong)NSString *cellTextLabel2;
@property (nonatomic,strong)NSString *amount;
@property (nonatomic,strong)NSString *phoneNum;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSString *type;

- (void)showInView:(UIView *)view;
@end
