//
//  CGSetViewController.m
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGSetViewController.h"
#import "CGMyProfileViewController.h"

@interface CGSetViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSDictionary * _dataArray;
}

@end

@implementation CGSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = [UIColor blackColor];
//        self.navigationController.navigationBar.translucent = NO;
//    }
}

- (void)initNav{
    self.navigationItem.title = @"设置";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 0, SCREEN_WIDTH,352);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UIButton *logOutBtn = [[UIButton alloc] init];
    logOutBtn.frame = CGRectMake(0, 0 + 15 + 352 + 30, SCREEN_WIDTH, 44);
    [logOutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
    logOutBtn.backgroundColor = [UIColor whiteColor];
    [logOutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOutClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logOutBtn];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 3;
    }
    else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;//section头部高度
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGTiXianCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"我的资料";
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"账户显示";
        }
    }
    if (indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"密码设置";
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"银行卡管理";
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"支付宝管理";
        }
    }
    if (indexPath.section == 2){
        if(indexPath.row == 0){
            cell.textLabel.text = @"意见反馈";
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"关于我们";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        if(indexPath.row == 0){
            CGMyProfileViewController *vc = [[CGMyProfileViewController alloc] init];
            [self pushViewControllerHiddenTabBar:vc animated:YES];

        }
        if(indexPath.row == 1){
//            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//            [self pushViewControllerHiddenTabBar:txvc animated:YES];

        }
    }
    if (indexPath.section == 1){
        if(indexPath.row == 0){
//            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//            [self pushViewControllerHiddenTabBar:txvc animated:YES];

        }
        if(indexPath.row == 1){
//            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//            [self pushViewControllerHiddenTabBar:txvc animated:YES];

        }
        if(indexPath.row == 2){
//            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//            [self pushViewControllerHiddenTabBar:txvc animated:YES];

        }
    }
    if (indexPath.section == 2){
        if(indexPath.row == 0){
//            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//            [self pushViewControllerHiddenTabBar:txvc animated:YES];

        }
        if(indexPath.row == 1){
//            CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//            [self pushViewControllerHiddenTabBar:txvc animated:YES];

        }
    }
    
}

-(void)logOutClick{
    
}

@end
