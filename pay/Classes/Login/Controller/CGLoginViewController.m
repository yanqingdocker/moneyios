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

@interface CGLoginViewController ()<UITextFieldDelegate>
{
    //账号
    UITextField * _account;
    
    //密码
    UITextField * _password;
    
    UIView * _bgView;
    UITapGestureRecognizer *_tapGesture;
}

@end

@implementation CGLoginViewController

- (void)dealloc
{
    _account = nil;
    _password = nil;
    _bgView = nil;
    _tapGesture = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initUI];
//    CGTabBarController *vc = [[CGTabBarController alloc] init];
//    getAppWindow().rootViewController = vc;
}

- (void)initNav {
//    self.title = @"登录";
}

- (void)initUI {
    UIImageView * bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = self.view.bounds;
//    NSString * imagePath = [[NSBundle mainBundle]pathForResource:@"bgLoginImg.png" ofType:nil];
//    [bgImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    [bgImageView setImage:[UIImage imageNamed:@"bgLoginImg"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    _bgView = [[UIView alloc] init];
    //    _bgView.backgroundColor = [UIColor lightGrayColor];
    //    _bgView.alpha = 0.4;
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    _bgView.frame = self.view.bounds;
    [bgImageView addSubview:_bgView];
    
    UIImageView * logoView = [[UIImageView alloc] init];
    logoView.frame = CGRectMake(120, 62, 128, 72);
//    NSString *logoImagePath = [[NSBundle mainBundle]pathForResource:@"logo.png" ofType:nil];
//    [logoView setImage:[UIImage imageWithContentsOfFile:logoImagePath]];
    [logoView  setImage:[UIImage imageNamed:@"logo"]];
    logoView.contentMode = UIViewContentModeScaleAspectFit;
    [_bgView addSubview:logoView];
    [self viewToCenterXWithView:logoView];
    
//    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(62);
//        make.left.mas_equalTo(120);
//        make.right.mas_equalTo(-120);
//        make.height.mas_equalTo(72);
//    }];
    
//    make.top.mas_equalTo(StatusBarAndNavigationBarHeight);
//    make.left.mas_equalTo(self.view.mas_left);
//    make.right.mas_equalTo(self.view.mas_right);
//    make.bottom.mas_equalTo(self.view.mas_bottom);
    
//    UIView * textView = [[UIView alloc] init];
//    textView.frame = CGRectMake(22, 275, 282, 90);
//    textView.layer.cornerRadius = 5;
//    textView.layer.borderWidth = 1;
//    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    textView.clipsToBounds = YES;
//    textView.backgroundColor = [UIColor whiteColor];
//    [_bgView addSubview:textView];
//    [self viewToCenterXWithView:textView];
    
    UILabel *countriesLabel = [[UILabel alloc] init];
    countriesLabel.frame = CGRectMake(15, 260, 80, 44);
    countriesLabel.text = @"国家/地区";
    countriesLabel.textColor = [UIColor whiteColor];
    
    UIImageView *countriesImage = [[UIImageView alloc] init];
    countriesImage.frame = CGRectMake(SCREEN_WIDTH - 20 -15, 272, 20, 20);
    [countriesImage setImage:[UIImage imageNamed:@"right"]];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.frame = CGRectMake(15, 312, SCREEN_WIDTH-30, 1);
    line1.backgroundColor = RGB(255, 255, 255, 0.6);
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.frame = CGRectMake(15, 324, 80, 44);
    accountLabel.text = @"手机号";
    accountLabel.textColor = [UIColor whiteColor];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.frame = CGRectMake(15, 376, SCREEN_WIDTH-30, 1);
    line2.backgroundColor = RGB(255, 255, 255, 0.6);
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(15, 388, 80, 44);
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [UIColor whiteColor];
    
    UIButton *passwordBtn = [[UIButton alloc] init];
    passwordBtn.frame = CGRectMake(SCREEN_WIDTH - 20 -15, 400, 20, 20);
    
    UILabel *line3 = [[UILabel alloc] init];
    line3.frame = CGRectMake(15, 440, SCREEN_WIDTH-30, 1);
    line3.backgroundColor = RGB(255, 255, 255, 0.6);
    
//    [countriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo();
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(44);
//    }];
    
    [_bgView addSubview:countriesLabel];
    [_bgView addSubview:countriesImage];
    [_bgView addSubview:line1];
    [_bgView addSubview:accountLabel];
    [_bgView addSubview:line2];
    [_bgView addSubview:passwordLabel];
    [_bgView addSubview:line3];
    
    UIButton *countries = [[UIButton alloc] init];
    countries.frame = CGRectMake(160, 260, 110, 44);
    [countries setTitle:@"中国（+86）" forState:UIControlStateNormal];
    [_bgView addSubview:countries];
    
    
    
    _account = [[UITextField alloc] init];
    _account.frame = CGRectMake(100, 324, 170, 44);
    _account.textColor = [UIColor whiteColor];
    _account.placeholder = @"请输入手机号";
    _account.clearButtonMode = UITextFieldViewModeNever;
    _account.delegate = self;
    _account.font = [UIFont systemFontOfSize:14];
    _account.borderStyle = UITextBorderStyleNone;
    [_bgView addSubview:_account];
    
    //密码
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(100, 388, 170, 44);
    _password.font = [UIFont systemFontOfSize:14];
    _password.textColor = [UIColor whiteColor];
    _password.placeholder = @"请输入密码";
    _password.secureTextEntry = YES;
    _password.borderStyle = UITextBorderStyleNone;
    _password.returnKeyType = UIReturnKeyDone;
    _password.delegate = self;
    _password.inputView = [[UIView alloc]init];
    [_bgView addSubview:_password];
    
    //登陆按钮
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(15, 505, SCREEN_WIDTH - 30, 44);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = RGBCOLOR(226, 81, 74);
    loginBtn.layer.cornerRadius = 10.0;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:loginBtn];
    
    
    //忘记密码
    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(25, 564, 80, 20);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [forgetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:forgetBtn];
    
    //注册
    UIButton * registeredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registeredBtn.frame = CGRectMake(SCREEN_WIDTH - 25 - 50, 564, 50, 20);
    [registeredBtn setTitle:@"注册" forState:UIControlStateNormal];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registeredBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:registeredBtn];
    
    [self viewToCenterXWithView:loginBtn];
}

-(void)tapRecognized:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

#pragma mark - view
- (void)viewToCenterXWithView:(UIView *)view {
    CGPoint point = view.center;
    point.x = CGRectGetWidth(_bgView.bounds)*.5f;
    view.center = point;
}

//登陆按钮点击
- (void)loginClick{
    [self.view endEditing:YES];
    
    
    
//    [[CGAFHttpRequest shareRequest] loginWithphone:_account.text password:_password.text serverSuccessFn:^(id dict) {
//        if(dict){
//
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//            CGTabBarController *vc = [[CGTabBarController alloc] init];
//            getAppWindow().rootViewController = vc;
//
//        }
//    } serverFailureFn:^(NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//    }];
//    NSString *cityArr=@"{'username'':'测试','idcard':'350182198911171596','birthday':'11/17','email':'34707098@qq.com','address':'我家'}";
    
    NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"测试",@"username",
                          @"4012",@"idcard",
                          @"Tom",@"birthday",
                          @"测试",@"email",
                          @"4012",@"address",
                          nil];
//    NSArray* cityArr = @[song,@"大连",@"辽宁",@"黑龙江",@"上海",@"江苏",@"宁波",@"杭州",@"浙江",@"厦门",@"福建",@"江西",@"山东",@"青岛",@"湖南",@"湖北",@"河南"];
//    if ([NSJSONSerialization isValidJSONObject:song])
//    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:song options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:%@",json);
//    }
    
    [[CGAFHttpRequest shareRequest] authenticationWithdatas:json serverSuccessFn:^(id dict) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",result);

    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
    

}

-(void)resetClick{
//    CGFindPWSViewController *vc = [[CGFindPWSViewController alloc] init];
//    [ self presentViewController:vc animated: YES completion:nil];
    
    [[CGAFHttpRequest shareRequest] loginResetpwdWithtelphone:@"13950357177" password:@"111111" serverSuccessFn:^(id dict) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",result);
        
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
}

-(void)registerClick{
//    CGRegisterViewController *vc = [[CGRegisterViewController alloc] init];
//    [ self presentViewController:vc animated: YES completion:nil];
    [[CGAFHttpRequest shareRequest] queryAllWithserverSuccessFn:^(id dict) {
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
        NSLog(@"%@",dict);
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textFiel{
    if (textFiel == _account)
    {
        [_password becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    return YES;
}


#pragma mark - view
//- (void)viewToCenterXWithView:(UIView *)view {
//    CGPoint point = view.center;
//    point.x = CGRectGetWidth(_bgView.bounds)*.5f;
//    view.center = point;
//}
#pragma mark--
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    _offset = (textField.superview.top+textField.top+112)-(self.view.height-216.0);//键盘高度216
//    if (_offset>0)
//    {
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//            _bgView.frame = CGRectMake(0, _bgView.top-_offset, _bgView.width, _bgView.height);
//        } completion:nil];
//    }
//    if (textField == _password)
//    {
//        if (!keyboard) {
//            [self showSecureKeyboardAction];
//        }
//    }
//    else
//    {
//        [self hiddenKeyboardView];
//    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (_offset>0)
//    {
//        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//            _bgView.frame = CGRectMake(0, _bgView.top+_offset, _bgView.width, _bgView.height);
//        } completion:nil];
//    }
//    if (textField == _password)
//    {
//        [self hiddenKeyboardView];
//    }
}

@end
