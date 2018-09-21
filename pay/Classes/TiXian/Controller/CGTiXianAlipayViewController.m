//
//  CGTiXianAlipayViewController.m
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTiXianAlipayViewController.h"
#import "CGAccountBalanceTableViewCell.h"
#import "CGTopUpDetailViewController.h"

@interface CGTiXianAlipayViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSString *_currencyType;
    NSString *_alipayAccount;
}

@end

@implementation CGTiXianAlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UI
- (void)initNav {
    self.navigationItem.title = @"支付宝充值";
    [self setBackButton:YES];
    
    UIButton *mingxiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mingxiBtn.frame = CGRectMake(0, 0, 15, 15);
    mingxiBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    [mingxiBtn setTitle:@"明细" forState:UIControlStateNormal];
    [mingxiBtn addTarget:self action:@selector(mingxiEven) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mingxiBtn];
}

-(void) initUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(17, 0 + 10, SCREEN_WIDTH - 17*2, 330)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
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
    [tixianBtn setTitle:@"提现" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(247, 195, 109)];
    [tixianBtn addTarget:self action:@selector(tixianTarget) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [view addSubview:tixianBtn];
}

-(void)tixianTarget{
    
}

-(void)mingxiEven{
    CGTopUpDetailViewController *tudvc = [[CGTopUpDetailViewController alloc] init];
    [self pushViewControllerHiddenTabBar:tudvc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 2){
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
        cell.textLabel.text = @"币种";
        if(_currencyType == nil){
            _currencyType = @"CNY";
        }
        cell.detailTextLabel.text = _currencyType;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
    if(indexPath.row == 1){
        cell.textLabel.text = @"支付宝充值";
        if(_alipayAccount == nil){
            cell.detailTextLabel.text = @"请选择支付宝账户";
        }else{
            cell.detailTextLabel.text = _alipayAccount;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 2) {
        CGAccountBalanceTableViewCell *cell = [CGAccountBalanceTableViewCell cellForTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"人民币账户余额:%@￥",@"0.0000"];
        cell.contentText.placeholder = @"0.0000";
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
