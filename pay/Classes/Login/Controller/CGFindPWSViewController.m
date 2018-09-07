//
//  CGFindPWSViewController.m
//  pay
//
//  Created by v2 on 2018/8/10.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGFindPWSViewController.h"
#import "CGResetpPSWViewController.h"
#import "LMJDropdownMenu.h"

@interface CGFindPWSViewController ()<UITextFieldDelegate,LMJDropdownMenuDelegate>{
    UITextField *_telphone;
    UITextField *_check;
    LMJDropdownMenu *dropdownMenu;
    UIButton * loginBtn;
    NSUInteger telphonelength;
    NSUInteger checklength;

}
@property (strong, nonatomic) UIButton *getCheckBtn;
@end

@implementation CGFindPWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    telphonelength = 0;
    checklength = 0;
}

-(void)initNav{
    self.navigationItem.title = @"找回密码";
    [self setBackButton:YES];
}

- (void) initUI{
    
    UIImageView * bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = CGRectMake(0 , -NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [bgImageView setImage:[UIImage imageNamed:@"bgLoginImg"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    UIView *bgView = [[UIView alloc] init];
//    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgView];
    
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.frame = CGRectMake(40 , 169, 18, 18);
    phoneIcon.image = [UIImage imageNamed:@"phoneIcon"];
    [bgView addSubview:phoneIcon];
    
    dropdownMenu = [[LMJDropdownMenu alloc] init];
    [dropdownMenu setFrame:CGRectMake(52, 171, 110, 13)];
    [dropdownMenu setMenuTitles:countries rowHeight:30];
    dropdownMenu.delegate = self;
    [dropdownMenu.mainBtn setTitle:@"选择国家" forState:UIControlStateNormal];
    [dropdownMenu.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dropdownMenu.mainBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [bgView addSubview:dropdownMenu];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.frame = CGRectMake(40, 196, SCREEN_WIDTH - 40*2, 3);
    line1.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line1];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor]; // 设置颜色
    NSAttributedString *accountplace = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:attrs]; // 初始化富文本占位字符串
    
    NSAttributedString *checkplace = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:attrs]; // 初始化富文本占位字符串
    
    _telphone = [[UITextField alloc] init];
    _telphone.frame = CGRectMake(145, 156, SCREEN_WIDTH - 145 - 15 - 17 -5, 44);
    _telphone.textColor = [UIColor whiteColor];
    _telphone.attributedPlaceholder = accountplace;
    _telphone.clearButtonMode = UITextFieldViewModeAlways;
    _telphone.delegate = self;
    _telphone.font = [UIFont systemFontOfSize:14];
    _telphone.keyboardType = UIKeyboardTypeNumberPad;
    _telphone.borderStyle = UITextBorderStyleNone;
    [bgView addSubview:_telphone];
    
    UIImageView *checkIcon = [[UIImageView alloc] init];
    checkIcon.frame = CGRectMake(40 , 237, 18, 18);
    checkIcon.image = [UIImage imageNamed:@"checkIcon"];
    [bgView addSubview:checkIcon];
    
    _check = [[UITextField alloc] init];
    _check.frame = CGRectMake(64, 224, 130, 44);
    _check.textColor = [UIColor whiteColor];
    _check.attributedPlaceholder = checkplace;
//    _check.clearButtonMode = UITextFieldViewModeAlways;
    _check.delegate = self;
    _check.font = [UIFont systemFontOfSize:14];
    _check.borderStyle = UITextBorderStyleNone;
    _check.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:_check];
    
    UILabel *shuline = [[UILabel alloc] init];
    shuline.frame = CGRectMake(SCREEN_WIDTH - 13 -110 -35, 239, 1, 13);
    shuline.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:shuline];
    
    _getCheckBtn = [[UIButton alloc] init];
    _getCheckBtn.frame = CGRectMake(SCREEN_WIDTH - 110 -35, 239, 110, 14);
    [_getCheckBtn setTitleColor:RGBCOLOR(216,40,40) forState:UIControlStateNormal];
    [_getCheckBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCheckBtn addTarget:self action:@selector(getCheckClick) forControlEvents:UIControlEventTouchUpInside];
    _getCheckBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [bgView addSubview:_getCheckBtn];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.frame = CGRectMake(40, 265, SCREEN_WIDTH - 40*2, 3);
    line2.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:line2];
    
    //下一步按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30, 317, SCREEN_WIDTH - 80, 44);
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = RGBCOLOR(204,38,38);
    loginBtn.layer.cornerRadius = 10.0;
    loginBtn.alpha = 0.6;
    loginBtn.userInteractionEnabled = NO;
    [loginBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
}

- (void)getCheckClick{
    [[CGAFHttpRequest shareRequest] checkPhoneWithtelphone:_telphone.text
                                           serverSuccessFn:^(id dict)
     {
         NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
         if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
             [MBProgressHUD showText:@"请输入正确的手机" toView:self.view];
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
    [[CGAFHttpRequest shareRequest] findpswWithtelphone:_telphone.text checknum:_check.text serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
            }else{
                loginBtn.enabled = NO;
                CGResetpPSWViewController *vc = [[CGResetpPSWViewController alloc] init];
                vc.telphone = _telphone.text;
                [self pushViewControllerHiddenTabBar:vc animated:YES];
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
    }
    
    if (telphonelength > 0 && checklength > 0 ) {
        loginBtn.userInteractionEnabled = YES;
        loginBtn.alpha = 1;
        //        loginBtn.backgroundColor = RGBCOLOR(204, 38, 38);
    } else {
        loginBtn.userInteractionEnabled = NO;
        loginBtn.alpha = 0.6;
        //        loginBtn.backgroundColor = RGBCOLOR(226, 81, 74);
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
