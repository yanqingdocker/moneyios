//
//  CGTiXianTypeViewController.m
//  pay
//
//  Created by v2 on 2018/8/3.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTiXianTypeViewController.h"
#import "CGTiXianViewController.h"
#import "CGTiXianAlipayViewController.h"

@interface CGTiXianTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@end

@implementation CGTiXianTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"提现";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH,89);
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

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGTiXianCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        UIImage *img = [UIImage imageNamed:@"yinlianIcon"];
        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
        [typeImg setImage:img];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 120, 20)];
        lab.text = @"提现到银行卡";
        [cell addSubview:typeImg];
        [cell addSubview:lab];
    }
    if(indexPath.row == 1){
        UIImage *img = [UIImage imageNamed:@"zhifubaoIcon"];
        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
        [typeImg setImage:img];
//        [cell.imageView setImage:[UIImage imageNamed:@"zhifubaoIcon"]];
//        CGRect frame = cell.imageView.frame;
//        frame.size.width = 22;
//        frame.size.height = 26;
//        cell.imageView.frame = frame;
//        cell.textLabel.text = @"提现到支付宝";
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 120, 20)];
        lab.text = @"提现到支付宝";
        [cell addSubview:typeImg];
        [cell addSubview:lab];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
        [self pushViewControllerHiddenTabBar:txvc animated:YES];
    }
    if (indexPath.row == 1){
        CGTiXianAlipayViewController *txpayvc = [[CGTiXianAlipayViewController alloc] init];
        [self pushViewControllerHiddenTabBar:txpayvc animated:YES];
    }
}
@end
