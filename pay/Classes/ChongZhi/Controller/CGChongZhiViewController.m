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

#import "CGBankCardTopUpViewController.h"

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
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
//    tap1.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tap1];


}
//-(void)viewTapped:(UITapGestureRecognizer*)tap1
//{
//
//    [self.view endEditing:YES];
//
//}

- (void)initNav{
    self.navigationItem.title = @"充值中心";
    [self setBackButton:YES];
}

- (void)initUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, 527)];//SCREEN_HEIGHT-44-66 -30
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    //每个Item宽高
    CGFloat W = 90;
    CGFloat H = 90;
    //每行列数
    NSInteger rank = 2;
    //每列间距
    CGFloat rankMargin = (self.view.frame.size.width - rank * W) / (rank);
    //每行间距
        CGFloat rowMargin = 85;
//    CGFloat rowMargin = 20;
    //Item索引 ->根据需求改变索引
    NSUInteger index = 5;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin);
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        //Item top
        CGFloat top = 45;
        
        //        UIView *speedView = [[UIView alloc] init];
        UIButton *cellView = [[UIButton alloc ]init];
        if(i == 0){
            [cellView setImage:[UIImage imageNamed:@"银行卡充值"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 1){
            [cellView setImage:[UIImage imageNamed:@"支付宝充值"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 2){
            [cellView setImage:[UIImage imageNamed:@"微信充值"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 3){
            [cellView setImage:[UIImage imageNamed:@"比特币充值"] forState:UIControlStateNormal];
//            [cellView setTitle:@"比特币充值" forState:UIControlStateNormal];
//            cellView.titleLabel.font = [UIFont systemFontOfSize:18];
            [cellView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else if(i == 4){
            [cellView setImage:[UIImage imageNamed:@"网银充值"] forState:UIControlStateNormal];
            cellView.tag = i;
        }
        [cellView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cellView.frame = CGRectMake(X+rankMargin/2, Y+top, W, H);
        
        [bgView addSubview:cellView];
    }
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 20, 1, bgView.frame.size.height - 40)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 0, 1, bgView.frame.size.height)];
//    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height/3, SCREEN_WIDTH-40, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height/3*2, SCREEN_WIDTH-40, 1)];
    line4.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgView addSubview:line1];
//    [bgView addSubview:line2];
    [bgView addSubview:line3];
    [bgView addSubview:line4];
    
    
    
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)  style:UITableViewStylePlain];
//    [_tableView setDelegate:self];
//    [_tableView setDataSource:self];
//    _tableView.bounces = NO;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:_tableView];
//
//    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0 + 163, SCREEN_WIDTH - 15*2, 44)];
//    [tixianBtn setTitle:@"下一步" forState:UIControlStateNormal];
//    [tixianBtn setTintColor:[UIColor whiteColor]];
//    [tixianBtn setBackgroundColor:RGBCOLOR(247, 195, 109)];
//    [tixianBtn addTarget:self action:@selector(tikuanEvent) forControlEvents:UIControlEventTouchUpInside];
//    tixianBtn.layer.cornerRadius = 5;
//    [self.view addSubview:tixianBtn];
}

//- (void)tikuanEvent{
//
//    _confirmPaymentView = [[CGConfirmPaymentView alloc]init];
//    _confirmPaymentView.cellTextLabel1 = @"充值号码";
//    _confirmPaymentView.cellTextLabel2 = @"付款方式";
//    _confirmPaymentView.amount = _amount;
//    _confirmPaymentView.phoneNum = @"充值";
//    [_confirmPaymentView showInView:self.view];
//    __block CGChongZhiViewController *  blockSelf = self;
//    _confirmPaymentView.selectbankcardblock = ^(NSString *str){
//
//    };
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 120;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifire = @"CellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//
//
//    if (indexPath.row == 0) {
//        CGAccountBalanceTableViewCell *cell = [CGAccountBalanceTableViewCell cellForTableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.titleLab.text = [NSString stringWithFormat:@"充值金额"];
//        cell.titleLab.textColor = [UIColor blackColor];
//        cell.titleLab.font = [UIFont systemFontOfSize:15];
//        cell.contentText.keyboardType =UIKeyboardTypeDecimalPad;
//        cell.contentText.placeholder = @"0.00";
//        cell.contentText.delegate =self;
//        return cell;
//    }
//
//    return cell;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    _amount = textField.text;
//}

- (void)btnClick:(UIButton *)btn
{
    if(btn.tag == 0){
        [[CGAFHttpRequest shareRequest] queryWithserverSuccessFn:^(id dict) {
            if(dict){
                if([dict[@"data"] count] > 0){
                    CGBankCardTopUpViewController *vc = [[CGBankCardTopUpViewController alloc] init];
                    vc.bankcardArray = dict[@"data"];
                    [self pushViewControllerHiddenTabBar:vc animated:YES];
                }else{
                    [MBProgressHUD showText:@"您没有银行卡" toView:self.view];
                }
                
                
            }
        } serverFailureFn:^(NSError *error) {
            if(error){
                NSLog(@"%@",error);
            }
        }];
        
        
        
    }else if(btn.tag == 1){
//        CGHuaFeiChongZhiViewController *vc = [[CGHuaFeiChongZhiViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else if(btn.tag == 2){
//        CGZhuanZhangViewController *vc = [[CGZhuanZhangViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else if(btn.tag == 3){
//        NSLog(@"%@",@"创建账户");
//        [[CGAFHttpRequest shareRequest] createCountWithcountType:@"countType" payPwd:@"payPwd" serverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
    }else if(btn.tag == 4){
//        NSLog(@"%@",@"修改账户状态");
//        [[CGAFHttpRequest shareRequest] startOrstopCountWithID:@"13950357177" State:@"0" serverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
        
    }else if(btn.tag == 5){
//        [[CGAFHttpRequest shareRequest] getuserWithserverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
    }
}

@end
