//
//  CGJiaoFeiTypeViewController.m
//  pay
//
//  Created by v2 on 2018/8/22.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGJiaoFeiTypeViewController.h"

#import "CGHuaFeiChongZhiViewController.h"
#import "CGDaiJiaoViewController.h"

@interface CGJiaoFeiTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@end


@implementation CGJiaoFeiTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"缴费";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,165);
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
    static NSString *ID = @"CGJiaoFeiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.row == 0){
        UIImage *img = [UIImage imageNamed:@"yinlianIcon"];
        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(18, 19, 15, 18)];
        [typeImg setImage:img];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 120, 16)];
        lab.font = [UIFont systemFontOfSize:16];
        lab.text = @"话费充值";
        [cell addSubview:typeImg];
        [cell addSubview:lab];
    }
    if(indexPath.row == 1){
        UIImage *img = [UIImage imageNamed:@"yinlianIcon"];
        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(18, 19, 15, 18)];
        [typeImg setImage:img];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 120, 16)];
        lab.font = [UIFont systemFontOfSize:16];
        lab.text = @"水费代缴";
        [cell addSubview:typeImg];
        [cell addSubview:lab];
    }
    if(indexPath.row == 2){
        UIImage *img = [UIImage imageNamed:@"yinlianIcon"];
        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(18, 19, 15, 18)];
        [typeImg setImage:img];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, 120, 16)];
        lab.font = [UIFont systemFontOfSize:16];
        lab.text = @"电费代缴";
        [cell addSubview:typeImg];
        [cell addSubview:lab];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        CGHuaFeiChongZhiViewController *vc = [[CGHuaFeiChongZhiViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
    if (indexPath.row == 1){
        CGDaiJiaoViewController *vc = [[CGDaiJiaoViewController alloc] init];
        vc.title = @"水费代缴";
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
    if (indexPath.row == 2){
        CGDaiJiaoViewController *vc = [[CGDaiJiaoViewController alloc] init];
        vc.title = @"电费代缴";
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
}

@end
