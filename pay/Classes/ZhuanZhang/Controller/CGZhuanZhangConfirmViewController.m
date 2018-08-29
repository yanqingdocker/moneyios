//
//  CGZhuanZhangConfirmViewController.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhuanZhangConfirmViewController.h"
#import "CGAccountBalanceTableViewCell.h"
#import "CGZhuanZhangJiLuViewController.h"
#import "XLPasswordView.h"
#import "CGJiaoYiDetailsViewController.h"
#import "CGBounceView.h"

@interface CGZhuanZhangConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,XLPasswordViewDelegate>
{
    UIButton *_headImgBtn;
    UILabel *_nameLab;
    UILabel *_phonenumLab;
//    UITableView *_tableView;
    NSString *_amount;
    UITextField *_note;
    
//    UITextField *amount;
    NSMutableArray *_result;
    UITextField *_beizhu;
    NSString *_account;
    NSString *_accountID;
    NSString *_countType;
    UIImageView *_headImgView;
    CGBounceView *_accountBV;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *array;
@end

@implementation CGZhuanZhangConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            _countType = [[_result objectAtIndex:0] objectForKey:@"countType"];
            _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            
            [_tableView reloadRowsAtIndexPaths:@[indexPath,indexPath1] withRowAnimation:UITableViewRowAnimationNone];
            
            //            _nameArray = [NSArray arrayWithObjects:@"USD",@"CNY",nil];
            //            NSArray *_nameArray = [[NSArray alloc] init];
            _array  = [[NSMutableArray alloc] init];
            for (int i = 0; i < _result.count; i++) {
                [_array addObject:[NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:i] objectForKey:@"cardId"],[[_result objectAtIndex:i] objectForKey:@"countType"]]];
            }
            _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
//                                [_tableView reloadData];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (void)initNav{
    self.navigationItem.title = @"转账";
    [self setBackButton:YES];
    
        UIButton *zhuanzhangjiluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zhuanzhangjiluBtn.frame = CGRectMake(0, 0, 50, 12);
        zhuanzhangjiluBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
        [zhuanzhangjiluBtn setTitle:@"转账记录" forState:UIControlStateNormal];
        [zhuanzhangjiluBtn addTarget:self action:@selector(jiluEven) forControlEvents:UIControlEventTouchUpInside];
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:zhuanzhangjiluBtn];
}

- (void)initUI{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    _headImgView = [[UIImageView alloc] init];
    _headImgView.image = [UIImage imageWithData:_imgdata];
    
    [bgView addSubview:_headImgView];
    [_headImgView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(42);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(89);
        make.height.mas_equalTo(_headImgView.mas_width);
    }];
    
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, 142, 100, 13)];
    _nameLab.text = _username;
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_nameLab];
    
    _phonenumLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, 160, 100, 9)];
    _phonenumLab.text = _receivecount;
    _phonenumLab.font = [UIFont systemFontOfSize:11];
    _phonenumLab.textColor = RGBCOLOR(204, 204, 204);
    _phonenumLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_phonenumLab];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 186, SCREEN_WIDTH, 120 + 88)  style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:_tableView];
    
//    _note = [[UITextField alloc] init];
//    _note.frame = CGRectMake(16, 322, SCREEN_WIDTH - 16*2, 10);
//    _note.font = [UIFont systemFontOfSize:10];
//    _note.placeholder = @"添加备注(20字以内)";
//    _note.delegate = self;
//    [bgView addSubview:_note];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 322+45 +88, SCREEN_WIDTH - 15*2, 36)];
    [tixianBtn setTitle:@"确认转账" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(72,151,239)];//金色247, 195, 109
    [tixianBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [bgView addSubview:tixianBtn];
}

- (void)jiluEven{
    CGZhuanZhangJiLuViewController *vc = [[CGZhuanZhangJiLuViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

- (void)confirmEvent{
    [self.view endEditing:YES];
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
                [passwordView hidePasswordView];
            }
            
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row == 0){
        return 120;
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
        CGAccountBalanceTableViewCell *cell = [CGAccountBalanceTableViewCell cellForTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"转账金额"];
        cell.titleLab.textColor = [UIColor blackColor];
        cell.titleLab.font = [UIFont systemFontOfSize:11];
        cell.contentText.keyboardType =UIKeyboardTypeDecimalPad;
        
        if([_countType isEqualToString:@"CNY"]){
//            cell.countType = @"CNYIcon";
            cell.img.image = [UIImage imageNamed:@"CNYIcon"];
        }
        if([_countType isEqualToString:@"USD"]){
            //            cell.countType = @"CNYIcon";
            cell.img.image = [UIImage imageNamed:@"USDIcon"];
        }
        
        cell.contentText.text = _moneynum;
        cell.contentText.tag = 1001;
        cell.contentText.placeholder = @"0.00";
        cell.contentText.delegate =self;
        return cell;
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
        _beizhu = [[UITextField alloc] init];
        _beizhu.frame = CGRectMake(20, 14, SCREEN_WIDTH - 15*2, 20);
        _beizhu.placeholder = @"添加备注(20字以内)";
        _beizhu.delegate =self;
        [cell addSubview:_beizhu];
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
    __block CGZhuanZhangConfirmViewController *  blockSelf = self;
    _accountBV.selectbankcardblock = ^(NSString *str){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
        
        for(int i = 0; i < blockSelf.array.count ;i++){
            if([blockSelf.array[i] isEqualToString:str]){
                _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"id"]];
                _countType = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"countType"]];
            }
        }
        
        _account = str;
        [blockSelf.tableView reloadRowsAtIndexPaths:@[indexPath,indexPath1] withRowAnimation:UITableViewRowAnimationNone];
    };
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [_nameText resignFirstResponder];
    [self.view endEditing:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    _amount = textField.text;
    if(textField.tag == 1001){
        
        _moneynum = textField.text;
    }
}

@end
