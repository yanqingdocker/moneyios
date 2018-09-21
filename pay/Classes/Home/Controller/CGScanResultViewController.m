//
//  CGScanResultViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/13.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGScanResultViewController.h"

@interface CGScanResultViewController ()

@end

@implementation CGScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initNav
{
    
    [self setBackButton:YES];
    self.navigationItem.title=@"扫码结果";
}

- (void)initUI
{
    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    titleLab.text = @"已扫描到以下内容";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
    
    [titleLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@200);
    }];
    
    UILabel *strLab = [[UILabel alloc] init];
//    strLab.frame = CGRectMake(10, 120, 300, 80);

    strLab.text = _stringValue;
    strLab.numberOfLines = 0;
    [self.view addSubview:strLab];
    
    [strLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLab.mas_bottom).offset(20);
        make.height.mas_equalTo(@200);
        make.width.mas_equalTo(@200);
    }];
    
}
@end
