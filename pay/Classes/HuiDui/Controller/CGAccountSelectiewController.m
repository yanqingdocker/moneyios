//
//  CGAccountSelectiewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/28.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGAccountSelectiewController.h"
#import "CGBuyMoneyViewController.h"

@interface CGAccountSelectiewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_result;
    NSString *_sellType;
    NSString *_blance;
}

@end

@implementation CGAccountSelectiewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initNav{
    self.navigationItem.title = @"账户选择";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 0 + 15, SCREEN_WIDTH,_dataArray.count*60);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UIImageView *moneyIcon = [[UIImageView alloc] init];
    moneyIcon.frame = CGRectMake(14, 10, 40, 40);
    [cell addSubview:moneyIcon];
    
    UILabel *selectLab = [[UILabel alloc] init];
    selectLab.textColor = RGBCOLOR(102, 102, 102);
    selectLab.font = [UIFont systemFontOfSize:18];
    [cell addSubview:selectLab];
    [selectLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(moneyIcon.mas_right).offset(10);
        make.centerY.equalTo(cell);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@200);
    }];
    
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"CNY"]) {
        moneyIcon.image = [UIImage imageNamed:@"selectCNY"];
        selectLab.text = @"人民币(CNY)充值";
        
    }
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"USD"]) {
        moneyIcon.image = [UIImage imageNamed:@"selectUSD"];
        selectLab.text = @"美元(USD)充值";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _sellType = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
    _blance = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"blance"];
    
    CGBuyMoneyViewController *vc = [[CGBuyMoneyViewController alloc] init];
    vc.blance = _blance;
    vc.buyType = _buyType;
    vc.sellType = _sellType;
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}
@end
