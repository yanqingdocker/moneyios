//
//  CGDaiJiaoViewController.m
//  pay
//
//  Created by v2 on 2018/8/22.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGDaiJiaoViewController.h"

@interface CGDaiJiaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITextField *_amount;
    UITextField *_num;
    UITextField *_password;
    UIButton *_submitBtn;
}
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CGDaiJiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
//    self.navigationItem.title = _navtitle;
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
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
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
    static NSString *ID = @"CGDaiJiaoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        _amount = [[UITextField alloc] initWithFrame:CGRectMake(17, 14, SCREEN_WIDTH - 17*2, 16)];
        _amount.placeholder = @"充值金额";
        _amount.font = [UIFont systemFontOfSize:16];
        _amount.borderStyle = UIKeyboardTypeNumberPad;
        [cell addSubview:_amount];
    }
    if(indexPath.row == 1){
        _num = [[UITextField alloc] initWithFrame:CGRectMake(17, 14, SCREEN_WIDTH - 17*2, 16)];
        if([self.title isEqualToString:@"水费代缴"]){
            _num.placeholder = @"水费单号";
        }
        if([self.title isEqualToString:@"电费代缴"]){
            _num.placeholder = @"电费单号";
        }
        _num.borderStyle = UIKeyboardTypeNumberPad;
        _num.font = [UIFont systemFontOfSize:16];
        [cell addSubview:_num];
    }
    if(indexPath.row == 2){
        _password = [[UITextField alloc] initWithFrame:CGRectMake(17, 14, SCREEN_WIDTH - 17*2, 16)];
        _password.placeholder = @"密码";
        _password.font = [UIFont systemFontOfSize:16];
        _password.secureTextEntry = YES;
        [cell addSubview:_password];
    }
    return cell;
}

-(void)submitClick{
    [self.view endEditing:YES];
    
    if (_amount.text.length == 0) {
        [MBProgressHUD showText:@"请输入充值金额" toView:self.view];
        return;
    }
    if (_num.text.length == 0) {
        [MBProgressHUD showText:@"请输入单号" toView:self.view];
        return;
    }
    if(_password.text.length == 0){
        [MBProgressHUD showText:@"请输入密码" toView:self.view];
        return;
    }

//    _submitBtn.enabled = NO;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"充值成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertController addAction:skipAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
