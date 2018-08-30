//
//  CGZhangHuZongLanViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhangHuZongLanViewController.h"
#import "CGZhangHuZongLanModel.h"
#import "CGZhangHuZongLanTableViewCell.h"

@interface CGZhangHuZongLanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  NSMutableArray *result;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *footerView;
//@property (strong, nonatomic) CGZhangHuZongLanModel model;
@end

@implementation CGZhangHuZongLanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            //            self.model=[ComDeAllocationModel mj_objectWithKeyValues:dict];
            //            UserModel *usermodel = [UserModel objectWithKeyValues:result];
            //            usermodel.login = YES;
            
            [_tableView reloadData];
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (void)initNav{
    self.navigationItem.title = @"账户总览";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,SCREEN_HEIGHT - 15 -NAVIGATIONBAR_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self addFooterView];
}

- (void)addFooterView {
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor clearColor];
        footerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 80.f);
        
        CGFloat sureBtnH = 40;
        CGFloat sureBtnY = 20;
        UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, sureBtnY, self.view.frame.size.width - 40, sureBtnH);
        [sureBtn setTitleColor:RGBCOLOR(85,135,243) forState:UIControlStateNormal];
        [sureBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
        [sureBtn setTitle:@"开通账户" forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"dottedLine"] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
        [footerView addSubview:sureBtn];
        
        _footerView = footerView;
    }
    
    _tableView.tableFooterView = _footerView;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGZhangHuZongLanTableViewCell *cell = [CGZhangHuZongLanTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGZhangHuZongLanModel *ZHZLModel = [CGZhangHuZongLanModel objectWithKeyValues:[_result objectAtIndex:indexPath.row]];
    
    if ([ZHZLModel.countType isEqualToString:@"CNY"]) {
        [cell.bgimgView setImage:[UIImage imageNamed:@"bgImgCNY"]];
        cell.countType.text = @"人民币总资产(CNY)";
    }else if ([ZHZLModel.countType isEqualToString:@"USD"]) {
        [cell.bgimgView setImage:[UIImage imageNamed:@"bgImgUSD"]];
        cell.countType.text = @"美元总资产(USD)";
    }
    
    [cell.eyeBtn setImage:[UIImage imageNamed:@"eye_close_white"] forState:UIControlStateNormal];
    [cell.eyeBtn setImage:[UIImage imageNamed:@"eye_open_white"] forState:UIControlStateSelected];
    [cell.eyeBtn addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.eyeBtn.tag = indexPath.row;
    
    cell.blance.text = ZHZLModel.blance;
    cell.cardId.text = ZHZLModel.cardId;
//    cell.blance.text = ZHZLModel.blance;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0){
//        CGSendMessageViewController *vc = [[CGSendMessageViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
//    if (indexPath.row == 1){
//        CGInBoxViewController *vc = [[CGInBoxViewController alloc] init];
//        //        vc.title = @"水费代缴";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
//    if (indexPath.row == 2){
//        CGOutBoxViewController *vc = [[CGOutBoxViewController alloc] init];
//        //        vc.title = @"电费代缴";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
}

-(void)eyeEvent:(UIButton *)button {
//    CGZhangHuZongLanModel *ZHZLModel = [CGZhangHuZongLanModel objectWithKeyValues:[_result objectAtIndex:button.tag]];
    
    button.selected = !button.selected;
    if(button.selected){
//        ZHZLModel.blance = @"****";
//        [_tableView reloadData];
    }else{
//        _blance.text = ZHZLModel.blance;
    }
    
    
    //    _blance.secureTextEntry = !_blance.secureTextEntry;
}

@end
