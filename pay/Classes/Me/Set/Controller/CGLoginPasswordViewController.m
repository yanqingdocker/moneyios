//
//  CGLoginPasswordViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/4.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGLoginPasswordViewController.h"

@interface CGLoginPasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITextField *_oldPassword;
    UITextField *_newPassword;
    UITextField *_checkNewPassword;
    UIButton *_submitBtn;
}
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CGLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)initNav{
    self.navigationItem.title = @"修改登录密码";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,132);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake(20, 0+ 15+122+44, SCREEN_WIDTH-20*2, 44);
    [_submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGLoginPasswordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        _oldPassword = [[UITextField alloc] initWithFrame:CGRectMake(17, 14, SCREEN_WIDTH - 17*2, 16)];
        _oldPassword.placeholder = @"原密码";
        _oldPassword.secureTextEntry = YES;
        _oldPassword.font = [UIFont systemFontOfSize:16];
//        _oldPassword.borderStyle = UIKeyboardTypeNumberPad;
        [cell addSubview:_oldPassword];
    }
    if(indexPath.row == 1){
        _newPassword = [[UITextField alloc] initWithFrame:CGRectMake(17, 14, SCREEN_WIDTH - 17*2, 16)];
        _newPassword.placeholder = @"请输入新密码";
        _newPassword.secureTextEntry = YES;
//        _newPassword.borderStyle = UIKeyboardTypeNumberPad;
        _newPassword.font = [UIFont systemFontOfSize:16];
        [cell addSubview:_newPassword];
    }
    if(indexPath.row == 2){
        _checkNewPassword = [[UITextField alloc] initWithFrame:CGRectMake(17, 14, SCREEN_WIDTH - 17*2, 16)];
        _checkNewPassword.placeholder = @"确认新密码";
        _checkNewPassword.secureTextEntry = YES;
        _checkNewPassword.font = [UIFont systemFontOfSize:16];
        _checkNewPassword.secureTextEntry = YES;
        [cell addSubview:_checkNewPassword];
    }
    return cell;
}

-(void)submitClick{
    [self.view endEditing:YES];
    
    if (_oldPassword.text.length == 0) {
        [MBProgressHUD showText:@"请输入原密码" toView:self.view];
        return;
    }
    if (_newPassword.text.length == 0) {
        [MBProgressHUD showText:@"请输入新密码" toView:self.view];
        return;
    }
    if(_checkNewPassword.text.length == 0){
        [MBProgressHUD showText:@"请确认新密码" toView:self.view];
        return;
    }
    
    if(![_newPassword.text isEqualToString:_checkNewPassword.text]){
        [MBProgressHUD showText:@"两次密码不一致,请重新输入" toView:self.view];
        return;
    }
    
    //    _submitBtn.enabled = NO;
    
    [[CGAFHttpRequest shareRequest] resetpwdmodeWitholdpassword:_oldPassword.text newpassword:_checkNewPassword.text serverSuccessFn:^(id dict) {
        if(dict){
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
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



@end
