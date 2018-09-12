//
//  CGPaymentPasswordViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/4.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGPaymentPasswordViewController.h"
#import "XLPasswordView.h"

@interface CGPaymentPasswordViewController ()<UITableViewDataSource,UITableViewDelegate,XLPasswordViewDelegate>{
    UITableView *_tableView;
    NSArray * allkeys;
    NSMutableArray * _dataArray;
    NSString *_accountID;
}


@end

@implementation CGPaymentPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[CGAFHttpRequest shareRequest] queryMoneyTypeWithserverSuccessFn:^(id dict) {
//                if(dict){
//
//                    NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//
//                    NSLog(@"%@",result);
//
//                    allkeys = [result allKeys];
//                    NSLog(@"allkeys %@",allkeys);
//
//                    [_tableView reloadData];
//
//                }
//            } serverFailureFn:^(NSError *error) {
//                if(error){
//                    NSLog(@"%@",error);
//                }
//            }];
            [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    _dataArray = dict[@"data"];
                    
                    NSLog(@"%@",_dataArray);
                    
                    [_tableView reloadData];
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        });
    });
    
}

- (void)initNav{
    self.navigationItem.title = @"支付密码设置";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 15, SCREEN_WIDTH,88);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
//    return allkeys.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGTiXianCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//        cell.textLabel.text = [NSString stringWithFormat:@"%@密码",allkeys[indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@密码",[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _accountID = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    XLPasswordView *passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    passwordView.titleLabel.text = @"原密码";
    passwordView.tag = 0;
    [passwordView showPasswordInView:self.view];
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
    //    NSLog(@"输入密码位数已满,在这里做一些事情,例如自动校验密码");
    if(passwordView.tag == 0){
        [[CGAFHttpRequest shareRequest] authCountpwdWithid:_accountID payPwd:password serverSuccessFn:^(id dict) {
            if(dict){
//                NSDictionary *result= dict[@"data"];
                if([[dict objectForKey:@"code"] isEqualToString:@"1004"]){
                    [passwordView hidePasswordView];
                    XLPasswordView *passwordView1 = [XLPasswordView passwordView];
                    passwordView1.delegate = self;
                    passwordView1.titleLabel.text = @"修改密码";
                    passwordView1.tag = 1;
                    [passwordView1 showPasswordInView:self.view];
                }else{
                    [passwordView clearPassword];
                }
            }
        } serverFailureFn:^(NSError *error) {
            if(error){
                NSLog(@"%@",error);
            }
        }];
    }
    if (passwordView.tag == 1) {
        [[CGAFHttpRequest shareRequest] updateCountpwdWithid:_accountID payPwd:password serverSuccessFn:^(id dict) {
            if(dict){
//                NSDictionary *result= dict[@"data"];
                if([[dict objectForKey:@"code"] isEqualToString:@"1004"]){
                    [MBProgressHUD showText:@"修改成功" toView:self.view];
                    [passwordView hidePasswordView];
                }else{
                    [passwordView clearPassword];
                }
            }
        } serverFailureFn:^(NSError *error) {
            if(error){
                NSLog(@"%@",error);
            }
        }];
    }
}

@end
