//
//  CGHuiDuiTypeViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/28.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGHuiDuiTypeViewController.h"
#import "CGAccountSelectiewController.h"
#import "CGZiXuanDuiHuanViewController.h"

@interface CGHuiDuiTypeViewController (){
    NSMutableArray *_result;
    NSMutableArray *_dataArray;
}


@end

@implementation CGHuiDuiTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    [self requestForm];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [_dataArray removeAllObjects];
}

- (void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
}

- (void)initNav{
    self.navigationItem.title = @"汇兑";
    [self setBackButton:YES];
}

- (void)initUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, 347)];//SCREEN_HEIGHT-44-66 -30 - 153
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
    NSUInteger index = 4;
    
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
            [cellView setImage:[UIImage imageNamed:@"买入美元"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 1){
            [cellView setImage:[UIImage imageNamed:@"买入人民币"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 2){
            [cellView setImage:[UIImage imageNamed:@"自选汇兑"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 3){
            [cellView setImage:[UIImage imageNamed:@"买入比特币"] forState:UIControlStateNormal];
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
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height/2, SCREEN_WIDTH-40, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(20, bgView.frame.size.height/3*2, SCREEN_WIDTH-40, 1)];
//    line4.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgView addSubview:line1];
    //    [bgView addSubview:line2];
    [bgView addSubview:line3];
//    [bgView addSubview:line4];
    
    
    
}

- (void)btnClick:(UIButton *)btn
{
    if(btn.tag == 0){
        BOOL isJump = NO;
        
        for (int i = 0; i<_result.count; i++) {
            if(![[[_result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:@"USD"]){
                [_dataArray addObject:[_result objectAtIndex:i]];
            }else{
                isJump = YES;
            }
        }
        
        if(isJump){
            CGAccountSelectiewController *vc = [[CGAccountSelectiewController alloc] init];
            vc.dataArray = _dataArray;
            vc.buyType = @"USD";
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"抱歉您没有美元账户,无法买入美元" toView:self.view];
        }
        
        
    }else if(btn.tag == 1){
        BOOL isJump = NO;
        
        for (int i = 0; i<_result.count; i++) {
            if(![[[_result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:@"CNY"]){
                [_dataArray addObject:[_result objectAtIndex:i]];
            }else{
                isJump = YES;
            }
        }
        
        if(isJump){
            CGAccountSelectiewController *vc = [[CGAccountSelectiewController alloc] init];
            vc.dataArray = _dataArray;
            vc.buyType = @"CNY";
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"抱歉您没有人民币账户,无法买入人民币" toView:self.view];
        }
    }else if(btn.tag == 2){
        if (_result.count < 2) {
            [MBProgressHUD showText:@"抱歉您的账号不足两个,无法自选汇兑" toView:self.view];
            return;
        }
        
        CGZiXuanDuiHuanViewController *vc = [[CGZiXuanDuiHuanViewController alloc] init];
        vc.dataArray = _result;
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else if(btn.tag == 3){
        [MBProgressHUD showText:@"该功能正在开发中..." toView:self.view];
    }
}

@end
