//
//  CGCreatAccountViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGCreatAccountViewController.h"
#import "CGBounceView.h"

@interface CGCreatAccountViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITextField *_amount;
    //    UITextField *_num;
    //    UITextField *_password;
    UIButton *_submitBtn;
    //    NSMutableArray * _dataArray;
    CGBounceView *_accountBV;
    NSArray * allkeys;
    
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString *amountType;
@property (strong, nonatomic) NSString *countType;


@end

@implementation CGCreatAccountViewController

- (void)viewDidLoad {
    _dataArray = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] queryMoneyTypeWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    
                    NSLog(@"%@",result);
                    
                    allkeys = [result allKeys];
                    NSLog(@"allkeys %@",allkeys);

                    for (int i = 0; i < allkeys.count; i++)
                    {
                        NSString * key = [allkeys objectAtIndex:i];

                        //如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
                        id obj  = [result objectForKey:key];
                        NSLog(@"obj %@",obj);
                        [_dataArray addObject:[NSString stringWithFormat:@"%@(%@)",obj,key]];
                    }
                    _countType =  allkeys[0];
                    _amountType = _dataArray[0];
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

                    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    
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
    self.navigationItem.title = @"开通账户";
    [self setBackButton:YES];
}

-(void)initUI{
//    _amountType = @"人民币(CNY)";
    
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,88);
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
    _submitBtn.frame = CGRectMake(20, 0+ 15+122, SCREEN_WIDTH-20*2, 44);
    [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGCreatAccountCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"账户";
        if([_dataArray count] > 0){
            cell.detailTextLabel.text = _amountType;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.row == 1){
        cell.textLabel.text = @"资金密码";
        
        _amount = [[UITextField alloc] initWithFrame:CGRectMake(93, 15, SCREEN_WIDTH - 60 - 17, 16)];
        _amount.placeholder = @"请填写您的资金密码";
        _amount.delegate = self;
        _amount.secureTextEntry = YES;
        _amount.font = [UIFont systemFontOfSize:16];
        _amount.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [cell addSubview:_amount];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0){
        [self selectbankcard];
        
    }
}

- (void)selectbankcard{
    _accountBV = [[CGBounceView alloc]init];
    _accountBV.BVtitle = @"选择账户";
    _accountBV.tuanModel = _dataArray;
    [_accountBV showInView:self.view];
    __block CGCreatAccountViewController *  blockSelf = self;
    _accountBV.selectbankcardblock = ^(NSString *str){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
                for(int i = 0; i < blockSelf.dataArray.count ;i++){
                    if([blockSelf.dataArray[i] isEqualToString:str]){
                        _countType = allkeys[i];
                    }
                }
        
        blockSelf.amountType = str;
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
}

-(void)submitClick{
    [self.view endEditing:YES];
    
    if (_amount.text.length == 0) {
        [MBProgressHUD showText:@"请输入资金密码" toView:self.view];
        return;
    }
    //    _submitBtn.enabled = NO;
//    if([_amountType rangeOfString:@"CNY"].location !=NSNotFound){
//        _selectbankcardblock([NSString stringWithFormat:@"¥%@",_amount.text]);//
//    }
//    if([_amountType rangeOfString:@"USD"].location !=NSNotFound){
//        _selectbankcardblock([NSString stringWithFormat:@"$%@",_amount.text]);//
//    }
//    [self goBack];
    
    
    [[CGAFHttpRequest shareRequest]  createCountWithcountType:_countType payPwd:_amount.text serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
                
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"开通账户成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if([_from isEqualToString:@"noAccount"]){
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                }];
                [alertController addAction:skipAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
}
@end
