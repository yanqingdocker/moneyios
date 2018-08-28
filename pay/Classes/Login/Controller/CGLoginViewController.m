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
#import "MBProgressHUD.h"
#import "MBProgressHUD+Extension.h"

#import "LMJDropdownMenu.h"

@interface CGLoginViewController ()<UITextFieldDelegate,MBProgressHUDDelegate,LMJDropdownMenuDelegate>
{
    //账号
    UITextField * _account;
    
    //密码
    UITextField * _password;
    
    UIView * _bgView;
    UITapGestureRecognizer *_tapGesture;
    
    UIView *datePickerView;
    UIDatePicker *datePicker;
    UIView *datePickerMenu;
    
    LMJDropdownMenu * dropdownMenu;
    UIView *guojiaView;
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
//    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    _bgView.frame = self.view.bounds;
    
    
//    [_tapGesture setNumberOfTapsRequired:1];
//    _tapGesture.cancelsTouchesInView = NO;
//    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_tapGesture];
    
    
    
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
    
//    UIButton *countries = [[UIButton alloc] init];
//    countries.frame = CGRectMake(160, 260, 110, 44);
//    [countries setTitle:@"中国（+86）" forState:UIControlStateNormal];
//    [_bgView addSubview:countries];
    
    
    guojiaView = [[UIView alloc] init];
    guojiaView.frame = self.view.bounds;
//    [guojiaView addGestureRecognizer:_tapGesture];
    guojiaView.backgroundColor = [UIColor clearColor];
    
    dropdownMenu = [[LMJDropdownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(160, 260, 110, 44)];
    [dropdownMenu setMenuTitles:countries rowHeight:30];
    dropdownMenu.delegate = self;
    [dropdownMenu.mainBtn addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
    [dropdownMenu.mainBtn setTitle:@"中国大陆" forState:UIControlStateNormal];
    [dropdownMenu.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bgView addSubview:dropdownMenu];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
    NSAttributedString *accountplace = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *passwordplace = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:attrs]; // 初始化富文本占位字符串
    
    _account = [[UITextField alloc] init];
    _account.frame = CGRectMake(100, 324, 170, 44);
    _account.textColor = [UIColor whiteColor];
//    _account.placeholder = @"请输入手机号";
    _account.attributedPlaceholder = accountplace;
    _account.clearButtonMode = UITextFieldViewModeNever;
    _account.delegate = self;
    _account.font = [UIFont systemFontOfSize:14];
    _account.borderStyle = UITextBorderStyleNone;
    _account.keyboardType = UIKeyboardTypeNumberPad;
//    _account.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_bgView addSubview:_account];
    
    //密码
//    _password = [[UITextField alloc] init];
//    _password.frame = CGRectMake(100, 388, 170, 44);
//    _password.font = [UIFont systemFontOfSize:14];
//    _password.textColor = [UIColor whiteColor];
////    _password.placeholder = @"请输入密码";
//    _password.attributedPlaceholder = passwordplace;
//    _password.secureTextEntry = YES;
//    _password.borderStyle = UITextBorderStyleNone;
////    _password.keyboardType = UIKeyboardTypeDecimalPad;
//    _password.returnKeyType = UIReturnKeyDone;
//    _password.delegate = self;
////    _password.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _password.inputView = [[UIView alloc]init];
//    [_bgView addSubview:_password];
    
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(100, 388, 170, 44);
    _password.textColor = [UIColor whiteColor];
    //    _account.placeholder = @"请输入手机号";
    _password.attributedPlaceholder = accountplace;
    _password.clearButtonMode = UITextFieldViewModeNever;
    _password.delegate = self;
    _password.font = [UIFont systemFontOfSize:14];
    _password.borderStyle = UITextBorderStyleNone;
    _password.keyboardType = UIKeyboardTypeNamePhonePad;
    _password.secureTextEntry = YES;
    //    _account.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_bgView addSubview:_password];
    
    //明暗文按钮
    UIButton *eyeIcon = [[UIButton alloc] init];
    eyeIcon.frame = CGRectMake(SCREEN_WIDTH - 40, 405, 15, 15);
    [eyeIcon setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:eyeIcon];

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

-(void)eyeEvent:(UIButton *)button {
    button.selected = !button.selected;
    _password.secureTextEntry = !_password.secureTextEntry;
}


- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    
    NSLog(@"你选择了：%@",menu.mainBtn.titleLabel.text);
}
//- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
//    NSLog(@"--已经显示--");
//
//}

- (void)addView{
//    [self.view endEditing:NO];
//    [_bgView addSubview:guojiaView];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [_nameText resignFirstResponder];
    [self.view endEditing:YES];
    [dropdownMenu hideDropDown];
}


//-(void)tapRecognized:(UITapGestureRecognizer *)sender
//{
////        [self.view endEditing:YES];
////    [guojiaView removeFromSuperview];
////    [dropdownMenu hideDropDown];
//
//    if (sender.state == UIGestureRecognizerStateEnded){
//        CGPoint location = [sender locationInView:nil];
//        if (![dropdownMenu pointInside:[dropdownMenu convertPoint:location fromView:dropdownMenu.window] withEvent:nil]){
//            [dropdownMenu.window removeGestureRecognizer:sender];
////            [dropdownMenu dismissWithClickedButtonIndex:0 animated:YES];
//        }
//    }
//
//}

#pragma mark - view
- (void)viewToCenterXWithView:(UIView *)view {
    CGPoint point = view.center;
    point.x = CGRectGetWidth(_bgView.bounds)*.5f;
    view.center = point;
}

//登陆按钮点击
- (void)loginClick{
    [self.view endEditing:YES];
    
//    if (_account.text.length == 0) {
//        [MBProgressHUD showText:@"请输入账号" toView:self.view];
//        return;
//    }
//    if(_password.text.length == 0){
//        [MBProgressHUD showText:@"请输入密码" toView:self.view];
//        return;
//    }
    
//    NSLog(@"你选择了：%@",dropdownMenu.mainBtn.titleLabel.text);
    
//    _account.text = @"13950357177";
//    _password.text = @"123456";

    
//    _account.text = @"18193412366";
//    _password.text = @"123456";
    
    _account.text = @"17759513665";
    _password.text = @"123456";
//    [MBProgressHUD showHUD];
    
    [[CGAFHttpRequest shareRequest] loginWithphone:_account.text password:_password.text serverSuccessFn:^(id dict) {
        if(dict){            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            GlobalSingleton *single=[GlobalSingleton Instance];
            
            single.currentUser = [UserModel objectWithKeyValues:result];
            
            single.currentUser.login = YES;
            CGTabBarController *vc = [[CGTabBarController alloc] init];
            getAppWindow().rootViewController = vc;
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
//            NSLog(@"%@",error);
        }
    }];
}



-(void)resetClick{
    CGFindPWSViewController *vc = [[CGFindPWSViewController alloc] init];
    [ self presentViewController:vc animated: YES completion:nil];
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    
//    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
//    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    self.view.userInteractionEnabled = YES;
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
//    
//    datePickerView = [[UIView alloc] init];
//    datePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    datePickerView.userInteractionEnabled = YES;
//    [datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
//    [self.view addSubview:datePickerView];
//    
//    datePickerMenu = [[UIView alloc] init];
////    datePickerMenu.userInteractionEnabled = NO;
//    datePickerMenu.frame = CGRectMake(0, SCREEN_HEIGHT-216 -44, SCREEN_WIDTH, 44);
//    datePickerMenu.backgroundColor = [UIColor whiteColor];
//    [datePickerView addSubview:datePickerMenu];
//    UIButton *confirmBtn = [[UIButton alloc] init];
//    confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 4, 60, 36);
//    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [confirmBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
//    [datePickerMenu addSubview:confirmBtn];
//    UIButton *cancelBtn = [[UIButton alloc] init];
//    cancelBtn.frame = CGRectMake(4, 4, 60, 36);
//    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
//    [datePickerMenu addSubview:cancelBtn];
//    datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-216,SCREEN_WIDTH,216)];
//    datePicker.backgroundColor = [UIColor whiteColor];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
//    [datePickerView addSubview:datePicker];
}

- (void)confirmEvent {
    
    NSDate *theDate = datePicker.date;
//    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    [self disMissView];
}
- (void)disMissView {
    
    [datePickerMenu setFrame:CGRectMake(0, SCREEN_HEIGHT - 216 -44, SCREEN_WIDTH, 44)];
    [datePicker setFrame:CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         datePickerView.alpha = 0.0;
                         
                         [datePickerMenu setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44)];
                         [datePicker setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216)];
                     }
                     completion:^(BOOL finished){
                         
                         [datePickerView removeFromSuperview];
//                         [datePicker removeFromSuperview];
                     }];
    
}
-(void)registerClick{
    CGRegisterViewController *vc = [[CGRegisterViewController alloc] init];
    [ self presentViewController:vc animated: YES completion:nil];
//    [[CGAFHttpRequest shareRequest] queryAllWithserverSuccessFn:^(id dict) {
////        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//        NSLog(@"%@",dict);
//    } serverFailureFn:^(NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//    }];
}

#pragma mark - UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textFiel{
//    if (textFiel == _account)
//    {
//        [_password becomeFirstResponder];
//    }
//    else
//    {
        [self.view endEditing:YES];
//    }
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
