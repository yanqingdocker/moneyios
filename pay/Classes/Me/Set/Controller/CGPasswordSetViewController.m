//
//  CGPasswordSetViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/4.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGPasswordSetViewController.h"
#import "CGLoginPasswordViewController.h"
#import "CGPaymentPasswordViewController.h"

@interface CGPasswordSetViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@end

@implementation CGPasswordSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"密码设置";
    [self setBackButton:YES];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 15, SCREEN_WIDTH,88);
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"登录密码";
    }
    if(indexPath.row == 1){
        cell.textLabel.text = @"支付密码";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        CGLoginPasswordViewController *vc = [[CGLoginPasswordViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
        
    }
    if(indexPath.row == 1){
        CGPaymentPasswordViewController *vc = [[CGPaymentPasswordViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
        
    }
}

@end
