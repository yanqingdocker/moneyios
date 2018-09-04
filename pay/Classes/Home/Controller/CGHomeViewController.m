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
//要删
#import "CGJiaoYiDetailsViewController.h"

@interface CGHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    // 横向 跑马灯
    JhtHorizontalMarquee *_horizontalMarquee;
}

@end

@implementation CGHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBarController.tabBar.hidden=NO;
//    CGHomeViewController *tabbar = [[CGHomeViewController alloc] init];
//    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
}

- (void)viewWillAppear:(BOOL)animated{
    // 开启跑马灯
    [_horizontalMarquee marqueeOfSettingWithState:MarqueeStart_H];
//    self.tabBarController.tabBar.hidden=NO;

}


- (void)initNav
{
//    self.tabBarController.tabBar.hidden=NO;
    

    [self topBar];
    self.navigationItem.title=@"南方兑换";
    [self.navigationItem setHidesBackButton:YES];
//    self.tabBarController.tabBar.hidden=NO;
    
    

}

- (void)initUI
{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
//    topView.backgroundColor = [UIColor colorWithHexString:@"0d0d0d"];
//    topView.backgroundColor = RGBCOLOR(38, 38, 38);
    topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topView];
    
    UIButton *saomafu = [[UIButton alloc] init];
    saomafu = [[UIButton alloc] init];
    [saomafu setImage:[UIImage imageNamed:@"扫码付"] forState:UIControlStateNormal];
    [saomafu addTarget:self action:@selector(saomafuClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:saomafu];
    [saomafu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102, 158));
        make.left.mas_equalTo(60);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
    UIButton *shoukuanma = [[UIButton alloc] init];
    shoukuanma = [[UIButton alloc] init];
    [shoukuanma setImage:[UIImage imageNamed:@"收款码"] forState:UIControlStateNormal];
    [shoukuanma addTarget:self action:@selector(shoukuanmaClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:shoukuanma];
    [shoukuanma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102, 158));
        make.right.mas_equalTo(-60);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
    //跑马灯
//    [self addHorizontalMarquee];
    _horizontalMarquee = [[JhtHorizontalMarquee alloc] initWithFrame:CGRectMake(0, 0+topView.frame.size.height, SCREEN_WIDTH, 40) withSingleScrollDuration:10.0];
    self.horizontalMarquee.text = @" 这是一个跑马灯View，测试一下好不好用1111111111111111！ ";
    [self.view addSubview:self.horizontalMarquee];
    
    //功能九宫格
//    UIView *jiugonggeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+topView.frame.size.height+_horizontalMarquee.frame.size.height, SCREEN_WIDTH, SCREEN_WIDTH-44-66+topView.frame.size.height)];//iPhone8适配
    
    UIView *jiugonggeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0+topView.frame.size.height+_horizontalMarquee.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-44-66-topView.frame.size.height-_horizontalMarquee.frame.size.height)];
    jiugonggeView.backgroundColor = [UIColor whiteColor];
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
            [cellView setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 1){
            [cellView setImage:[UIImage imageNamed:@"话费"] forState:UIControlStateNormal];
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
            [cellView setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
            cellView.tag = i;
        }else if(i == 7){
            [cellView setImage:[UIImage imageNamed:@"汇率"] forState:UIControlStateNormal];
            cellView.tag = 7;
        }else if(i == 8){
            [cellView setImage:[UIImage imageNamed:@"查询"] forState:UIControlStateNormal];
            cellView.tag = 8;
        }
        [cellView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cellView.frame = CGRectMake(X+25, Y+top, W, H);
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
        CGTiXianTypeViewController *tixiantype = [[CGTiXianTypeViewController alloc] init];
        [self pushViewControllerHiddenTabBar:tixiantype animated:YES];
        
    }else if(btn.tag == 1){
        CGHuaFeiChongZhiViewController *vc = [[CGHuaFeiChongZhiViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else if(btn.tag == 2){
        CGZhuanZhangViewController *vc = [[CGZhuanZhangViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else if(btn.tag == 3){
        CGHuiDuiTypeViewController *vc = [[CGHuiDuiTypeViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
        
//        NSLog(@"%@",@"创建账户");
//        [[CGAFHttpRequest shareRequest] createCountWithcountType:@"countType" payPwd:@"payPwd" serverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
    }else if(btn.tag == 4){
//        NSLog(@"%@",@"修改账户状态");
//        [[CGAFHttpRequest shareRequest] startOrstopCountWithID:@"13950357177" State:@"0" serverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
        
    }else if(btn.tag == 5){
        CGJiaoFeiTypeViewController *vc = [[CGJiaoFeiTypeViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
//        [[CGAFHttpRequest shareRequest] getuserWithserverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
    }else if(btn.tag == 6){
        CGChongZhiViewController *vc = [[CGChongZhiViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }else if(btn.tag == 7){
        CGHuiLvViewController *cv = [[CGHuiLvViewController alloc] init];
        [self pushViewControllerHiddenTabBar:cv animated:YES];
//        [[CGAFHttpRequest shareRequest] resetpwdmodeWitholdpassword:@"123456" newpassword:@"123456" serverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
    }else if(btn.tag == 8){
        CGBillQueryViewController *cv = [[CGBillQueryViewController alloc] init];
        [self pushViewControllerHiddenTabBar:cv animated:YES];
        
//        NSDictionary *song1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                               @"bankcard",@"6226661701682969",
//                               @"username",@"林豪威尔",
//                               @"idcard",@"350182918911171596",
//                               @"phone",@"13625031117",
//                               @"address",@"福州湖东支行",
//                               @"banktype",@"中国光大银行",
//                               nil];
        
        //兑换接口
//        NSDictionary *song2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                               @"",@"srcountid",
//                               @"",@"destcountid",
//                               @"",@"srcmoney",
//                               @"",@"destmoney",
//                               @"",@"paypwd",
//                               nil];

        
//        NSDictionary *song = [NSDictionary dictionaryWithObjectsAndKeys:
//                              @"测试",@"username",
//                              @"4012",@"idcard",
//                              @"Tom",@"birthday",
//                              @"测试",@"email",
//                              @"4012",@"address",
//                              nil];
//
//        NSError *error;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:song options:NSJSONWritingPrettyPrinted error:&error];
//        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"json data:%@",json);
//
//
//        [[CGAFHttpRequest shareRequest] authenticationWithdatas:json serverSuccessFn:^(id dict) {
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",result);
//
//        } serverFailureFn:^(NSError *error) {
//            if(error){
//                NSLog(@"%@",error);
//            }
//        }];
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
        
//        _horizontalMarquee.tag = 100;
//        // 添加点击手势
//        UITapGestureRecognizer *htap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marqueeTapGes:)];
//        [_horizontalMarquee addGestureRecognizer:htap];
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

    HMScannerController *scanner = [HMScannerController scannerWithCardName:cardName avatar:avatar completion:^(NSString *stringValue) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:stringValue message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];

        NSDictionary *params =  [stringValue JSONObject];

        NSLog(@"%@",[params objectForKey:@"phone"]);

        [[CGAFHttpRequest shareRequest] getuserbyTelphoneWithtelphone:[params objectForKey:@"phone"] serverSuccessFn:^(id dict) {
            if(dict){
                NSDictionary *result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                NSLog(@"%@",result);

                NSData *data=[[NSData alloc] initWithBase64EncodedString:[result objectForKey:@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];


                CGZhuanZhangConfirmViewController *vc = [[CGZhuanZhangConfirmViewController alloc] init];
//                        vc.params = result;
                vc.moneynum = [params objectForKey:@"moneynum"];
                vc.imgdata = data;
                vc.receivecount = [params objectForKey:@"phone"];
                vc.username = [params objectForKey:@"username"];//[result objectForKey:@"username"]
                [self pushViewControllerHiddenTabBar:vc animated:YES];
            }
        } serverFailureFn:^(NSError *error) {
            if(error){
                NSLog(@"%@",error);
            }
        }];




//        CGZhuanZhangConfirmViewController *vc = [[CGZhuanZhangConfirmViewController alloc] init];
//        vc.moneynum = @"1";
//        vc.imgdata = data;
//        vc.receivecount = @"13950357177";
//        vc.username = @"名称";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];


    }];

    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];

    [self showDetailViewController:scanner sender:nil];

//    CGJiaoYiDetailsViewController  *vc = [[CGJiaoYiDetailsViewController alloc] init];
//    vc.liushuiID = @"20180815113937493";
//    [self pushViewControllerHiddenTabBar:vc animated:YES];
}


-(void)shoukuanmaClick{
    CGShouKuanMaViewController *vc = [[CGShouKuanMaViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
    
//    CGSaoMaZhuanZhangViewController *vc = [[CGSaoMaZhuanZhangViewController alloc] init];
//    [self pushViewControllerHiddenTabBar:vc animated:YES];
}
@end
