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
}

@end

@implementation CGResetpPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initNav{
    // 在主线程异步加载，使下面的方法最后执行，防止其他的控件挡住了导航栏
    dispatch_async(dispatch_get_main_queue(), ^{
        // 隐藏系统导航栏
        self.navigationController.navigationBar.hidden = YES;
        // 创建假的导航栏
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
        [self.view addSubview:navView];
        // 创建导航栏的titleLabel
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0,44)];
        titleLabel.text = @"找回密码";
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - titleLabel.frame.size.width / 2, 0, titleLabel.frame.size.width, 44);
        [navView addSubview:titleLabel];
        // 创建导航栏左按钮
        UIButton *left= [UIButton buttonWithType:UIButtonTypeSystem];
        [left setImage:[UIImage imageNamed:@"cancel-left"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:left];
        left.frame = CGRectMake(10, 10, 20, 20);
    });
}

- (void) goBack{
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (void) initUI{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgView];
    
//    _telphone = [[UITextField alloc] init];
//    _telphone.frame = CGRectMake(100, 208, 170, 44);
//    _telphone.placeholder = @"请输入手机号";
//    _telphone.clearButtonMode = UITextFieldViewModeNever;
//    _telphone.delegate = self;
//    _telphone.font = [UIFont systemFontOfSize:14];
//    _telphone.borderStyle = UITextBorderStyleNone;
//    [bgView addSubview:_telphone];
    
//    UIButton *getCheckBtn = [[UIButton alloc] init];
//    getCheckBtn.frame = CGRectMake(280, 268, 90, 44);
//    [getCheckBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [getCheckBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [getCheckBtn addTarget:self action:@selector(getCheckClick) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:getCheckBtn];
    
    //密码
    _password = [[UITextField alloc] init];
    _password.frame = CGRectMake(100, 328, 170, 44);
    _password.font = [UIFont systemFontOfSize:14];
    _password.placeholder = @"请输入您的密码";
    _password.secureTextEntry = YES;
    _password.borderStyle = UITextBorderStyleNone;
    _password.returnKeyType = UIReturnKeyDone;
    _password.delegate = self;
    _password.inputView = [[UIView alloc]init];
    [bgView addSubview:_password];
    
    //明暗文按钮
    UIButton *eyeIcon = [[UIButton alloc] init];
    eyeIcon.frame = CGRectMake(SCREEN_WIDTH - 40, 405, 15, 15);
    [eyeIcon setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:eyeIcon];
    
    //确认密码
    _passwordcheck = [[UITextField alloc] init];
    _passwordcheck.frame = CGRectMake(100, 388, 170, 44);
    _passwordcheck.font = [UIFont systemFontOfSize:14];
    _passwordcheck.placeholder = @"请再次输入您的密码";
    _passwordcheck.secureTextEntry = YES;
    _passwordcheck.borderStyle = UITextBorderStyleNone;
    _passwordcheck.returnKeyType = UIReturnKeyDone;
    _passwordcheck.delegate = self;
    _passwordcheck.inputView = [[UIView alloc]init];
    [bgView addSubview:_passwordcheck];
    
    //明暗文按钮
    UIButton *eyeIcon2 = [[UIButton alloc] init];
    eyeIcon2.frame = CGRectMake(SCREEN_WIDTH - 40, 405, 15, 15);
    [eyeIcon2 setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [eyeIcon2 setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
    eyeIcon2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [eyeIcon2 addTarget:self action:@selector(eyeEvent2:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:eyeIcon2];
    
    //重置密码按钮
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(15, 505, SCREEN_WIDTH - 30, 44);
    [loginBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = RGBCOLOR(226, 81, 74);
    loginBtn.layer.cornerRadius = 10.0;
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
    [[CGAFHttpRequest shareRequest] checkPhoneWithtelphone:_telphone
                                           serverSuccessFn:^(id dict)
     {
         if(dict){
             NSLog(@"%@",dict);
         }
     }serverFailureFn:^(NSError *error){
         if(error){
             NSLog(@"%@",error);
         }
     }];
}

- (void)nextClick{
    [[CGAFHttpRequest shareRequest] resetpwdWithtelphone:self.telphone password:_password.text serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
//            CGLoginViewController *vc = [[CGLoginViewController alloc] init];
//            [ self presentViewController:vc animated: YES completion:nil];
            UIViewController *vc = self.presentingViewController;
            
            while (vc.presentingViewController) {
                
                vc = vc.presentingViewController;
                
            }
            
            [vc dismissViewControllerAnimated:YES completion:NULL];
            
        
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}
@end
