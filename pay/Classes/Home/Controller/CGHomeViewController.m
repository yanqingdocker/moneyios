//
//  CGHomeViewController.m
//  pay
//
//  Created by v2 on 2018/8/1.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGHomeViewController.h"
#import <JhtMarquee/JhtVerticalMarquee.h>
#import <JhtMarquee/JhtHorizontalMarquee.h>

#import "CGTiXianTypeViewController.h"
#import "CGHuaFeiChongZhiViewController.h"
#import "CGChongZhiViewController.h"
#import "CGZhuanZhangViewController.h"
#import "CGHuiLvViewController.h"
#import "CGJiaoFeiTypeViewController.h"

#import "HMScannerController.h"
#import "CGShouKuanMaViewController.h"
#import "CGBillQueryViewController.h"

#import "CGSaoMaZhuanZhangViewController.h"
#import "CGHuiDuiTypeViewController.h"

#import "CGZhuanZhangConfirmViewController.h"
#import "CGNoAccountViewController.h"

#import "CGScanResultViewController.h"



@interface CGHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    // 横向 跑马灯
    JhtHorizontalMarquee *_horizontalMarquee;
    BOOL isAccount;
}
@property (nonatomic , strong) UIImageView *isNetWorkView;

@end

@implementation CGHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self requestForm];
    
    //网络状态发生变化的时候的通知方法
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(NetWorkStatesChange:) name:@"netWorkChangeEventNotification"
                                              object:nil];
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
////    if ([[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@isAccount",[GlobalSingleton Instance].currentUser.userid]]) {
//        isAccount = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@isAccount",[GlobalSingleton Instance].currentUser.userid]];
////    }
//
//}

#pragma mark - 网络状态发生变化通知方法
-(void)NetWorkStatesChange:(NSNotification *)sender{
    int networkState = [[sender object] intValue];
    switch (networkState) {
        case -1:
            //未知网络状态
            _isNetWorkView.hidden = NO;
            break;
        case 0:
            //没有网络
//            [baseView setHidden:NO];
//            [self.scrollPageView setHidden:YES];
//
            _isNetWorkView.hidden = NO;
            break;
        case 1:
            //3G或者4G，反正用的是流量
//            [baseView setHidden:YES];
//            [self.scrollPageView setHidden:NO];
//            [self loadData];
            _isNetWorkView.hidden = YES;
            break;
            
        case 2:
            //WIFI网络
//            [baseView setHidden:YES];
//            [self.scrollPageView setHidden:NO];
//            [self loadData];
            _isNetWorkView.hidden = YES;
            break;
            
        default:
            break;
    }
}


- (void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            if([dict[@"data"] count] > 0){
                isAccount = YES;
            }else{
                isAccount = NO;
            }

        }

    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    // 开启跑马灯
    [_horizontalMarquee marqueeOfSettingWithState:MarqueeStart_H];
    isAccount = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@isAccount",[GlobalSingleton Instance].currentUser.userid]];
}


- (void)initNav
{
    [self topBar];
    self.navigationItem.title=@"南方兑换";
    [self.navigationItem setHidesBackButton:YES];
}

- (void)initUI
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
    
    UIButton *saomafu = [[UIButton alloc] init];
    saomafu = [[UIButton alloc] init];
    [saomafu setImage:[UIImage imageNamed:@"扫码付"] forState:UIControlStateNormal];
    [saomafu addTarget:self action:@selector(saomafuClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:saomafu];
    [saomafu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102, 158));
        make.left.mas_equalTo(SCREEN_WIDTH/8);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
    UIButton *shoukuanma = [[UIButton alloc] init];
    shoukuanma = [[UIButton alloc] init];
    [shoukuanma setImage:[UIImage imageNamed:@"收款码"] forState:UIControlStateNormal];
    [shoukuanma addTarget:self action:@selector(shoukuanmaClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:shoukuanma];
    [shoukuanma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102, 158));
        make.right.mas_equalTo(-SCREEN_WIDTH/8);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
//    isnetWork
    
    //跑马灯
//    [self addHorizontalMarquee];
    _horizontalMarquee = [[JhtHorizontalMarquee alloc] initWithFrame:CGRectMake(0, 0+topView.frame.size.height, SCREEN_WIDTH, 40) withSingleScrollDuration:10.0];
    self.horizontalMarquee.text = @" 这是一个跑马灯View，测试一下好不好用1111111111111111！ ";
    [self.view addSubview:self.horizontalMarquee];
    
    _isNetWorkView = [[UIImageView alloc] init];
    _isNetWorkView.frame = CGRectMake(0, 0+topView.frame.size.height, SCREEN_WIDTH, 40);
    _isNetWorkView.image = [UIImage imageNamed:@"isnetWork"];
    _isNetWorkView.hidden = YES;
    [self.view addSubview:_isNetWorkView];
    
    //功能九宫格
    
    
    UIScrollView *jiugonggeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0+topView.frame.size.height+_horizontalMarquee.frame.size.height, SCREEN_WIDTH,377)];// SCREEN_HEIGHT-44-66-topView.frame.size.height-_horizontalMarquee.frame.size.height
    jiugonggeView.backgroundColor = [UIColor whiteColor];
    
    if(IS_IPHONE_5){
        jiugonggeView.contentSize = CGSizeMake(0, 377+44);
    }
    
    [self.view addSubview:jiugonggeView];
    
    //每个Item宽高
    CGFloat W = 80;
    CGFloat H = 100;
    //每行列数
    NSInteger rank = 3;
    //每列间距
    CGFloat rankMargin = (self.view.frame.size.width - rank * W) / (rank);
    //每行间距
//    CGFloat rowMargin = 52;
    CGFloat rowMargin = 20;
    //Item索引 ->根据需求改变索引
    NSUInteger index = 9;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin);
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        //Item top
        CGFloat top = 20;
        
//        UIView *speedView = [[UIView alloc] init];
        UIButton *cellView = [[UIButton alloc ]init];
        if(i == 0){
            [cellView setImage:[UIImage imageNamed:@"withdrawCashIcon"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 1){
            [cellView setImage:[UIImage imageNamed:@"phoneRechageIcon"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 2){
            [cellView setImage:[UIImage imageNamed:@"转账"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 3){
            [cellView setImage:[UIImage imageNamed:@"兑汇"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 4){
            [cellView setImage:[UIImage imageNamed:@"理财"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 5){
            [cellView setImage:[UIImage imageNamed:@"生活"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 6){
            [cellView setImage:[UIImage imageNamed:@"rechageIcon"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 7){
            [cellView setImage:[UIImage imageNamed:@"汇率"] forState:UIControlStateNormal];
            cellView.tag = 7;
        }else if(i == 8){
            [cellView setImage:[UIImage imageNamed:@"查询"] forState:UIControlStateNormal];
            cellView.tag = 8;
        }
        [cellView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        cellView.frame = CGRectMake(X+rankMargin/2, Y+top, W, H);
        [jiugonggeView addSubview:cellView];
    }
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(jiugonggeView.frame.size.width/3, 0, 1, jiugonggeView.frame.size.height)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 0, 1, jiugonggeView.frame.size.height)];
    line2.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, jiugonggeView.frame.size.height/3, SCREEN_WIDTH, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(0, jiugonggeView.frame.size.height/3*2, SCREEN_WIDTH, 1)];
    line4.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [jiugonggeView addSubview:line1];
    [jiugonggeView addSubview:line2];
    [jiugonggeView addSubview:line3];
    [jiugonggeView addSubview:line4];
}



- (void)btnClick:(UIButton *)btn
{
    if(btn.tag == 0){
//        [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
//            if(dict){
//                if([dict[@"data"] count] > 0){
//
//                }else{
//                    [MBProgressHUD showText:@"您没有账户" toView:self.view];
//                }
//
//            }
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];

        if(isAccount){
            CGTiXianTypeViewController *tixiantype = [[CGTiXianTypeViewController alloc] init];
            [self pushViewControllerHiddenTabBar:tixiantype animated:YES];
        }else{
            [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
        }
        
        
    }else if(btn.tag == 1){
        if(isAccount){
            CGHuaFeiChongZhiViewController *vc = [[CGHuaFeiChongZhiViewController alloc] init];
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
        }
        
    }else if(btn.tag == 2){
        if(isAccount){
            CGZhuanZhangViewController *vc = [[CGZhuanZhangViewController alloc] init];
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
        }
        
    }else if(btn.tag == 3){
        if(isAccount){
            CGHuiDuiTypeViewController *vc = [[CGHuiDuiTypeViewController alloc] init];
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
        }
        
    }else if(btn.tag == 4){
        [MBProgressHUD showText:@"功能正在开发中..." toView:self.view];
    }else if(btn.tag == 5){
        if(isAccount){
            CGJiaoFeiTypeViewController *vc = [[CGJiaoFeiTypeViewController alloc] init];
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
        }
        
    }else if(btn.tag == 6){
        if(isAccount){
            CGChongZhiViewController *vc = [[CGChongZhiViewController alloc] init];
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
        }
        
    }else if(btn.tag == 7){
        CGHuiLvViewController *cv = [[CGHuiLvViewController alloc] init];
        [self pushViewControllerHiddenTabBar:cv animated:YES];
    }else if(btn.tag == 8){
        CGBillQueryViewController *cv = [[CGBillQueryViewController alloc] init];
        [self pushViewControllerHiddenTabBar:cv animated:YES];
    }
}
/** 添加 横向 跑马灯 */
- (void)addHorizontalMarquee {
    self.horizontalMarquee.text = @" 这是一个跑马灯View，测试一下好不好用1111111111111111！ ";
    [self.view addSubview:self.horizontalMarquee];
}

#pragma mark - Get
/** 横向 跑马灯 */
- (JhtHorizontalMarquee *)horizontalMarquee {
    if (!_horizontalMarquee) {
        _horizontalMarquee = [[JhtHorizontalMarquee alloc] initWithFrame:CGRectMake(0, 66+140, SCREEN_WIDTH, 40) withSingleScrollDuration:10.0];
    }
    
    return _horizontalMarquee;
}

- (void)saomafuClick {
    NSData *data=[[NSData alloc] initWithBase64EncodedString:[GlobalSingleton Instance].currentUser.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *cardName = [GlobalSingleton Instance].currentUser.username;

    UIImage *avatar;
    if(data == nil){
        avatar = [UIImage imageNamed:@"headImg"];
    }else{
        avatar = [UIImage imageWithData:data];
    }
    
//    RHScanViewController *vc = [RHScanViewController new];
//    vc.isOpenInterestRect = YES;
//    vc.isVideoZoom = YES;
//    [self.navigationController pushViewController:vc animated:YES];

    HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {

        NSDictionary *params =  [stringValue JSONObject];
        if( [[params objectForKey:@"key"] isEqualToString:@"switch"]){
            [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
                if(dict){
                    
//                    clickCloseButton
                    NSMutableArray *result = dict[@"data"];
                    NSLog(@"%@",result);
                    if ([result count] == 0) {
                        CGNoAccountViewController *vc = [[CGNoAccountViewController alloc] init];
                        [self pushViewControllerHiddenTabBar:vc animated:YES];
                    }else{
                        [self zhuanzhangEvent:params];
                    }
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        }else{
            CGScanResultViewController *vc = [[CGScanResultViewController alloc] init];
            vc.stringValue = stringValue;
            [self pushViewControllerHiddenTabBar:vc animated:YES];
//            NSLog(@"%@",stringValue);
        }
        
        //对比扫出来的货币类型和自己账户内的类型是否匹配,如果匹配进入转账界面,如果不匹配直接提示后返回首页
//        [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
//            if(dict){
//
//
//                NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//                NSLog(@"%@",result);
//                if ([result count] == 0) {
//
//                }else{
//
//                    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
////                    if([[[result objectAtIndex:1] objectForKey:@"code"] isEqualToString:@"fail"]){
////                        [MBProgressHUD showText:[[result objectAtIndex:0] objectForKey:@"message"] toView:self.view];
////                    }else{
//                        BOOL flag = NO;
//                        for (int i = 0; i < result.count; i++) {
//
//                            if([[[result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:[params objectForKey:@"type"]]){
//                                flag = YES;
//                            }
//                            [dataArray addObject:[[result objectAtIndex:i] objectForKey:@"countType"]];
//                        }
//
//                        if(flag){
//                            CGSaoMaZhuanZhangViewController *vc = [[CGSaoMaZhuanZhangViewController alloc] init];
//                            vc.moneynum = [params objectForKey:@"num"];
////                            vc.imgdata = data;
//                            vc.type = [params objectForKey:@"type"];
//                            vc.receivecount = [params objectForKey:@"phone"];
//                            vc.username = [params objectForKey:@"username"];//[result objectForKey:@"username"]
//                            [self pushViewControllerHiddenTabBar:vc animated:YES];
//                        }else{
//                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您没有相应账户,是否使用现有账户转账" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                            UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                CGSaoMaZhuanZhangViewController *vc = [[CGSaoMaZhuanZhangViewController alloc] init];
//                                vc.moneynum = [params objectForKey:@"num"];
//                                vc.imgdata = data;
//                                vc.type = [params objectForKey:@"type"];
////                                vc.typeArray = dataArray;
//                                vc.receivecount = [params objectForKey:@"phone"];
//                                vc.username = [params objectForKey:@"username"];//[result objectForKey:@"username"]
//                                [self pushViewControllerHiddenTabBar:vc animated:YES];
//                            }];
//                            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                [self.navigationController popToRootViewControllerAnimated:YES];
//                            }];
//                            [alertController addAction:skipAction];
//                            [alertController addAction:cancelAction];
//                            [self presentViewController:alertController animated:YES completion:nil];
//                        }
////                    }
//                }
//            }
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
        
        


        

    }];
    
//scanner.
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];

    [self showDetailViewController:scanner sender:nil];
}

-(void)zhuanzhangEvent:(NSDictionary *)params{
    [[CGAFHttpRequest shareRequest] getuserbyTelphoneWithtelphone:[params objectForKey:@"phone"] serverSuccessFn:^(id dict) {
        if(dict){
            NSDictionary *result= dict[@"data"];
            NSLog(@"%@",result);
            
            NSData *data=[[NSData alloc] initWithBase64EncodedString:[result objectForKey:@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            
            
            CGSaoMaZhuanZhangViewController *vc = [[CGSaoMaZhuanZhangViewController alloc] init];
            vc.moneynum = [params objectForKey:@"num"];
            vc.imgdata = data;
            vc.type = [params objectForKey:@"type"];
            vc.receivecount = [params objectForKey:@"phone"];
            vc.username = [params objectForKey:@"username"];//[result objectForKey:@"username"]
            [self pushViewControllerHiddenTabBar:vc animated:YES];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}
//-(void)shoukuanmaClick1{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不能识别非本平台的二维码" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alertController addAction:skipAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//}

-(void)shoukuanmaClick{
    if(isAccount){
        CGShouKuanMaViewController *vc = [[CGShouKuanMaViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else{
        [MBProgressHUD showText:@"您没有账户,请先创建账户" toView:self.view];
    }
    
//    CGSaoMaZhuanZhangViewController *vc = [[CGSaoMaZhuanZhangViewController alloc] init];
//    [self pushViewControllerHiddenTabBar:vc animated:YES];
}


@end
