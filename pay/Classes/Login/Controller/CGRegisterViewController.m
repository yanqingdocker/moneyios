//
//  CGRegisterViewController.m
//  pay
//
//  Created by v2 on 2018/8/9.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGRegisterViewController.h"
#import "LMJDropdownMenu.h"

@interface CGRegisterViewController ()<UITextFieldDelegate,LMJDropdownMenuDelegate>{
    UITextField *_telphone;
    UITextField *_check;
    UITextField *_password;
    UITextField *_passwordcheck;
    LMJDropdownMenu * dropdownMenu;
    UIButton * loginBtn;
    NSUInteger telphonelength ;
    NSUInteger checklength ;
    NSUInteger passwordlength ;
    NSUInteger passwordchecklength ;
}

@property (strong, nonatomic) UIButton *getCheckBtn;
@end

@implementation CGRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    telphonelength = 0;
    checklength = 0;
    passwordlength = 0;
    passwordchecklength = 0;
}

-(void)initNav{
    self.navigationItem.title = @"注册";
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
    
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.frame = CGRectMake(40 , 99, 18, 18);
    phoneIcon.image = [UIImage imageNamed:@"phoneIcon"];
    [bgView addSubview:phoneIcon];
    
    dropdownMenu = [[LMJDropdownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(52, 101, 110, 13)];
    [dropdownMenu setMenuTitles:countries rowHeight:30];
    dropdownMenu.delegate = self;
    [dropdownMenu.mainBtn setTitle:@"选择国家" forState:UIControlStateNormal];
    [dropdownMenu.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dropdownMenu.mainBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [bgView addSubview:dropdownMenu];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.frame = CGRectMake(40, 126, SCREEN_WIDTH - 40*2, 3);
    line1.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line1];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
    NSAttributedString *accountplace = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *checkplace = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *passwordplace = [[NSAttributedString alloc] initWithString:@"请输入您的密码" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *passwordcheckplace = [[NSAttributedString alloc] initWithString:@"请再次输入您的密码" attributes:attrs]; // 初始化富文本占位字符串
    
    _telphone = [[UITextField alloc] init];
    _telphone.frame = CGRectMake(145, 86, SCREEN_WIDTH - 145 - 15 - 17 -5, 44);
    _telphone.textColor = [UIColor whiteColor];
    _telphone.attributedPlaceholder = accountplace;
    _telphone.clearButtonMode = UITextFieldViewModeAlways;
    _telphone.delegate = self;
    _telphone.font = [UIFont systemFontOfSize:14];
    _telphone.borderStyle = UITextBorderStyleNone;
    _telphone.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:_telphone];
    
    UIImageView *checkIcon = [[UIImageView alloc] init];
    checkIcon.frame = CGRectMake(40 , 153, 18, 18);
    checkIcon.image = [UIImage imageNamed:@"checkIcon"];
    [bgView addSubview:checkIcon];
    
    _check = [[UITextField alloc] init];
    _check.frame = CGRectMake(64, 140, 130, 44);
    _check.textColor = [UIColor whiteColor];
    _check.attributedPlaceholder = checkplace;
    _check.clearButtonMode = UITextFieldViewModeNever;
    _check.delegate = self;
    _check.font = [UIFont systemFontOfSize:14];
    _check.borderStyle = UITextBorderStyleNone;
    _check.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:_check];
    
    UILabel *shuline = [[UILabel alloc] init];
    shuline.frame = CGRectMake(SCREEN_WIDTH - 13 -110 -35, 155, 1, 13);
    shuline.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:shuline];
    
    _getCheckBtn = [[UIButton alloc] init];
    _getCheckBtn.frame = CGRectMake(SCREEN_WIDTH - 110 -35, 155, 110, 14);
    [_getCheckBtn setTitleColor:RGBCOLOR(216,40,40) forState:UIControlStateNormal];
    [_getCheckBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCheckBtn addTarget:self action:@selector(getCheckClick) forControlEvents:UIControlEventTouchUpInside];
    _getCheckBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [bgView addSubview:_getCheckBtn];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.frame = CGRectMake(40, 181, SCREEN_WIDTH - 40*2, 3);
    line2.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line2];
    
    UIImageView *pswIcon = [[UIImageView alloc] init];
    pswIcon.frame = CGRectMake(40 , 210, 18, 18);
    pswIcon.image = [UIImage imageNamed:@"pwdIcon"];
    [bgView addSubview:pswIcon];
    
    //密码
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(64, 199, SCREEN_WIDTH - 64 - 43 -18 - 5, 44);
    _password.font = [UIFont systemFontOfSize:14];
    _password.textColor = [UIColor whiteColor];
    _password.attributedPlaceholder = passwordplace;
    _password.clearButtonMode = UITextFieldViewModeAlways;
    _password.secureTextEntry = YES;
    _password.borderStyle = UITextBorderStyleNone;
    _password.autocorrectionType = UITextAutocorrectionTypeNo;
    _password.delegate = self;
    [bgView addSubview:_password];
    
    //明暗文按钮
    UIButton *eyeIcon = [[UIButton alloc] init];
    eyeIcon.frame = CGRectMake(SCREEN_WIDTH - 43 - 18, 213, 18, 18);
    [eyeIcon setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:eyeIcon];
    
    UILabel *line3 = [[UILabel alloc] init];
    line3.frame = CGRectMake(40, 237, SCREEN_WIDTH - 40*2, 3);
    line3.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line3];
    
    UIImageView *pswIcon2 = [[UIImageView alloc] init];
    pswIcon2.frame = CGRectMake(40 , 269, 18, 18);
    pswIcon2.image = [UIImage imageNamed:@"pwdIcon2"];
    [bgView addSubview:pswIcon2];
    
    _passwordcheck = [[UITextField alloc] init];
    _passwordcheck.frame = CGRectMake(64, 256, SCREEN_WIDTH - 64 - 43 -18 - 5, 44);
    _passwordcheck.font = [UIFont systemFontOfSize:14];
    _passwordcheck.attributedPlaceholder = passwordcheckplace;
    _passwordcheck.clearButtonMode = UITextFieldViewModeAlways;
    _passwordcheck.textColor = [UIColor whiteColor];
    _passwordcheck.secureTextEntry = YES;
    _passwordcheck.borderStyle = UITextBorderStyleNone;
    _passwordcheck.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordcheck.delegate = self;
//    _passwordcheck.inputView = [[UIView alloc]init];
    [bgView addSubview:_passwordcheck];
    
    //明暗文按钮
    UIButton *eyeIcon2 = [[UIButton alloc] init];
    eyeIcon2.frame = CGRectMake(SCREEN_WIDTH - 43 - 18, 272, 18, 18);
    [eyeIcon2 setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon2 setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon2 addTarget:self action:@selector(eyeEvent2:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:eyeIcon2];
    
    UILabel *line4 = [[UILabel alloc] init];
    line4.frame = CGRectMake(40, 297, SCREEN_WIDTH - 40*2, 3);
    line4.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line4];
    
    //注册按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(40, 340, SCREEN_WIDTH - 80, 44);
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    loginBtn.backgroundColor = RGBCOLOR(226, 81, 74);
    loginBtn.backgroundColor = RGBCOLOR(204, 38, 38);
    loginBtn.layer.cornerRadius = 10.0;
    loginBtn.userInteractionEnabled = NO;
    loginBtn.alpha=0.6;//透明度
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

- (void)getCheckClick{
    [[CGAFHttpRequest shareRequest] checkPhoneWithtelphone:_telphone.text
                                           serverSuccessFn:^(id dict)
     {
         NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
         if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
             [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
         }else{
             [self startTimer:_getCheckBtn];
         }
         
     }serverFailureFn:^(NSError *error){
         if(error){
             NSLog(@"%@",error);
         }
     }];
}

- (void)nextClick{
    [self.view endEditing:YES];
    [[CGAFHttpRequest shareRequest] registerWithphone:_telphone.text password:_password.text checkNum:_check.text serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    loginBtn.enabled = NO;
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:skipAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([textField isEqual:_telphone]){
        telphonelength = textField.text.length - range.length + string.length;
    }else if([textField isEqual:_check]){
        checklength = textField.text.length - range.length + string.length;
    }else if([textField isEqual:_password]){
        passwordlength = textField.text.length - range.length + string.length;
    }else if([textField isEqual:_passwordcheck]){
        passwordchecklength = textField.text.length - range.length + string.length;
    }
    
    if (telphonelength > 0 && checklength > 0 && passwordlength > 0 && passwordchecklength > 0) {
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
