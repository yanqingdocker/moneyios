//
//  CGFindPWSViewController.m
//  pay
//
//  Created by v2 on 2018/8/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGFindPWSViewController.h"
#import "CGLoginViewController.h"
#import "CGResetpPSWViewController.h"

@interface CGFindPWSViewController ()<UITextFieldDelegate>{
    UITextField *_telphone;
    UITextField *_check;
}

@end

@implementation CGFindPWSViewController

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
    bgView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgView];
    
    //    UILabel *pinzhengLab = [[UILabel alloc] init];
    //    pinzhengLab.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _telphone = [[UITextField alloc] init];
    _telphone.frame = CGRectMake(100, 208, 170, 44);
    _telphone.placeholder = @"请输入手机号";
    _telphone.clearButtonMode = UITextFieldViewModeNever;
    _telphone.delegate = self;
    _telphone.font = [UIFont systemFontOfSize:14];
    _telphone.borderStyle = UITextBorderStyleNone;
    [bgView addSubview:_telphone];
    
    _check = [[UITextField alloc] init];
    _check.frame = CGRectMake(100, 268, 170, 44);
    _check.placeholder = @"请输入验证码";
    _check.clearButtonMode = UITextFieldViewModeNever;
    _check.delegate = self;
    _check.font = [UIFont systemFontOfSize:14];
    _check.borderStyle = UITextBorderStyleNone;
    [bgView addSubview:_check];
    
    UIButton *getCheckBtn = [[UIButton alloc] init];
    getCheckBtn.frame = CGRectMake(280, 268, 110, 44);
    [getCheckBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [getCheckBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCheckBtn addTarget:self action:@selector(getCheckClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:getCheckBtn];
    
    //登陆按钮
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(15, 505, SCREEN_WIDTH - 30, 44);
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = RGBCOLOR(226, 81, 74);
    loginBtn.layer.cornerRadius = 10.0;
    [loginBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
}

- (void)getCheckClick{
    [[CGAFHttpRequest shareRequest] checkPhoneWithtelphone:_telphone.text
                                           serverSuccessFn:^(id dict)
     {
         if(dict){
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
             NSLog(@"%@",result);
         }
     }serverFailureFn:^(NSError *error){
         if(error){
             NSLog(@"%@",error);
         }
     }];
}

- (void)nextClick{
    [[CGAFHttpRequest shareRequest] findpswWithtelphone:_telphone.text checknum:_check.text serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            
            CGResetpPSWViewController *vc = [[CGResetpPSWViewController alloc] init];
            vc.telphone = _telphone.text;
            [ self presentViewController:vc animated: YES completion:nil];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
}

@end
