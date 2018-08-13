//
//  CGInitProcess.h
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLoginViewController.h"

@interface CGInitProcess : NSObject

@property (nonatomic,strong)UIApplication *application;
@property (nonatomic,strong)NSDictionary *launchOptions;

//主框架界面
@property (nonatomic,strong)CGLoginViewController *cgLoginViewController;

//启动
-(BOOL)startupProcessWithApplication:(UIApplication*)application andOptions:(NSDictionary*)launchOptions;

@end
