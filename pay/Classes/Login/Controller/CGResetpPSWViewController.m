//
//  CGResetpPSWViewController.m
//  pay
//
//  Created by v2 on 2018/8/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGResetpPSWViewController.h"
#import "CGLoginViewController.h"
#import "CGFindPWSViewController.h"

@interface CGResetpPSWViewController ()<UITextFieldDelegate>{
//    UITextField *_telphone;
    UITextField *_password;
    UITextField *_passwordcheck;
    NSUInteger passwordlength ;
    NSUInteger passwordchecklength ;
    UIButton * loginBtn;
}

@end

@implementation CGResetpPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    passwordlength = 0;
    passwordchecklength = 0;
}

-(void)initNav{
    self.navigationItem.title = @"重置密码";
    [self setBackButton:YES];
}

- (void) initUI{
    UIImageView * bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = CGRectMake(0 , -NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [bgImageView setImage:[UIImage imageNamed:@"bgLoginImg"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgView];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
    
    NSAttributedString *passwordplace = [[NSAttributedString alloc] initWithString:@"请输入您的密码" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *passwordcheckplace = [[NSAttributedString alloc] initWithString:@"请再次输入您的密码" attributes:attrs]; // 初始化富文本占位字符串
    
    UIImageView *pswIcon = [[UIImageView alloc] init];
    pswIcon.frame = CGRectMake(40 , 166, 18, 18);
    pswIcon.image = [UIImage imageNamed:@"pwdIcon"];
    [bgView addSubview:pswIcon];
    
    //密码
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(64, 155, SCREEN_WIDTH - 64 - 43 -18 - 5, 44);
    _password.font = [UIFont systemFontOfSize:14];
    _password.textColor = [UIColor whiteColor];
    _password.attributedPlaceholder = passwordplace;
    _password.secureTextEntry = YES;
    _password.borderStyle = UITextBorderStyleNone;
    _password.clearButtonMode = UITextFieldViewModeAlways;
    _password.autocorrectionType = UITextAutocorrectionTypeNo;
    _password.delegate = self;
    [bgView addSubview:_password];
    
    //明暗文按钮
    UIButton *eyeIcon = [[UIButton alloc] init];
    eyeIcon.frame = CGRectMake(SCREEN_WIDTH - 43 - 18, 169, 18, 18);
    [eyeIcon setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:eyeIcon];
    
    UILabel *line3 = [[UILabel alloc] init];
    line3.frame = CGRectMake(40, 193, SCREEN_WIDTH - 40*2, 3);
    line3.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line3];
    
    UIImageView *pswIcon2 = [[UIImageView alloc] init];
    pswIcon2.frame = CGRectMake(40 , 240, 18, 18);
    pswIcon2.image = [UIImage imageNamed:@"pwdIcon2"];
    [bgView addSubview:pswIcon2];
    
    _passwordcheck = [[UITextField alloc] init];
    _passwordcheck.frame = CGRectMake(64, 228, SCREEN_WIDTH - 64 - 43 -18 - 5, 44);
    _passwordcheck.font = [UIFont systemFontOfSize:14];
    _passwordcheck.attributedPlaceholder = passwordcheckplace;
    _passwordcheck.textColor = [UIColor whiteColor];
    _passwordcheck.clearButtonMode = UITextFieldViewModeAlways;
    _passwordcheck.secureTextEntry = YES;
    _passwordcheck.borderStyle = UITextBorderStyleNone;
    _passwordcheck.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordcheck.delegate = self;
    [bgView addSubview:_passwordcheck];
    
    //明暗文按钮
    UIButton *eyeIcon2 = [[UIButton alloc] init];
    eyeIcon2.frame = CGRectMake(SCREEN_WIDTH - 43 - 18, 242, 18, 18);
    [eyeIcon2 setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon2 setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon2 addTarget:self action:@selector(eyeEvent2:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:eyeIcon2];
    
    UILabel *line4 = [[UILabel alloc] init];
    line4.frame = CGRectMake(40, 267, SCREEN_WIDTH - 40*2, 3);
    line4.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line4];
    
    //重置密码按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(40, 320, SCREEN_WIDTH - 80, 44);
    [loginBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = RGBCOLOR(204,38,38);
    loginBtn.layer.cornerRadius = 10.0;
    loginBtn.alpha = 0.6;
    loginBtn.userInteractionEnabled = NO;
    [loginBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
}

-(void)eyeEvent:(UIButton *)button {
    button.selected = !button.selected;
    _password.secureTextEntry = !_password.secureTextEntry;
}

-(void)eyeEvent2:(UIButton *)button {
    button.selected = !button.selected;
    _passwordcheck.secureTextEntry = !_passwordcheck.secureTextEntry;
}

- (void)nextClick{
    if([_password.text isEqualToString:_passwordcheck.text]){
        [MBProgressHUD showText:@"两次密码不一致,请确认" toView:self.view];
    }
    
    [[CGAFHttpRequest shareRequest] loginResetpwdWithtelphone:self.telphone password:_password.text checkNum:self.checkNum serverSuccessFn:^(id dict) {
        
            NSDictionary *result = dict[@"data"];
            NSLog(@"%@",result);
            
        if([dict[@"code"] isEqualToString:@"1004"]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"重置密码成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                loginBtn.enabled = NO;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertController addAction:skipAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
            
        
        
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([textField isEqual:_password]){
        passwordlength = textField.text.length - range.length + string.length;
    }else if([textField isEqual:_passwordcheck]){
        passwordchecklength = textField.text.length - range.length + string.length;
    }
    
    if (passwordlength > 0 && passwordchecklength > 0) {
        loginBtn.userInteractionEnabled = YES;
        loginBtn.alpha = 1;
    } else {
        loginBtn.userInteractionEnabled = NO;
        loginBtn.alpha = 0.6;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
