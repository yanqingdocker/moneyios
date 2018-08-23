//
//  CGZhuanZhangViewController.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhuanZhangViewController.h"
#import "CGZhuanZhangConfirmViewController.h"
#import "CGSelectAccountTableViewCell.h"
#import "CGTitleAndTextTableViewCell.h"
#import "CGBounceView.h"

@interface CGZhuanZhangViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
//    UITextField *_alipayAccount;
//    UITableView *_tableView;
    UIButton *_submitBtn;
//    NSString *_account;
    NSString *_phone;
    NSString *_amount;
    NSString *_password;
    CGBounceView *_accountBV;
    NSMutableArray *_result;
    
    NSMutableArray *array;
}
@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *accountID;
@end

@implementation CGZhuanZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
//    [self.view addGestureRecognizer:singleTap];
    
    [self requestForm];
}

- (void)requestForm{
    
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            
            _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
//            _nameArray = [NSArray arrayWithObjects:@"USD",@"CNY",nil];
//            NSArray *_nameArray = [[NSArray alloc] init];
            _array  = [[NSMutableArray alloc] init];
            for (int i = 0; i < _result.count; i++) {
                [_array addObject:[NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:i] objectForKey:@"cardId"],[[_result objectAtIndex:i] objectForKey:@"countType"]]];
            }
            _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
            [_tableView reloadData];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];

    
}

//-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
//{
////    [self.view endEditing:YES];
//}

- (void)initNav{
    self.navigationItem.title = @"转账";
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
    _submitBtn.frame = CGRectMake(18, 0 + 15 + 259, SCREEN_WIDTH-18*2, 44);
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_submitBtn];
    
    //-------原界面--------
//    UIView *bgView = [[UIView alloc] init];
//    bgView.frame = CGRectMake(0, 0 + 10, SCREEN_WIDTH, 40);
//    bgView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:bgView];
//
//    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.frame = CGRectMake(15, 12, 120, 16);
//    titleLab.font = [UIFont systemFontOfSize:18];
//    titleLab.text = @"对方账户";
//    [bgView addSubview:titleLab];
//
//    _alipayAccount = [[UITextField alloc] init];
//    _alipayAccount.frame = CGRectMake(144, 12, SCREEN_WIDTH - 144 -35, 16);
//    _alipayAccount.font = [UIFont systemFontOfSize:18];
//    _alipayAccount.placeholder = @"支付宝账户";
//    _alipayAccount.delegate = self;
//    [bgView addSubview:_alipayAccount];
//
//    UIButton *accountBtn = [[UIButton alloc] init];
//    accountBtn.frame = CGRectMake(SCREEN_WIDTH - 12 -18, 11, 18, 18);
//    [accountBtn setImage:[UIImage imageNamed:@"accountIcon"] forState:UIControlStateNormal];
//    [accountBtn addTarget:self action:@selector(selectAccount) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:accountBtn];
//
//    UILabel *tipsLab = [[UILabel alloc] init];
//    tipsLab.frame = CGRectMake(16, 0 + 61, 200, 13);
//    tipsLab.font = [UIFont systemFontOfSize:13];
//    tipsLab.text = @"钱将实时转入对方账户，无法退款";
//    tipsLab.textColor = RGBCOLOR(154, 152, 152);
//    [self.view addSubview:tipsLab];
//
//    UIButton *nextBtn = [[UIButton alloc] init];
//    nextBtn.frame = CGRectMake(24, 0 + 99, SCREEN_WIDTH - 24*2, 36);
//    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    nextBtn.backgroundColor = RGBCOLOR(247,195,109);
//    [nextBtn addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nextBtn];
    //-------原界面--------
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        CGSelectAccountTableViewCell *cell = [CGSelectAccountTableViewCell cellForTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLab.text = [NSString stringWithFormat:@"请选择支出账户"];
        cell.accountLab.text = _account;
        return cell;
    }
    CGTitleAndTextTableViewCell *cell = [CGTitleAndTextTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 1){
        
        cell.titleLab.text = [NSString stringWithFormat:@"转入账户手机号"];
        cell.contentText.placeholder = @"请输入账户手机号（仅限本平台会员手机）";
        cell.contentText.borderStyle = UIKeyboardTypeNumberPad;
        cell.contentText.delegate = self;
        cell.contentText.tag = 1001;
    }
    if(indexPath.row == 2){
        cell.titleLab.text = [NSString stringWithFormat:@"充值金额"];
        cell.contentText.placeholder = @"请输入充值金额";
        cell.contentText.borderStyle = UIKeyboardTypeNumberPad;
        cell.contentText.delegate = self;
        cell.contentText.tag = 1002;
    }
    if(indexPath.row == 3){
        
        cell.titleLab.text = [NSString stringWithFormat:@"支付密码"];
        cell.contentText.placeholder = @"请输入资金密码";
        cell.contentText.secureTextEntry = YES;
        cell.contentText.delegate = self;
        cell.contentText.tag = 1003;
    }
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 1001){
        _phone = textField.text;
    }
    if(textField.tag == 1002){
        _amount = textField.text;
    }
    if(textField.tag == 1003){
        _password = textField.text;
    }
}

-(void)submitClick{
    [self.view endEditing:YES];

    if (_phone.length == 0) {
        [MBProgressHUD showText:@"请输入手机号" toView:self.view];
        return;
    }
    if (_amount.length == 0) {
        [MBProgressHUD showText:@"请输入充值金额" toView:self.view];
        return;
    }
    if(_password.length == 0){
        [MBProgressHUD showText:@"请输入资金密码" toView:self.view];
        return;
    }
    _submitBtn.enabled = NO;
    
    
    
    
    
    [[CGAFHttpRequest shareRequest] switchWithcountid:_accountID receivecount:_phone moneynum:_amount payPwd:_password serverSuccessFn:^(id dict) {
        if(dict){
            _submitBtn.enabled = YES;
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
                return;
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"转账成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertController addAction:skipAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    } serverFailureFn:^(NSError *error) {
        _submitBtn.enabled = YES;
        if(error){
//            NSLog(@"%@",error);
        }
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        [self selectbankcard];
        
    }
}


- (void)selectbankcard{
    _accountBV = [[CGBounceView alloc]init];
    _accountBV.tuanModel = array;
    [_accountBV showInView:self.view];
    __block CGZhuanZhangViewController *  blockSelf = self;
    _accountBV.selectbankcardblock = ^(NSString *str){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        for(int i = 0; i < array.count ;i++){
            if([blockSelf.array[i] isEqualToString:str]){
                _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"id"]];
            }
        }
        
        blockSelf.account = str;
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
}

- (void)nextEvent{
//    CGZhuanZhangConfirmViewController *vc = [[CGZhuanZhangConfirmViewController alloc] init];
//    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

@end
