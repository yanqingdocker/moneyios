//
//  CGMyEmailViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/29.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGMyEmailViewController.h"
#import "CGImageTextTableViewCell.h"
#import "CGSendMessageViewController.h"

@interface CGMyEmailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@end

@implementation CGMyEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"我的信箱";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,55 *3);
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGImageTextTableViewCell *cell = [CGImageTextTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"messageIcon"];
        cell.titleLab.text = @"发消息";
    }
    if(indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"inboxIcon"];
        cell.titleLab.text = @"收件箱";
    }
    if(indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"outboxIcon"];
        cell.titleLab.text = @"发件箱";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        CGSendMessageViewController *vc = [[CGSendMessageViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
//    if (indexPath.row == 1){
//        CGDaiJiaoViewController *vc = [[CGDaiJiaoViewController alloc] init];
//        vc.title = @"水费代缴";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
//    if (indexPath.row == 2){
//        CGDaiJiaoViewController *vc = [[CGDaiJiaoViewController alloc] init];
//        vc.title = @"电费代缴";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
}

@end
