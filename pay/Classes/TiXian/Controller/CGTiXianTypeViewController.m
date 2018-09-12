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
#import "CGCashToBankCardViewController.h"

@interface CGTiXianTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

//@property (strong, nonatomic) UITableView *tableView;
@end

@implementation CGTiXianTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initNav{
    self.navigationItem.title = @"提现";
    [self setBackButton:YES];
}

-(void)initUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, 527)];//SCREEN_HEIGHT-44-66 -30
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    //每个Item宽高
    CGFloat W = 90;
    CGFloat H = 90;
    //每行列数
    NSInteger rank = 2;
    //每列间距
    CGFloat rankMargin = (self.view.frame.size.width - rank * W) / (rank);
    //每行间距
    CGFloat rowMargin = 85;
    //    CGFloat rowMargin = 20;
    //Item索引 ->根据需求改变索引
    NSUInteger index = 6;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin);
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        //Item top
        CGFloat top = 45;
        
        //        UIView *speedView = [[UIView alloc] init];
        UIButton *cellView = [[UIButton alloc ]init];
        if(i == 0){
            [cellView setImage:[UIImage imageNamed:@"提现到银行"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 1){
            [cellView setImage:[UIImage imageNamed:@"提现到支付宝"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 2){
            [cellView setImage:[UIImage imageNamed:@"提现到微信"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 3){
            [cellView setImage:[UIImage imageNamed:@"提现到比特币"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 4){
            [cellView setImage:[UIImage imageNamed:@"现金提现"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 5){
            [cellView setImage:[UIImage imageNamed:@"外币提现"] forState:UIControlStateNormal];
            cellView.tag = i;
        }
        [cellView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cellView.frame = CGRectMake(X+rankMargin/2, Y+top, W, H);
        [bgView addSubview:cellView];
    }
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 20, 1, bgView.frame.size.height - 40)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    //    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 0, 1, bgView.frame.size.height)];
    //    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height/3, SCREEN_WIDTH-40, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height/3*2, SCREEN_WIDTH-40, 1)];
    line4.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgView addSubview:line1];
    //    [bgView addSubview:line2];
    [bgView addSubview:line3];
    [bgView addSubview:line4];
    
    //---------------原代码
//    CGRect tableframe=CGRectMake(0, 0, SCREEN_WIDTH,89);
//    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
//    _tableView.delegate=self;
//    _tableView.dataSource=self;
//    _tableView.bounces = NO;
//    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
//    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:_tableView];
    //---------------原代码
}

- (void)btnClick:(UIButton *)btn
{
    if(btn.tag == 0){
        [[CGAFHttpRequest shareRequest] queryWithserverSuccessFn:^(id dict) {
            if(dict){
                if([dict[@"data"] count] > 0){
                    CGCashToBankCardViewController *vc = [[CGCashToBankCardViewController alloc] init];
                    vc.bankcardArray = dict[@"data"];
                    [self pushViewControllerHiddenTabBar:vc animated:YES];
                }else{
                    [MBProgressHUD showText:@"您没有银行卡" toView:self.view];
                }
                
                
            }
        } serverFailureFn:^(NSError *error) {
            if(error){
                NSLog(@"%@",error);
            }
        }];
        
//        CGTiXianViewController *vc = [[CGTiXianViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
        
    }else if(btn.tag == 1){
        
    }else if(btn.tag == 2){
        
    }else if(btn.tag == 3){
        
    }else if(btn.tag == 4){
        
    }else if(btn.tag == 5){
        
    }
}

//---------------原代码
//#pragma mark - 代理方法
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *ID = @"CGTiXianCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//
//    if (cell == nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    if(indexPath.row == 0){
//        UIImage *img = [UIImage imageNamed:@"yinlianIcon"];
//        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
//        [typeImg setImage:img];
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 120, 20)];
//        lab.text = @"提现到银行卡";
//        [cell addSubview:typeImg];
//        [cell addSubview:lab];
//    }
//    if(indexPath.row == 1){
//        UIImage *img = [UIImage imageNamed:@"zhifubaoIcon"];
//        UIImageView *typeImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
//        [typeImg setImage:img];
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 120, 20)];
//        lab.text = @"提现到支付宝";
//        [cell addSubview:typeImg];
//        [cell addSubview:lab];
//    }
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0){
//        CGTiXianViewController *txvc = [[CGTiXianViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:txvc animated:YES];
//    }
//    if (indexPath.row == 1){
//        CGTiXianAlipayViewController *txpayvc = [[CGTiXianAlipayViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:txpayvc animated:YES];
//    }
//}
//---------------原代码
@end
