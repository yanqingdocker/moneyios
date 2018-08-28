//
//  CGSaoMaZhuanZhangViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/25.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGSaoMaZhuanZhangViewController.h"

#import "CGAccountBalanceTableViewCell.h"
#import "CGBounceView.h"
#import "XLPasswordView.h"
#import "CGJiaoYiDetailsViewController.h"
@interface CGSaoMaZhuanZhangViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,XLPasswordViewDelegate>
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
    UIImageView *_headImgView;
    UILabel *_nameLab;
    NSMutableArray *array;
    
    UITextField *amount;
    UITextField *beizhu;
}
@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *accountID;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString *amountType;
@property (assign, nonatomic) dispatch_queue_t prefectcherQueue;


@end

@implementation CGSaoMaZhuanZhangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    [self requestForm];
}
- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
//        [[CGAFHttpRequest shareRequest] queryMoneyTypeWithserverSuccessFn:^(id dict) {
//        if(dict){
//            
//            NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            
//            NSLog(@"%@",result);
//            
//            NSArray * allkeys = [result allKeys];
//            NSLog(@"allkeys %@",allkeys);
//            
//            for (int i = 0; i < allkeys.count; i++)
//            {
//                NSString * key = [allkeys objectAtIndex:i];
//                
//                //如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
//                id obj  = [result objectForKey:key];
//                NSLog(@"obj %@",obj);
//                [_dataArray addObject:[NSString stringWithFormat:@"%@(%@)",obj,key]];
//            }
//            _amountType = _dataArray[0];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//            
//            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        }
//    } serverFailureFn:^(NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//    }];
            
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
//                    [_tableView reloadData];
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        });
    });
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        [[CGAFHttpRequest shareRequest] getuserWithserverSuccessFn:^(id dict) {
//            if(dict){
//                
//                _dataArray = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//                
//                NSData *data=[[NSData alloc] initWithBase64EncodedString:[_dataArray objectForKey:@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
//                _headImgView.image = [UIImage imageWithData:data];
//                
//                _nameLab.text = [NSString stringWithFormat:@"转账给%@",[_dataArray objectForKey:@"username"]];
//                //                    _dataArray = result[6];
////                NSLog(@"%@",_dataArray);
//                
//                //                [_tableView reloadData];
//            }
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
//    });
//    dispatch_queue_t queuelow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//
//    dispatch_async(queuelow, ^{
//        [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
//            if(dict){
//
//                NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//
//                NSLog(@"%@",result);
//
//                //                    NSArray * allkeys = [result allKeys];
//                //                    NSLog(@"allkeys %@",allkeys);
//                //
//                //                    for (int i = 0; i < allkeys.count; i++)
//                //                    {
//                //                        NSString * key = [allkeys objectAtIndex:i];
//                //
//                //                        //如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
//                //                        id obj  = [result objectForKey:key];
//                //                        NSLog(@"obj %@",obj);
//                //                        [_dataArray addObject:[NSString stringWithFormat:@"%@(%@)",obj,key]];
//                //                    }
//                //                    _amountType = _dataArray[0];
//                //                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//
//                //                    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            }
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
//        
//    });
}

- (void)initNav{
    self.navigationItem.title = @"转账";
    [self setBackButton:YES];
}

-(void)initUI{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:bgView];
    
    _headImgView = [[UIImageView alloc] init];
//        NSData *data=[[NSData alloc] initWithBase64EncodedString:[_params objectForKey:@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        _headImgView.image = [UIImage imageWithData:_imgdata];
    
    [self.view addSubview:_headImgView];
    [_headImgView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(_headImgView.mas_width);
    }];
    
    _nameLab = [[UILabel alloc] init];
    _nameLab.text = [NSString stringWithFormat:@"转账给%@",_username];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLab];
    [_nameLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_headImgView.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
    }];
    
    CGRect tableframe=CGRectMake(0, 210, SCREEN_WIDTH,88 + 60);
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
    _submitBtn.frame = CGRectMake(20, 15+122+88+210-60, SCREEN_WIDTH-20*2, 44);
    [_submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return 60;
    }else{
        return 44;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    if (indexPath.row == 0) {
        UILabel *moneyLab = [[UILabel alloc] init];
        moneyLab.frame = CGRectMake(20, 10, 80, 20);
        moneyLab.text = @"转账金额";
        [cell addSubview:moneyLab];
        amount = [[UITextField alloc] init];
        amount.frame = CGRectMake(20, 35, SCREEN_WIDTH - 15*2, 20);
        amount.text = _moneynum;
        amount.delegate = self;
        amount.keyboardType = UIKeyboardTypeDecimalPad;
        [cell addSubview:amount];
//        CGAccountBalanceTableViewCell *cell = [CGAccountBalanceTableViewCell cellForTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.titleLab.text = [NSString stringWithFormat:@"转账金额"];
//        cell.titleLab.textColor = [UIColor blackColor];
//        cell.titleLab.font = [UIFont systemFontOfSize:11];
//        cell.contentText.keyboardType =UIKeyboardTypeDecimalPad;
//        cell.contentText.placeholder = @"0.00";
//        cell.contentText.delegate =self;
        
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"付款账户";
//        if([_dataArray count] > 0){
//            cell.detailTextLabel.text = _amountType;
//
//        }
        cell.detailTextLabel.text = _account;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 2) {
        beizhu = [[UITextField alloc] init];
        beizhu.frame = CGRectMake(20, 14, SCREEN_WIDTH - 15*2, 20);
        beizhu.placeholder = @"添加备注(20字以内)";
        beizhu.delegate =self;
        [cell addSubview:beizhu];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1){
        [self selectbankcard];
        
    }
}

- (void)selectbankcard{
    
    _accountBV = [[CGBounceView alloc]init];
    _accountBV.BVtitle = @"选择账户";
    _accountBV.tuanModel = _array;
    [_accountBV showInView:self.view];
    __block CGSaoMaZhuanZhangViewController *  blockSelf = self;
    _accountBV.selectbankcardblock = ^(NSString *str){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        for(int i = 0; i < blockSelf.array.count ;i++){
            if([blockSelf.array[i] isEqualToString:str]){
                _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"id"]];
            }
        }
        
        _account = str;
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
}

-(void)submitClick{
    
    XLPasswordView *passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.view];
    
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
//    NSLog(@"输入密码位数已满,在这里做一些事情,例如自动校验密码");
    [[CGAFHttpRequest shareRequest] switchWithcountid:_accountID receivecount:_receivecount moneynum:_moneynum payPwd:password serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
                [passwordView clearPassword];
            }
            if([[result objectForKey:@"code"] isEqualToString:@"success"]){
//                [passwordView hidePasswordView];
//                [MBProgressHUD showText:@"转账成功" toView:self.view];
                CGJiaoYiDetailsViewController *vc = [[CGJiaoYiDetailsViewController alloc] init];
                vc.liushuiID = [result objectForKey:@"message"];
                [self pushViewControllerHiddenTabBar:vc animated:YES];
            }
            
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [_nameText resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - UITextField delegate
//-(BOOL)textFieldShouldReturn:(UITextField *)textFiel{
////    if (textFiel == _account)
////    {
////        [_password becomeFirstResponder];
////    }
////    else
////    {
//        [self.view endEditing:YES];
////    }
//    return YES;
//}
@end
