//
//  CGHuiLvViewController.m
//  pay
//
//  Created by v2 on 2018/8/13.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGHuiLvViewController.h"
#import "CGHuiLvTableViewCell.h"

@interface CGHuiLvViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSDictionary * _dataArray;
}

@end

@implementation CGHuiLvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArray = [[NSDictionary alloc] init];
    
    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] queryAllWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    NSArray *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    
                    _dataArray = result[6];
                    NSLog(@"%@",_dataArray);
                    
                    NSArray * allkeys = [_dataArray allKeys];
                    NSLog(@"allkeys %@",allkeys);
                    
                    for (int i = 0; i < allkeys.count; i++)
                    {
                        NSString * key = [allkeys objectAtIndex:i];
                        
                        //如果你的字典中存储的多种不同的类型,那么最好用id类型去接受它
                        id obj  = [_dataArray objectForKey:key];
                        NSLog(@"obj %@",obj);
                    }
                    
                    [_tableView reloadData];
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        });
    });
    
}

#pragma mark - UI
- (void)initNav
{
    self.navigationItem.title = @"汇率";
    [self setBackButton:YES];
    
}

- (void)initUI
{
    
    
    CGRect tableframe=CGRectMake(0, 0 + 15, SCREEN_WIDTH,SCREEN_HEIGHT - 0 - 15);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
//    UIView *bgView = [[UIView alloc] init];
//    bgView.frame = CGRectMake(10,0 + 20, SCREEN_WIDTH - 20, 280);
//    bgView.backgroundColor = [UIColor whiteColor];
//    bgView.layer.cornerRadius = 5;
//    [self.view addSubview:bgView];
//
//    UILabel *huilvchaxunLab = [[UILabel alloc] init];
//    huilvchaxunLab.frame = CGRectMake(6,20, 80, 16);
//    huilvchaxunLab.text = @"汇率查询";
//    huilvchaxunLab.font = [UIFont systemFontOfSize:16];
//    [bgView addSubview:huilvchaxunLab];
//
//    UILabel *line = [[UILabel alloc] init];
//    line.frame = CGRectMake(0, 51, SCREEN_WIDTH - 20, 1);
//    line.backgroundColor = [UIColor lightGrayColor];
//    [bgView addSubview:line];
//
//    UIImageView *duihuanimgView1 = [[UIImageView alloc] init];
//    duihuanimgView1.frame = CGRectMake(12,78, 30, 30);
//    duihuanimgView1.image = [UIImage imageNamed:@"中国"];
//    [bgView addSubview:duihuanimgView1];
//
//    UILabel *duihuanhuobi1 = [[UILabel alloc] init];
//    duihuanhuobi1.frame = CGRectMake(46,83, 100, 15);
//    duihuanhuobi1.text = @"人民币";
//    duihuanhuobi1.font = [UIFont systemFontOfSize:16];
//    [bgView addSubview:duihuanhuobi1];
//
//    UIImageView *_arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(duihuanhuobi1.frame.origin.x + 45, 87, 10, 10)];
////    _arrowMark.center = CGPointMake(VIEW_CENTER_X(_arrowMark), VIEW_HEIGHT(_mainBtn)/2);
//    _arrowMark.image  = [UIImage imageNamed:@"xiala.png"];
//    [bgView addSubview:_arrowMark];
//
//    UILabel *duihuanhuobitype1 = [[UILabel alloc] init];
//    duihuanhuobitype1.frame = CGRectMake(46,101, 100, 11);
//    duihuanhuobitype1.text = @"CNY";
//    duihuanhuobitype1.font = [UIFont systemFontOfSize:10];
//    [bgView addSubview:duihuanhuobitype1];
//
//    UIButton *button=[[UIButton alloc]init];
//    button.frame=CGRectMake(bgView.frame.size.width/2-25 , 97 , 50 , 50);
//    [button setImage:[UIImage imageNamed:@"huhuan.png"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(huhuanEvevt) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:button];
//
//
//    UIImageView *duihuanimgView2 = [[UIImageView alloc] init];
//    duihuanimgView2.frame = CGRectMake(SCREEN_WIDTH - 74 -30,78, 30, 30);
//    duihuanimgView2.image = [UIImage imageNamed:@"美国"];
//    [bgView addSubview:duihuanimgView2];
//
//    UILabel *duihuanhuobi2 = [[UILabel alloc] init];
//    duihuanhuobi2.frame = CGRectMake(SCREEN_WIDTH - 74 + 5 ,83, 100, 15);
//    duihuanhuobi2.text = @"美元";
//    duihuanhuobi2.font = [UIFont systemFontOfSize:16];
//    [bgView addSubview:duihuanhuobi2];
//
//    UIImageView *_arrowMark2 = [[UIImageView alloc] initWithFrame:CGRectMake(duihuanhuobi2.frame.origin.x +30, 87, 10, 10)];
//    //    _arrowMark.center = CGPointMake(VIEW_CENTER_X(_arrowMark), VIEW_HEIGHT(_mainBtn)/2);
//    _arrowMark2.image  = [UIImage imageNamed:@"xiala.png"];
//    [bgView addSubview:_arrowMark2];
//
//    UILabel *duihuanhuobitype2 = [[UILabel alloc] init];
//    duihuanhuobitype2.frame = CGRectMake(SCREEN_WIDTH - 74 + 5,101, 100, 11);
//    duihuanhuobitype2.text = @"USD";
//    duihuanhuobitype2.font = [UIFont systemFontOfSize:10];
//    [bgView addSubview:duihuanhuobitype2];
//
//    UILabel *money1 = [[UILabel alloc] init];
//    money1.frame = CGRectMake(12,139, 110, 18);
//    money1.text = @"￥100";
////    money1.textAlignment = NSTextAlignmentCenter;
//    money1.font = [UIFont systemFontOfSize:24];
//    [bgView addSubview:money1];
//
//    UILabel *money2 = [[UILabel alloc] init];
//    money2.frame = CGRectMake(SCREEN_WIDTH - 74 - 30 ,139, 110, 18);
//    money2.text = @"$680";
//    money2.font = [UIFont systemFontOfSize:24];
////    money2.textAlignment = NSTextAlignmentCenter;
//    [bgView addSubview:money2];
//
//    UIView *bottomView = [[UIView alloc] init];
//    bottomView.frame = CGRectMake(0,212, SCREEN_WIDTH - 20, 68);
//    bottomView.backgroundColor = [UIColor blueColor];
//    [bgView addSubview:bottomView];
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = bottomView.bounds;
//    maskLayer.path = maskPath.CGPath;
//    bottomView.layer.mask = maskLayer;
//
//    UILabel *yhpjllLab = [[UILabel alloc] init];
//    yhpjllLab.frame = CGRectMake(12,239, 120, 14);
//    yhpjllLab.text = @"银行平均利率";
//    yhpjllLab.font = [UIFont systemFontOfSize:14];
//    yhpjllLab.textColor = [UIColor whiteColor];
//    [bgView addSubview:yhpjllLab];
//
//    UILabel *yhpjll = [[UILabel alloc] init];
//    yhpjll.frame = CGRectMake(SCREEN_WIDTH-110-20 -10,239, 110, 14);
//    yhpjll.text = @"1.677";
//    yhpjll.font = [UIFont systemFontOfSize:18];
//    yhpjll.textColor = [UIColor whiteColor];
//    yhpjll.textAlignment = NSTextAlignmentRight;
//    [bgView addSubview:yhpjll];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGHuiLvTableViewCell *cell = [CGHuiLvTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if(indexPath.row == 0){
        cell.currency.text = @"兑换方式";
        cell.buyPic.text = @"买入";
        cell.sellPic.text = @"卖出";
    }else{
        NSArray * allkeys = [_dataArray allKeys];
        NSString * key = [allkeys objectAtIndex:indexPath.row-1];
        id obj  = [_dataArray objectForKey:key];
        cell.currency.text = [obj objectForKey:@"currency"];
        cell.buyPic.text = [NSString stringWithFormat:@"%@",[obj objectForKey:@"buyPic"]];
        cell.sellPic.text = [NSString stringWithFormat:@"%@",[obj objectForKey:@"sellPic"]];
    }
    
    

//    cell.currency.text = [[_dataArray objectForKey:@"USDHKD"] objectForKey:@"currency"];
//    cell.buyPic.text = [NSString stringWithFormat:@"%@",[[_dataArray objectForKey:@"USDHKD"] objectForKey:@"buyPic"]];
//    cell.sellPic.text = [NSString stringWithFormat:@"%@",[[_dataArray objectForKey:@"USDHKD"] objectForKey:@"sellPic"]];
    return cell;
    
//    static NSString *ID = @"CGHuiLvCell";
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
//        //        [cell.imageView setImage:[UIImage imageNamed:@"zhifubaoIcon"]];
//        //        CGRect frame = cell.imageView.frame;
//        //        frame.size.width = 22;
//        //        frame.size.height = 26;
//        //        cell.imageView.frame = frame;
//        //        cell.textLabel.text = @"提现到支付宝";
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 120, 20)];
//        lab.text = @"提现到支付宝";
//        [cell addSubview:typeImg];
//        [cell addSubview:lab];
//    }
//    return cell;
}

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

//-(void)huhuanEvevt{
//
//}
@end
