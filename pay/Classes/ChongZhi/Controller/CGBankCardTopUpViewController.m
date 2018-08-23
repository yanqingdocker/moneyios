//
//  CGBankCardTopUpViewController.m
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBankCardTopUpViewController.h"
#import "CGSelectAccountTableViewCell.h"
#import "CGTitleAndTextTableViewCell.h"

@interface CGBankCardTopUpViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *_tableView;
    UIButton *_submitBtn;
    
    NSString *_amount;
    NSString *_password;
}


@end

@implementation CGBankCardTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

- (void)initNav{
    self.navigationItem.title = @"银行卡充值";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 0 + 15, SCREEN_WIDTH,361);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _submitBtn = [[UIButton alloc] init];
    _submitBtn.frame = CGRectMake(18, 0 + 15 + 216, SCREEN_WIDTH-18*2, 44);
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_submitBtn];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        if(indexPath.row == 0){
            CGSelectAccountTableViewCell *cell = [CGSelectAccountTableViewCell cellForTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = [NSString stringWithFormat:@"请选择充值账户"];
            cell.accountLab.text = @"1258424(人民币)";
            return cell;
        }
    CGTitleAndTextTableViewCell *cell = [CGTitleAndTextTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 1){
            
            cell.titleLab.text = [NSString stringWithFormat:@"充值金额"];
            cell.contentText.placeholder = @"请输入充值金额";
            cell.contentText.borderStyle = UIKeyboardTypeNumberPad;
            cell.contentText.delegate = self;
            cell.contentText.tag = 1001;
        }
        if(indexPath.row == 2){
//            CGTitleAndTextTableViewCell *cell = [CGTitleAndTextTableViewCell cellForTableView:tableView];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = [NSString stringWithFormat:@"资金密码"];
            cell.contentText.placeholder = @"请输入资金密码";
            cell.contentText.secureTextEntry = YES;
            cell.contentText.delegate = self;
            cell.contentText.tag = 1002;
        }
    
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 1001){
        _amount = textField.text;
    }
    if(textField.tag == 1002){
        _password = textField.text;
    }
}

-(void)submitClick{
    [self.view endEditing:YES];
//    _submitBtn.enabled = NO;
    
    if (_amount.length == 0) {
        [MBProgressHUD showText:@"请输入充值金额" toView:self.view];
        return;
    }
    if(_password.length == 0){
        [MBProgressHUD showText:@"请输入资金密码" toView:self.view];
        return;
    }
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            //            self.model=[ComDeAllocationModel mj_objectWithKeyValues:dict];
            //            UserModel *usermodel = [UserModel objectWithKeyValues:result];
            //            usermodel.login = YES;
            
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    

    [[CGAFHttpRequest shareRequest] rechargeWithtradeMoney:_amount payType:@"CNY" countId:@"688485602369"  serverSuccessFn:^(id dict) {
        if(dict){
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            //            self.model=[ComDeAllocationModel mj_objectWithKeyValues:dict];
//            UserModel *usermodel = [UserModel objectWithKeyValues:result];
//            usermodel.login = YES;
            
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}
@end
