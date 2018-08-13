//
//  CGChongZhiViewController.m
//  pay
//
//  Created by v2 on 2018/8/7.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGChongZhiViewController.h"
#import "CGAccountBalanceTableViewCell.h"
#import "CGTiXianResultsAlertView.h"
#import "CGConfirmPaymentView.h"

@interface CGChongZhiViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSString *_bankCard;
    NSString *_withdrawals;
    
    NSString *_amount;
    
    //    NSString *_currencyType;
    //    NSString *_alipayAccount;
    CGConfirmPaymentView *_confirmPaymentView;
}

@end

@implementation CGChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];


}
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
    
}

- (void)initNav{
    self.navigationItem.title = @"充值";
    [self setBackButton:YES];
}

- (void)initUI{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT + 10, SCREEN_WIDTH , 330)];
//    view.backgroundColor = [UIColor whiteColor];
//    view.layer.cornerRadius = 5;
//    view.layer.masksToBounds = YES;
//    [self.view addSubview:view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 120)  style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, NAVIGATIONBAR_HEIGHT + 163, SCREEN_WIDTH - 15*2, 44)];
    [tixianBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(247, 195, 109)];
    [tixianBtn addTarget:self action:@selector(tikuanEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [self.view addSubview:tixianBtn];
}

- (void)tikuanEvent{
    
//    CGTiXianResultsAlertView *alertview = [[CGTiXianResultsAlertView alloc] initWithFrame:CGRectMake(0, 0, 286, 315) withTitle:@"完成" alertMessage:@"取款成功" confrimBolck:^{
//        NSLog(@"点击了确认");
//    } cancelBlock:^{
//        NSLog(@"点击了取消");
//    }];
//    [alertview show];
    
    _confirmPaymentView = [[CGConfirmPaymentView alloc]init];
    _confirmPaymentView.cellTextLabel1 = @"充值号码";
    _confirmPaymentView.cellTextLabel2 = @"付款方式";
    _confirmPaymentView.amount = _amount;
    _confirmPaymentView.phoneNum = @"充值";
    [_confirmPaymentView showInView:self.view];
    //            __weak __typeof(self)wself = self;
    __block CGChongZhiViewController *  blockSelf = self;
    _confirmPaymentView.selectbankcardblock = ^(NSString *str){
        
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
    
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
        cell.titleLab.text = [NSString stringWithFormat:@"充值金额"];
        cell.titleLab.textColor = [UIColor blackColor];
        cell.titleLab.font = [UIFont systemFontOfSize:15];
        cell.contentText.keyboardType =UIKeyboardTypeDecimalPad;
        cell.contentText.placeholder = @"0.00";
        cell.contentText.delegate =self;
        return cell;
    }
    
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _amount = textField.text;
}

@end
