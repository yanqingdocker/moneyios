//
//  CGWaiBiTiXianConfirmViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/13.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGWaiBiTiXianConfirmViewController.h"
#import "XLPasswordView.h"
#import "CGBankCardTopupTableViewCell.h"

@interface CGWaiBiTiXianConfirmViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,XLPasswordViewDelegate>
//@property (nonatomic , strong) UIImageView *bankcardIcon;
//@property (nonatomic , strong) UILabel *bankcardNum;
//@property (nonatomic , strong) UILabel *bankcardTitle;
@property (nonatomic , strong) UIImageView *moneyTypeIcon;
@property (nonatomic , strong) UITextField *moneyNum;
@property (nonatomic , strong) UILabel *availableBalanceLab;
@property (nonatomic , strong) UITableView *tableView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSString *countType;//提现金额类型
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (strong, nonatomic) NSString *blance;//可用余额
@property (strong, nonatomic) NSString *bankCard;
@property (nonatomic, assign) NSInteger selectLine;//选中行

@end

@implementation CGWaiBiTiXianConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            _dataArray = dict[@"data"];
            NSLog(@"%@",_dataArray);
            _countType = [[_dataArray objectAtIndex:0] objectForKey:@"countType"];
            if([_countType isEqualToString:@"CNY"]){
                _moneyTypeIcon.image = [UIImage imageNamed:@"CNYIcon"];
            }else if([_countType isEqualToString:@"USD"]){
                _moneyTypeIcon.image = [UIImage imageNamed:@"USDIcon"];
            }
            
            _blance = [StringUtil changeFloat:[NSString stringWithFormat:@"%0.4f",[[[_dataArray objectAtIndex:0] objectForKey:@"blance"] floatValue]]];
            _availableBalanceLab.text = [NSString stringWithFormat:@"可用余额:%@",_blance];
            [_tableView reloadData];
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (void)initNav{
    self.navigationItem.title = @"外币提现";
    [self setBackButton:YES];
}

- (void)initUI{
    UIView *cashView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, 163)];
    cashView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cashView];
    
    UILabel *txjeLab = [[UILabel alloc] init];
    txjeLab.frame = CGRectMake(18  , 23, 80, 17);
    txjeLab.font = [UIFont systemFontOfSize:15];
    txjeLab.text = @"提现金额";
    [cashView addSubview:txjeLab];
    
    _moneyTypeIcon = [[UIImageView alloc] init];
    _moneyTypeIcon.frame = CGRectMake(18, 70, 25, 25);
    [cashView addSubview:_moneyTypeIcon];
    
    _moneyNum = [[UITextField alloc] init];
    _moneyNum.frame = CGRectMake(18+25+5 , 58, SCREEN_WIDTH -18*2 - 30, 44);
    _moneyNum.delegate =self;
    _moneyNum.font = [UIFont systemFontOfSize:40];
    _moneyNum.placeholder = [NSString stringWithFormat:@"0.0000"];
    _moneyNum.clearButtonMode = UITextFieldViewModeAlways;
    _moneyNum.keyboardType = UIKeyboardTypeDecimalPad;
    //    [_moneyNum addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [cashView addSubview:_moneyNum];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 104, SCREEN_WIDTH - 15*2, 1)];
    line.backgroundColor = RGBCOLOR(214,217,234);
    [cashView addSubview:line];
    
    _availableBalanceLab = [[UILabel alloc] init];
    _availableBalanceLab.frame = CGRectMake(18  , 113, SCREEN_WIDTH - 18*2 - 60, 15);
    _availableBalanceLab.font = [UIFont systemFontOfSize:12];
    _availableBalanceLab.textColor = RGBCOLOR(102,102,102);
    _availableBalanceLab.text = [NSString stringWithFormat:@"可用余额:%@",@""];
    [cashView addSubview:_availableBalanceLab];
    
    UIButton *allWithdrawBtn = [[UIButton alloc] init];
    allWithdrawBtn.frame = CGRectMake(SCREEN_WIDTH -60 - 23 , 113, 60, 15);
    [allWithdrawBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [allWithdrawBtn addTarget:self action:@selector(allWithdrawClick) forControlEvents:UIControlEventTouchUpInside];
    [allWithdrawBtn setTitleColor:RGBCOLOR(40,111,227) forState:UIControlStateNormal];
    allWithdrawBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    [cashView addSubview:allWithdrawBtn];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.frame = CGRectMake(18  , 136, 250, 14);
    tipsLab.font = [UIFont systemFontOfSize:14];
    tipsLab.text = @"不同币种提现按当日汇率折算";
    tipsLab.textColor = RGBCOLOR(209,11,11);
    [cashView addSubview:tipsLab];
    
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 170 , SCREEN_WIDTH, SCREEN_HEIGHT - 170-NAVIGATIONBAR_HEIGHT)];//
    accountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:accountView];
    
    UILabel *zczhLab = [[UILabel alloc] init];
    zczhLab.frame = CGRectMake(18  , 13, 80, 16);
    zczhLab.font = [UIFont systemFontOfSize:16];
    zczhLab.text = @"支出账户";
    [accountView addSubview:zczhLab];
    
    CGRect tableframe=CGRectMake(0, 32, SCREEN_WIDTH,SCREEN_HEIGHT - 245 -NAVIGATIONBAR_HEIGHT - 32);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [accountView addSubview:_tableView];
    
    [self addFooterView];
}

- (void)addFooterView {
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor clearColor];
        footerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 80.f);
        
        CGFloat sureBtnH = 40;
        CGFloat sureBtnY = 20;
        UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, sureBtnY, self.view.frame.size.width - 40, sureBtnH);
        //        [sureBtn setTitleColor:RGBCOLOR(72,135,239) forState:UIControlStateNormal];
        //        [sureBtn setTitleColor:RGBCOLOR(72,135,239) forState:UIControlStateNormal];
        sureBtn.backgroundColor = RGBCOLOR(72,135,239);
        //        [sureBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
        [sureBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        //        [sureBtn setBackgroundImage:[UIImage imageNamed:@"dottedLine"] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
        [footerView addSubview:sureBtn];
        
        _footerView = footerView;
    }
    
    _tableView.tableFooterView = _footerView;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGBankCardTopupTableViewCell *cell = [CGBankCardTopupTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __block CGBankCardTopupTableViewCell *  weakCell = cell;
    
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"CNY"]) {
        cell.moneyTypeIcon.image = [UIImage imageNamed:@"selectCNY"];
        cell.moneyTypeLab.text = @"人民币(CNY)充值";
        
    }
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"USD"]) {
        cell.moneyTypeIcon.image = [UIImage imageNamed:@"selectUSD"];
        cell.moneyTypeLab.text = @"美元(USD)充值";
    }
    
    //当上下滑动时因为cell复用，需要判断哪个选择了
    if (_selIndex == indexPath) {
        weakCell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    }else{
        weakCell.selectImg.image = [UIImage imageNamed:@"unselectIcon"];
    }
    if (_selIndex == nil && indexPath.row == 0) {
        weakCell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    _moneyNum.text = nil;
    
    _countType = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
    _blance = [StringUtil changeFloat:[NSString stringWithFormat:@"%0.4f",[[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"blance"] floatValue]]];
    _availableBalanceLab.text = [NSString stringWithFormat:@"可用余额:%@",_blance];
    if([_countType isEqualToString:@"CNY"]){
        _moneyTypeIcon.image = [UIImage imageNamed:@"CNYIcon"];
    }else if([_countType isEqualToString:@"USD"]){
        _moneyTypeIcon.image = [UIImage imageNamed:@"USDIcon"];
    }
    
    CGBankCardTopupTableViewCell *celld = [tableView cellForRowAtIndexPath:_selIndex];
    celld.selectImg.image = [UIImage imageNamed:@"unselectIcon"];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    CGBankCardTopupTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    [_tableView reloadData];
}

-(void)nextClick{
    [self.view endEditing:YES];
    if([StringUtil isNullOrEmptyOrZero:_moneyNum.text]){
        [MBProgressHUD showText:@"请输入提款金额" toView:self.view];
        return;
    }else if([_moneyNum.text floatValue] > [_blance floatValue]){
        [MBProgressHUD showText:@"金额超过可转出到卡余额" toView:self.view];
        return;
    }
    
    
    [self.view endEditing:YES];
    
    XLPasswordView *passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.view];
    
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
//    NSLog(@"%@%@%@%@",_bankCard,_moneyNum.text,_countType,password);
    
    //    NSDictionary *datas = [NSDictionary dictionaryWithObjectsAndKeys:
    //                           _moneyNum.text,@"tradeMoney",
    //                           _countType,@"payType",
    //                           _bankCard,@"countId",
    //                           password,@"payPwd",
    //                           nil];
    //
    //
    //    [[CGAFHttpRequest shareRequest] rechargeWithdatas:[self convertToJsonData:datas] serverSuccessFn:^(id dict) {
    //        if(dict){
    //            NSDictionary *result= dict[@"data"];
    //            NSLog(@"result%@",result);
    //        }
    //    } serverFailureFn:^(NSError *error) {
    //        if(error){
    //            NSLog(@"%@",error);
    //        }
    //    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return ([StringUtil validateMoney:_moneyNum.text Range:range String:string]);
}


-(void)allWithdrawClick{
    _moneyNum.text = [StringUtil changeFloat:[NSString stringWithFormat:@"%0.4f",[_blance floatValue]]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
