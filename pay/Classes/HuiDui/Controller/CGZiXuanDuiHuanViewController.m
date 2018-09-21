//
//  CGZiXuanDuiHuanViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/28.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZiXuanDuiHuanViewController.h"
#import "XLPasswordView.h"
#import "LMJDropdownMenu.h"
#import "CGGetSingleRateModel.h"
#import "CGHuiDuiSuccessViewController.h"

@interface CGZiXuanDuiHuanViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,XLPasswordViewDelegate,LMJDropdownMenuDelegate>{
    NSDictionary *_result;
    UILabel *_huilvLab;
    UITableView *_tableView;
    UITextField *_amount;
    UILabel *_duihuanAmount;
    
    LMJDropdownMenu *dropdownMenuLeft;
    LMJDropdownMenu *dropdownMenuRight;
    
    NSString *_sellType;
    NSString *_buyType;
    NSString *_srcountid;
    NSString *_destcountid;
    
    CGGetSingleRateModel *model;
    NSString *_huilvStr;
    
    float _huilv;
}
@end

@implementation CGZiXuanDuiHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
    
}


- (void)requestForm{
    [[CGAFHttpRequest shareRequest] getSingleRateWithtype:[NSString stringWithFormat:@"%@:%@",_sellType,_buyType] serverSuccessFn:^(id dict) {
        if(dict){


            _result = dict[@"data"];
            NSLog(@"%@",_result);
            
//            model = [CGGetSingleRateModel objectWithKeyValues:_result];
            
            _huilvLab.text = [NSString stringWithFormat:@"当前汇率：%@",[_result objectForKey:@"rate"]];
            _huilv = [[_result objectForKey:@"rate"] floatValue];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
}


- (void)initNav{
    
    
    self.navigationItem.title = @"自选汇兑";

    [self setBackButton:YES];
}

- (void)initUI{
    
    _sellType = [[_dataArray objectAtIndex:0] objectForKey:@"countType"];
    _buyType = [[_dataArray objectAtIndex:1] objectForKey:@"countType"];
    _srcountid = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:0] objectForKey:@"id"]];
    _destcountid = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:1] objectForKey:@"id"]];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.frame = CGRectMake(17  , 22, 250, 13);
    tipsLab.font = [UIFont systemFontOfSize:14];
    tipsLab.textColor = RGBCOLOR(216, 74, 74);
    tipsLab.text = @"请选择不同货币类型进行兑换";
    [bgView addSubview:tipsLab];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 50, SCREEN_WIDTH, 1);
    line.backgroundColor = RGBCOLOR(234,234,241);
    [bgView addSubview:line];
    
    UIButton *duihuanBtn = [[UIButton alloc] init];
//    duihuanBtn.frame = CGRectMake(15, 19, 40, 40);
    [duihuanBtn setImage:[UIImage imageNamed:@"duihuan"] forState:UIControlStateNormal];
    [duihuanBtn addTarget:self action:@selector(duihuanClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:duihuanBtn];
    
    [duihuanBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView).offset(66+15);
        make.height.mas_equalTo(@23);
        make.width.mas_equalTo(@30);
    }];
    
    dropdownMenuLeft = [[LMJDropdownMenu alloc] init];
    [dropdownMenuLeft setFrame:CGRectMake(65, 70, 110, 44)];
    NSMutableArray *menutitles = [[NSMutableArray alloc] init];
    for (int i = 0; i< _dataArray.count; i++) {
        [menutitles addObject:[[_dataArray objectAtIndex:i] objectForKey:@"countType"]];
    }
    
    [dropdownMenuLeft setMenuTitles:menutitles rowHeight:30];
    dropdownMenuLeft.delegate = self;
    dropdownMenuLeft.tag =1001;
//    [dropdownMenu.mainBtn addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
    dropdownMenuLeft.arrowMark.frame =CGRectMake(dropdownMenuLeft.mainBtn.frame.size.width - 50, 0, 9, 9);
    dropdownMenuLeft.arrowMark.center = CGPointMake(dropdownMenuLeft.arrowMark.center.x, dropdownMenuLeft.mainBtn.frame.size.height/2);
    [dropdownMenuLeft.mainBtn setTitle:_sellType forState:UIControlStateNormal];
    [dropdownMenuLeft.mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgView addSubview:dropdownMenuLeft];
    
    dropdownMenuRight = [[LMJDropdownMenu alloc] init];
    [dropdownMenuRight setFrame:CGRectMake(SCREEN_WIDTH - 110 -30, 70, 110, 44)];
    [dropdownMenuRight setMenuTitles:menutitles rowHeight:30];
    dropdownMenuRight.delegate = self;
    dropdownMenuRight.tag =1002;
    //    [dropdownMenu.mainBtn addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
    dropdownMenuRight.arrowMark.frame =CGRectMake(dropdownMenuRight.mainBtn.frame.size.width - 50, 0, 9, 9);
    dropdownMenuRight.arrowMark.center = CGPointMake(dropdownMenuRight.arrowMark.center.x, dropdownMenuRight.mainBtn.frame.size.height/2);
    [dropdownMenuRight.mainBtn setTitle:_buyType forState:UIControlStateNormal];
    [dropdownMenuRight.mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgView addSubview:dropdownMenuRight];

    _huilvLab = [[UILabel alloc] init];
    _huilvLab.textColor = RGBCOLOR(102, 102, 102);
    _huilvLab.font = [UIFont systemFontOfSize:14];
    _huilvLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_huilvLab];
    [_huilvLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView).offset(116+7);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@250);
    }];
    
//    if (_huilvStr) {
//        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:_huilvStr];
//        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributedStr.length) ];
//        [attributedStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(254, 0, 0) range:NSMakeRange(5,attributedStr.length - 5)];
//        _huilvLab.attributedText = attributedStr;
//    }
    
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.frame = CGRectMake(0, 146, SCREEN_WIDTH, 1);
    line2.backgroundColor = RGBCOLOR(234,234,241);
    [bgView addSubview:line2];
    
    CGRect tableframe=CGRectMake(0, 147 , SCREEN_WIDTH,94*2);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:_tableView];

    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, _tableView.frame.origin.y+_tableView.frame.size.height +22, SCREEN_WIDTH - 15*2, 36)];
    [tixianBtn setTitle:@"确认" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(72,151,239)];//金色247, 195, 109
    [tixianBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [bgView addSubview:tixianBtn];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 94;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UILabel *duihuanjine = [[UILabel alloc] init];
    duihuanjine.font = [UIFont systemFontOfSize:18];
    duihuanjine.frame = CGRectMake(18, 32, 150, 17);
    [cell addSubview:duihuanjine];
    
    UIImageView * img = [[UIImageView alloc] init];
    img.frame = CGRectMake(18, 73, 12, 16);
    [cell addSubview:img];
    
    if(indexPath.row == 0){
        duihuanjine.text = @"兑换金额";
//        if([_sellType isEqualToString:@"CNY"]){
//            [img setImage:[UIImage imageNamed:@"CNYIcon"]];
//
//        }
//        if([_sellType isEqualToString:@"USD"]){
//            [img setImage:[UIImage imageNamed:@"USDIcon"]];
//        }
//
        _amount = [[UITextField alloc] init];
        _amount.frame = CGRectMake(18, 60, SCREEN_WIDTH  - 18*2, 44);
        _amount.delegate =self;
        _amount.font = [UIFont systemFontOfSize:12];
        _amount.placeholder = [NSString stringWithFormat:@"可兑换金额:%@",[[_dataArray objectAtIndex:0] objectForKey:@"blance"]];
        _amount.clearButtonMode = UITextFieldViewModeAlways;
        _amount.keyboardType = UIKeyboardTypeDecimalPad;
        [_amount addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell addSubview:_amount];
    }
    if(indexPath.row == 1){
        duihuanjine.text = @"兑换后金额";

        _duihuanAmount = [[UILabel alloc] init];
        _duihuanAmount.frame = CGRectMake(18, 76, 320, 12);
        _duihuanAmount.font = [UIFont systemFontOfSize:12];
        _duihuanAmount.text = @"0.0000";
        [cell addSubview:_duihuanAmount];
    }
    
    
    return cell;
}

-(void) textFieldChanged:(UITextField *)textField{
    
    float huilv =  [textField.text floatValue];
    
//    if([_buyType isEqualToString:@"USD"]){
//
        float huilv2 = _huilv;
        _duihuanAmount.text = [NSString stringWithFormat:@"%0.4f",huilv / huilv2];
//    }
//    if([_buyType isEqualToString:@"CNY"]){
//
//        float huilv2 = [[_result objectForKey:@"sellPic"] floatValue];
//        _duihuanAmount.text = [NSString stringWithFormat:@"%0.4f",huilv * huilv2];
//    }
    
}


-(void) confirmEvent{
    [self.view endEditing:YES];
    if([StringUtil isNullOrEmptyOrZero:_amount.text]){
        [MBProgressHUD showText:@"请输入兑换金额" toView:self.view];
        return;
    }
    XLPasswordView *passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.view];
    
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
    NSDictionary *datas = [NSDictionary dictionaryWithObjectsAndKeys:
                           _srcountid,@"srcountid",
                           _destcountid,@"destcountid",
                           _amount.text,@"srcmoney",
                           _duihuanAmount.text,@"destmoney",
                           password,@"paypwd",
                           nil];
    
    [[CGAFHttpRequest shareRequest] exchangeWithdatas:[self convertToJsonData:datas] serverSuccessFn:^(id dict) {
            if(dict){
                NSDictionary *result= dict[@"data"];
    
                if([[dict objectForKey:@"code"] isEqualToString:@"1004"]){
                    CGHuiDuiSuccessViewController *vc = [[CGHuiDuiSuccessViewController alloc] init];
                    vc.liushuiID = [result objectForKey:@"snumber"];
                    [self pushViewControllerHiddenTabBar:vc animated:YES];
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


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [_nameText resignFirstResponder];
    [self.view endEditing:YES];
    [dropdownMenuLeft hideDropDown];
    [dropdownMenuRight hideDropDown];
}

-(void)duihuanClick{
    _amount.text =@"";
    _duihuanAmount.text = @"0.0000";
    
    NSString *zancun1 = _srcountid;
    _srcountid = _destcountid;
    _destcountid = zancun1;
    
    NSString *zancun = dropdownMenuLeft.mainBtn.titleLabel.text;
    [dropdownMenuLeft.mainBtn setTitle:dropdownMenuRight.mainBtn.titleLabel.text forState:UIControlStateNormal];
    [dropdownMenuRight.mainBtn setTitle:zancun forState:UIControlStateNormal];
//    dropdownMenuLeft.mainBtn.titleLabel.text = dropdownMenuRight.mainBtn.titleLabel.text;
//    dropdownMenuRight.mainBtn.titleLabel.text = zancun;
    
    if (![dropdownMenuLeft.mainBtn.titleLabel.text isEqualToString:dropdownMenuRight.mainBtn.titleLabel.text]) {
        
        _sellType = dropdownMenuLeft.mainBtn.titleLabel.text;
        _buyType = dropdownMenuRight.mainBtn.titleLabel.text;
        [self requestForm];
    }
    
    for(int i = 0 ; i<_dataArray.count ; i++){
        if([[[_dataArray objectAtIndex:i] objectForKey:@"countType"] isEqualToString:_sellType]){
            _amount.placeholder = [NSString stringWithFormat:@"可兑换金额:%@",[[_dataArray objectAtIndex:i] objectForKey:@"blance"]];
        }
    }
}

- (void) dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
//    NSLog(@"number%ld",(long)number);
//    [[_dataArray objectAtIndex:number] objectForKey:@"blance"];
    
    _amount.text =@"";
    _duihuanAmount.text = @"0.0000";
    
    if (menu.tag == 1001) {
        _amount.placeholder = [NSString stringWithFormat:@"可兑换金额:%@",[[_dataArray objectAtIndex:number] objectForKey:@"blance"]];
        _srcountid = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:number] objectForKey:@"id"]];
        
    }
    if (menu.tag == 1002) {
        _destcountid = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:number] objectForKey:@"id"]];

    }
    if ([dropdownMenuLeft.mainBtn.titleLabel.text isEqualToString:dropdownMenuRight.mainBtn.titleLabel.text]) {
        
        _huilvLab.text = [NSString stringWithFormat:@"当前汇率：%@",@"1"];
        _huilv = 1;
    }else{
        _sellType = dropdownMenuLeft.mainBtn.titleLabel.text;
        _buyType = dropdownMenuRight.mainBtn.titleLabel.text;
        [self requestForm];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return ([StringUtil validateMoney:_amount.text Range:range String:string]);
}


//-(void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
//
//
//}
@end
