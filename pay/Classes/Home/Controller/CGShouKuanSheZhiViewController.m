//
//  CGShouKuanSheZhiViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/24.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGShouKuanSheZhiViewController.h"
#import "CGBounceView.h"

@interface CGShouKuanSheZhiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    UITextField *_amount;
//    UITextField *_num;
//    UITextField *_password;
    UIButton *_submitBtn;
//    NSMutableArray * _dataArray;
    CGBounceView *_accountBV;
    
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString *amountType;
@property (strong, nonatomic) NSMutableArray *result;
@property (strong, nonatomic) NSString *countType;

@end

@implementation CGShouKuanSheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];

    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    
                    _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    NSLog(@"%@",_result);
                    
                    if([[[_result objectAtIndex:0] objectForKey:@"code"] isEqualToString:@"fail"]){
                        [MBProgressHUD showText:[[_result objectAtIndex:0] objectForKey:@"message"] toView:self.view];
                    }else{
                        
                        _countType = [[_result objectAtIndex:0] objectForKey:@"countType"];
                        //                    _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
                        
                        
                        _dataArray  = [[NSMutableArray alloc] init];
                        for (int i = 0; i < _result.count; i++) {
                            [_dataArray addObject:[NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"countType"]]];
                        }
//                        _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
                        
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                        
                        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

                    }
                    
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
    self.navigationItem.title = @"收款设置";
    [self setBackButton:YES];
}

-(void)initUI{
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
    static NSString *ID = @"CGShouKuanSheZhiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"金额";
        
        _amount = [[UITextField alloc] initWithFrame:CGRectMake(60, 15, SCREEN_WIDTH - 60 - 17, 16)];
        _amount.placeholder = @"请输入收款金额";
        _amount.delegate = self;
        _amount.font = [UIFont systemFontOfSize:16];
        _amount.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [cell addSubview:_amount];
    }
    if(indexPath.row == 1){
        cell.textLabel.text = @"收款账户";
        if([_dataArray count] > 0){
            cell.detailTextLabel.text = _countType;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    _accountBV.tuanModel = _dataArray;
    [_accountBV showInView:self.view];
    __block CGShouKuanSheZhiViewController *  blockSelf = self;
    _accountBV.selectbankcardblock = ^(NSString *str){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
//        for(int i = 0; i < blockSelf.dataArray.count ;i++){
//            if([blockSelf.dataArray[i] isEqualToString:str]){
//                _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"id"]];
//            }
//        }
        
        blockSelf.countType = str;
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
}

-(void)submitClick{
    [self.view endEditing:YES];
    
    if (_amount.text.length == 0) {
        [MBProgressHUD showText:@"请输入收款金额" toView:self.view];
        return;
    }
    //    _submitBtn.enabled = NO;
    if([_countType rangeOfString:@"CNY"].location !=NSNotFound){
        _selectbankcardblock([NSString stringWithFormat:@"¥%@",_amount.text],_countType);//
    }
    if([_countType rangeOfString:@"USD"].location !=NSNotFound){
        _selectbankcardblock([NSString stringWithFormat:@"$%@",_amount.text],_countType);//
    }
    [self goBack];
}

@end
