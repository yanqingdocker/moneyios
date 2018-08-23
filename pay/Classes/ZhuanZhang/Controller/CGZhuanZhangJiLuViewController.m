//
//  CGZhuanZhangJiLuViewController.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhuanZhangJiLuViewController.h"
#import "CGBudgetMonthTableViewCell.h"
#import "CGZhuanZhangDetailTableViewCell.h"

@interface CGZhuanZhangJiLuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation CGZhuanZhangJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"转账记录";
    [self setBackButton:YES];
}

- (void)initUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 0)  style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 25;
    }else{
        return 68;
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
        CGBudgetMonthTableViewCell *cell = [CGBudgetMonthTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.month = @"06";
        cell.monthshouru = @"10000";
        cell.monthzhichu = @"1000000000";
        cell.titleLab.text = [NSString stringWithFormat:@"%@月 支出：%@ 收入：%@",@"06",@"10000",@"1000000000"];
//        cell.titleLab.text = [NSString stringWithFormat:@"转账金额"];
        return cell;
    }
    if (indexPath.row == 1) {
        CGZhuanZhangDetailTableViewCell *cell = [CGZhuanZhangDetailTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeLab.text = @"转账-用户";
        cell.moneyLab.text = @"10000";
        cell.dateLab.text = @"06-24";
        cell.stateLab.text = [NSString stringWithFormat:@"交易成功"];
        return cell;
    }
    
    return cell;
}


@end
