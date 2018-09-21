//
//  CGLoginViewController.m
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGLoginViewController.h"
#import "CGTabBarController.h"
#import "CGRegisterViewController.h"
#import "CGFindPWSViewController.h"
#import "CGHomeViewController.h"
#import "LMJDropdownMenu.h"
#import "XGPush.h"

@interface CGLoginViewController ()<UITextFieldDelegate,LMJDropdownMenuDelegate,XGPushTokenManagerDelegate>
{
    //账号
    UITextField * _telphone;
    
    //密码
    UITextField * _password;
    
    UIView * _bgView;
    UIButton * loginBtn;
    LMJDropdownMenu * dropdownMenu;
    NSUInteger telphonelength ;
    NSUInteger passwordlength ;
    NSString *phone ;
    NSInteger _number;
}

@end

@implementation CGLoginViewController

- (void)dealloc
{
    _telphone = nil;
    _password = nil;
    _bgView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    telphonelength = 0;
    passwordlength = 0;
    
//        _telphone.text = @"13950357177";
//        _password.text = @"111111";
//    _telphone.text = @"09666880019";
//        _password.text = @"123456";
    
//        _telphone.text = @"18193412366";
//        _password.text = @"123456";
    
//        _telphone.text = @"17759513665";
//        _password.text = @"123456";
//    [self loginClick];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self topBar];
}

- (void)initUI {
    UIImageView * bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = self.view.bounds;
    [bgImageView setImage:[UIImage imageNamed:@"bgLoginImg"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    _bgView = [[UIView alloc] init];
    _bgView.frame = self.view.bounds;
    [bgImageView addSubview:_bgView];
    
    UIImageView * logoView = [[UIImageView alloc] init];
    logoView.frame = CGRectMake(140, 97, 128, 72);
//    logoView.frame = CGRectMake(120, 62, 128, 72);
    [logoView  setImage:[UIImage imageNamed:@"logo"]];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    [_bgView addSubview:logoView];
    [self viewToCenterXWithView:logoView];//X轴对称
    
    
//    UILabel *countriesLabel = [[UILabel alloc] init];
//    countriesLabel.frame = CGRectMake(15, 260, 80, 44);
//    countriesLabel.text = @"国家/地区";
//    countriesLabel.textColor = [UIColor whiteColor];
//
//    UIImageView *countriesImage = [[UIImageView alloc] init];
//    countriesImage.frame = CGRectMake(SCREEN_WIDTH - 20 -15, 272, 20, 20);
//    [countriesImage setImage:[UIImage imageNamed:@"right"]];
//
//    UILabel *line1 = [[UILabel alloc] init];
//    line1.frame = CGRectMake(15, 312, SCREEN_WIDTH-30, 1);
//    line1.backgroundColor = RGB(255, 255, 255, 0.6);
//
//    UILabel *accountLabel = [[UILabel alloc] init];
//    accountLabel.frame = CGRectMake(15, 324, 80, 44);
//    accountLabel.text = @"手机号";
//    accountLabel.textColor = [UIColor whiteColor];
//
//    UILabel *line2 = [[UILabel alloc] init];
//    line2.frame = CGRectMake(15, 376, SCREEN_WIDTH-30, 1);
//    line2.backgroundColor = RGB(255, 255, 255, 0.6);
//
//    UILabel *passwordLabel = [[UILabel alloc] init];
//    passwordLabel.frame = CGRectMake(15, 388, 80, 44);
//    passwordLabel.text = @"密码";
//    passwordLabel.textColor = [UIColor whiteColor];
//
//    UILabel *line3 = [[UILabel alloc] init];
//    line3.frame = CGRectMake(15, 440, SCREEN_WIDTH-30, 1);
//    line3.backgroundColor = RGB(255, 255, 255, 0.6);
//    
//    [_bgView addSubview:countriesLabel];
//    [_bgView addSubview:countriesImage];
//    [_bgView addSubview:line1];
//    [_bgView addSubview:accountLabel];
//    [_bgView addSubview:line2];
//    [_bgView addSubview:passwordLabel];
//    [_bgView addSubview:line3];
    
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.frame = CGRectMake(40 , 239, 18, 18);
    phoneIcon.image = [UIImage imageNamed:@"phoneIcon"];
    [_bgView addSubview:phoneIcon];
    
    dropdownMenu = [[LMJDropdownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(52, 241, 110, 13)];
    [dropdownMenu setMenuTitles:countries rowHeight:30];
    dropdownMenu.delegate = self;
    [dropdownMenu.mainBtn setTitle:@"选择国家" forState:UIControlStateNormal];
    [dropdownMenu.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dropdownMenu.mainBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    dropdownMenu.arrowMark.image = [UIImage imageNamed:@"dropdownMenu_cornerIcon_white"];
    [_bgView addSubview:dropdownMenu];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
    NSAttributedString *accountplace = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *passwordplace = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:attrs]; // 初始化富文本占位字符串
    
    _telphone = [[UITextField alloc] init];
    _telphone.frame = CGRectMake(155, 226, SCREEN_WIDTH - 155 - 15 - 17 -5, 44);//242
    _telphone.textColor = [UIColor whiteColor];
    _telphone.attributedPlaceholder = accountplace;
    _telphone.clearButtonMode = UITextFieldViewModeAlways;
    _telphone.delegate = self;
    _telphone.font = [UIFont systemFontOfSize:14];
    _telphone.borderStyle = UITextBorderStyleNone;
    _telphone.keyboardType = UIKeyboardTypeNumberPad;
    [_bgView addSubview:_telphone];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.frame = CGRectMake(40, 266, SCREEN_WIDTH - 40*2, 3);
    line1.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:line1];
    
    UIImageView *pwdIcon = [[UIImageView alloc] init];
    pwdIcon.frame = CGRectMake(40 , 299, 18, 18);
    pwdIcon.image = [UIImage imageNamed:@"pwdIcon"];
    [_bgView addSubview:pwdIcon];
    
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(64, 286, SCREEN_WIDTH - 64 - 43 -18 - 5, 44);//302
    _password.textColor = [UIColor whiteColor];
    _password.attributedPlaceholder = passwordplace;
    _password.clearButtonMode = UITextFieldViewModeAlways;
    _password.delegate = self;
    _password.font = [UIFont systemFontOfSize:14];
    _password.borderStyle = UITextBorderStyleNone;
    _password.autocorrectionType = UITextAutocorrectionTypeNo;
    _password.secureTextEntry = YES;
    [_bgView addSubview:_password];
    
    //明暗文按钮
    UIButton *eyeIcon = [[UIButton alloc] init];
    eyeIcon.frame = CGRectMake(SCREEN_WIDTH - 43 - 18, 300, 18, 18);
    [eyeIcon setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:eyeIcon];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.frame = CGRectMake(40, 326, SCREEN_WIDTH - 40*2, 3);
    line2.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:line2];

    //登陆按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(40, 368, SCREEN_WIDTH - 80, 44);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = RGBCOLOR(204, 38, 38);
    loginBtn.layer.cornerRadius = 10.0;
//    loginBtn.userInteractionEnabled = NO;
    loginBtn.alpha=0.6;//透明度
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:loginBtn];
    
    //忘记密码
    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(40, 427, 80, 20);
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [forgetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:forgetBtn];
    
    //注册
    UIButton * registeredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registeredBtn.frame = CGRectMake(SCREEN_WIDTH - 40 - 50, 427, 50, 20);
    [registeredBtn setTitle:@"注册" forState:UIControlStateNormal];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registeredBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:registeredBtn];
    
    [self viewToCenterXWithView:loginBtn];
}

-(void)eyeEvent:(UIButton *)button {
    button.selected = !button.selected;
    _password.secureTextEntry = !_password.secureTextEntry;
}


- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    _number = number;
    
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [dropdownMenu hideDropDown];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [dropdownMenu hideDropDown];
}

#pragma mark - view
//- (void)viewToCenterXWithView:(UIView *)view {
//    CGPoint point = view.center;
//    point.x = CGRectGetWidth(self.view.bounds)*.5f;
//    view.center = point;
//}

//登陆按钮点击
- (void)loginClick{
    [self.view endEditing:YES];
    
    if (_number != 0) {
        phone = [NSString stringWithFormat:@"%@ %@",areaCode[_number],_telphone.text];
    }else{
        phone = _telphone.text;
    }
    
    [MBProgressHUD showMessage:@"安全登录中"];
    
    [[CGAFHttpRequest shareRequest] loginWithphone:phone password:_password.text serverSuccessFn:^(id dict) {
        [MBProgressHUD hideHUD];
//        if([[dict objectForKey:@"code"] integerValue] == 1004){
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
            if([[dict objectForKey:@"code"] integerValue] == 1004){
                GlobalSingleton *single=[GlobalSingleton Instance];
                
                single.currentUser = [UserModel objectWithKeyValues:dict[@"data"]];
//                NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:[result objectForKey:@"data"] options:kNilOptions error:nil]);
                single.currentUser.login = YES;
                
                
                [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:single.currentUser.userid type:XGPushTokenBindTypeAccount];
                
                
                self.tabBarController.tabBar.hidden=NO;

                CGHomeViewController * vc = [[CGHomeViewController alloc]init];

                [self.navigationController pushViewController:vc animated:NO];

                CGTabBarController *tabbar = [[CGTabBarController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
            }
            else{
                [MBProgressHUD showText:dict[@"message"] toView:self.view];
            }
//        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0];

        
    } serverFailureFn:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if(error){
            NSLog(@"%@",error);
        }
    }];
}
-(void)delayMethod{
    [MBProgressHUD hideHUD];
}

-(void)resetClick{
    CGFindPWSViewController *vc = [[CGFindPWSViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

-(void)registerClick{
    CGRegisterViewController *vc = [[CGRegisterViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

#pragma mark - UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textFiel{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark--
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([textField isEqual:_telphone]){
        telphonelength = textField.text.length - range.length + string.length;
    }else if([textField isEqual:_password]){
        passwordlength = textField.text.length - range.length + string.length;
    }
    
    if (telphonelength > 0 && passwordlength > 0 ) {
        loginBtn.userInteractionEnabled = YES;
        loginBtn.alpha = 1;
    } else {
        loginBtn.userInteractionEnabled = NO;
        loginBtn.alpha = 0.6;
    }
    
    return YES;
}


-(void) updateNotification:(NSString *) str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
