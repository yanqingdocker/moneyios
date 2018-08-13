//
//  CGTopUpDetailViewController.m
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTopUpDetailViewController.h"
#import "CGTopUpDetailTableViewCell.h"

@interface CGTopUpDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation CGTopUpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"明细";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGTopUpDetailTableViewCell *cell = [CGTopUpDetailTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = [NSString stringWithFormat:@"充值"];
    cell.dateLab.text = [NSString stringWithFormat:@"2018-08-01"];
    cell.balanceLab.text = [NSString stringWithFormat:@"0.00"];
    cell.changeLab.text = [NSString stringWithFormat:@"+16.54"];
    return cell;
    
}
@end
