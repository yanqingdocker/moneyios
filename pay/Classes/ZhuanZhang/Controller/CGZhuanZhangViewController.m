//
//  CGZhuanZhangViewController.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhuanZhangViewController.h"
#import "CGZhuanZhangConfirmViewController.h"

@interface CGZhuanZhangViewController ()<UITextFieldDelegate>
{
    UITextField *_alipayAccount;
}

@end

@implementation CGZhuanZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initNav{
    self.navigationItem.title = @"转账";
    [self setBackButton:YES];
    
//    UIButton *chongzhijiluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    chongzhijiluBtn.frame = CGRectMake(0, 0, 15, 15);
//    chongzhijiluBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
//    [chongzhijiluBtn setTitle:@"充值记录" forState:UIControlStateNormal];
//    [chongzhijiluBtn addTarget:self action:@selector(jiluEven) forControlEvents:UIControlEventTouchUpInside];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chongzhijiluBtn];
}

- (void)initUI{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT + 10, SCREEN_WIDTH, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(15, 12, 120, 16);
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.text = @"对方账户";
    [bgView addSubview:titleLab];
    
    _alipayAccount = [[UITextField alloc] init];
    _alipayAccount.frame = CGRectMake(144, 12, SCREEN_WIDTH - 144 -35, 16);
    _alipayAccount.font = [UIFont systemFontOfSize:18];
    _alipayAccount.placeholder = @"支付宝账户";
    _alipayAccount.delegate = self;
    [bgView addSubview:_alipayAccount];
    
    UIButton *accountBtn = [[UIButton alloc] init];
    accountBtn.frame = CGRectMake(SCREEN_WIDTH - 12 -18, 11, 18, 18);
    [accountBtn setImage:[UIImage imageNamed:@"accountIcon"] forState:UIControlStateNormal];
    [accountBtn addTarget:self action:@selector(selectAccount) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:accountBtn];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.frame = CGRectMake(16, NAVIGATIONBAR_HEIGHT + 61, 200, 13);
    tipsLab.font = [UIFont systemFontOfSize:13];
    tipsLab.text = @"钱将实时转入对方账户，无法退款";
    tipsLab.textColor = RGBCOLOR(154, 152, 152);
    [self.view addSubview:tipsLab];
    
    UIButton *nextBtn = [[UIButton alloc] init];
    nextBtn.frame = CGRectMake(24, NAVIGATIONBAR_HEIGHT + 99, SCREEN_WIDTH - 24*2, 36);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = RGBCOLOR(247,195,109);
    [nextBtn addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}


- (void)selectAccount{
    
}

- (void)nextEvent{
    CGZhuanZhangConfirmViewController *vc = [[CGZhuanZhangConfirmViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

@end
