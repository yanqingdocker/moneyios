//
//  CGUpdateUserNameViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGCheckPhoneViewController.h"
#import "CGChangePhoneViewController.h"
@interface CGCheckPhoneViewController ()<UITextFieldDelegate,UITextViewDelegate>
//@property (nonatomic,strong)UITextField *phone;
@property (nonatomic,strong)UIButton *submitBtn;

@end

@implementation CGCheckPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initNav{
    self.navigationItem.title = @"手机号";
    [self setBackButton:YES];
}
-(void)initUI{
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.borderWidth = 0.5;
    phoneView.layer.borderColor = RGBCOLOR(203, 203, 228).CGColor;
    [self.view addSubview:phoneView];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(18, 15, 300, 16);
    titleLab.text = [NSString stringWithFormat:@"当前已绑定手机号 %@",_phone];
    titleLab.font = [UIFont systemFontOfSize:16];
    [phoneView addSubview:titleLab];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.frame = CGRectMake(18, 64, 310, 10);
    tipsLab.text = [NSString stringWithFormat:@"与系统绑定的手机号码，在开启登录开关的条件下可用作登录账号。"];
    tipsLab.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:tipsLab];
//    _phone = [[UITextField alloc] initWithFrame:CGRectMake(17, 18, SCREEN_WIDTH - 17*2, 12)];
//    _phone.placeholder = @"请输入用户名";
//    _phone.font = [UIFont systemFontOfSize:12];
//    _phone.delegate = self;
//    _phone.borderStyle = UIKeyboardTypeNumberPad;
//    [phoneView addSubview:_phone];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake(20, 99, SCREEN_WIDTH-20*2, 44);
    [_submitBtn setTitle:@"更换手机号" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}

-(void)submitClick{
    
//    if (_amount.text.length == 0) {
//        [MBProgressHUD showText:@"请输入充值金额" toView:self.view];
//        return;
//    }
//    if (_num.text.length == 0) {
//        [MBProgressHUD showText:@"请输入单号" toView:self.view];
//        return;
//    }
//    if(_password.text.length == 0){
//        [MBProgressHUD showText:@"请输入密码" toView:self.view];
//        return;
//    }
//    
//    //    _submitBtn.enabled = NO;
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"充值成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    [alertController addAction:skipAction];
//    [self presentViewController:alertController animated:YES completion:nil];
    CGChangePhoneViewController *vc = [[CGChangePhoneViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
    
}

@end
