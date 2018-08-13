//
//  CGTiXianTiKuanViewController.m
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTiXianTiKuanViewController.h"
#import "CGAccountBalanceTableViewCell.h"
#import "CGTiXianResultsAlertView.h"

@interface CGTiXianTiKuanViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSString *_bankCard;
    NSString *_withdrawals;
//    NSString *_currencyType;
//    NSString *_alipayAccount;
}

@end

@implementation CGTiXianTiKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"提现";
    [self setBackButton:YES];
}

- (void)initUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(17, NAVIGATIONBAR_HEIGHT + 10, SCREEN_WIDTH - 17*2, 330)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    //CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)  style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [view addSubview:_tableView];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(13, 253, view.frame.size.width - 13*2, 44)];
    [tixianBtn setTitle:@"提款" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(247, 195, 109)];
    [tixianBtn addTarget:self action:@selector(tikuanEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [view addSubview:tixianBtn];
}

- (void)tikuanEvent{
    
    CGTiXianResultsAlertView *alertview = [[CGTiXianResultsAlertView alloc] initWithFrame:CGRectMake(0, 0, 286, 315) withTitle:@"完成" alertMessage:@"取款成功" confrimBolck:^{
        NSLog(@"点击了确认");
    } cancelBlock:^{
        NSLog(@"点击了取消");
    }];
    [alertview show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 1){
        return 120;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    if (indexPath.row == 0){
        cell.textLabel.text = @"到账银行卡";
        UILabel *yhkLab = [[UILabel alloc] init];
        yhkLab.frame = CGRectMake(SCREEN_WIDTH - 50 - 150, 15, 150, 15);
        yhkLab.text = @"建设银行（9688）";
        
        UIImageView *bankIcon = [[UIImageView alloc] init];
        UIImage *img = [UIImage imageNamed:@"yinlianIcon"];
        [bankIcon setImage: img];
        bankIcon.frame = CGRectMake(SCREEN_WIDTH - 50 - 150 - 20, 15, 15, 15);
        
        [cell addSubview:bankIcon];
        [cell addSubview:yhkLab];
//        if(_currencyType == nil){
//            _currencyType = @"CNY";
//        }
//        cell.
//        cell.detailTextLabel.text = _currencyType;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
//    if(indexPath.row == 1){
//        cell.textLabel.text = @"支付宝充值";
//        if(_alipayAccount == nil){
//            cell.detailTextLabel.text = @"请选择支付宝账户";
//        }else{
//            cell.detailTextLabel.text = _alipayAccount;
//        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    
    if (indexPath.row == 1) {
        CGAccountBalanceTableViewCell *cell = [CGAccountBalanceTableViewCell cellForTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"提款金额"];
        cell.titleLab.textColor = [UIColor blackColor];
        cell.titleLab.font = [UIFont systemFontOfSize:15];
        cell.contentText.placeholder = @"0.00";
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
