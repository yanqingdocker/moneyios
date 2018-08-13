//
//  CGMeRootViewController.m
//  pay
//
//  Created by v2 on 2018/8/1.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGMeRootViewController.h"

@interface CGMeRootViewController (){
    UIButton *_headImgBtn;//头像
    UILabel *_nameLab;//用户名称
    UILabel *_lastLoginLab;//最后登录时间
    UILabel * _numLab;//各个功能数字
    UILabel * _functionNameLab;//功能名称
    UILabel *_totalAssets;//总资产
    UILabel *_RMBtotalAssets;//折合总资产
    UILabel *_income;//收入
    UILabel *_spending;//支出
    
}

@end

@implementation CGMeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBAR_HEIGHT)];
//    
//    statusBarView.backgroundColor = [UIColor clearColor];
//    
//    [self.view addSubview:statusBarView];
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}
- (void)initNav{
    
}

- (void)initUI{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 214)];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 214)];
    [bgImgView setImage:[UIImage imageNamed:@"mebgImg"]];
    [topView addSubview:bgImgView];
    [self.view addSubview:topView];

    UILabel *meTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 70/2, 35, 70, 15)];
    meTitle.text = @"个人中心";
    meTitle.font = [UIFont systemFontOfSize:16];
    meTitle.textColor = [UIColor whiteColor];
    [topView addSubview:meTitle];
    
    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 15, 35, 15, 15)];
    [setBtn setImage:[UIImage imageNamed:@"setIcon"] forState:UIControlStateNormal];
//    [setBtn addTarget:self action:@selector(setBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:setBtn];
    
    _headImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 48/2, 69, 48, 48)];
    [_headImgBtn setImage:[UIImage imageNamed:@"headImg"] forState:UIControlStateNormal];
    //    [headImgBtn addTarget:self action:@selector(headImgBtn) forControlEvents:UIControlEventTouchUpInside];
    _headImgBtn.layer.cornerRadius=_headImgBtn.frame.size.width/2;//裁成圆角
    _headImgBtn.layer.masksToBounds=YES;
    [topView addSubview:_headImgBtn];
    
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, 127, 100, 13)];
    _nameLab.text = @"用户名称";
    _nameLab.font = [UIFont systemFontOfSize:14];
    _nameLab.textColor = [UIColor whiteColor];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_nameLab];
    
    _lastLoginLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 150/2, 143, 150, 9)];
    _lastLoginLab.text = [NSString stringWithFormat:@"上次登录 %@",@"昨天"];
    _lastLoginLab.font = [UIFont systemFontOfSize:9];
    _lastLoginLab.textColor = [UIColor whiteColor];
    _lastLoginLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_lastLoginLab];
    

    CGFloat botBtnW = SCREEN_WIDTH/4;
    CGFloat botBtnH = 49;
    CGFloat botBtnX = 0;
    int btnColumns = 4;
    CGFloat btnMarginY = 165;
    //间隙 = (view的宽度 - 3 * 宽度) / 4
    CGFloat btnMarginX = (self.view.frame.size.width - btnColumns * botBtnW) / (btnColumns + 1);
    NSInteger aryCount = 4;
    for (int index = 0; index < aryCount; index++) {

        int btnPage = index/btnColumns;
        CGFloat botLabX = btnMarginX + index * (botBtnW + btnMarginX)+btnPage*btnMarginX;
        botBtnX = botBtnW * index;
        
        
        UIButton * botBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        botBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        botBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [botBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        botBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        botBtn.frame = CGRectMake(botBtnX, btnMarginY, botBtnW, botBtnH);
//        [botBtn setTitle:title forState:UIControlStateNormal];
//        botBtn.backgroundColor = [UIColor redColor];
//        [botBtn setTitle:[NSString stringWithFormat:@"银行卡%d",index] forState:UIControlStateNormal];
        botBtn.tag = 1000+index;
//        [botBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:botBtn];
        
        
        _numLab = [[UILabel alloc] init];
        _numLab.font = [UIFont systemFontOfSize:10];
        _numLab.textColor = [UIColor whiteColor];
        _numLab.textAlignment = NSTextAlignmentCenter;
        _numLab.frame = CGRectMake(botLabX, btnMarginY-12, botBtnW, botBtnH);
        _numLab.text = [NSString stringWithFormat:@"%d",index];
        [topView addSubview:_numLab];
        
        _functionNameLab = [[UILabel alloc] init];
        _functionNameLab.font = [UIFont systemFontOfSize:13];
        _functionNameLab.textColor = [UIColor whiteColor];
        _functionNameLab.textAlignment = NSTextAlignmentCenter;
        _functionNameLab.frame = CGRectMake(botLabX, btnMarginY+10, botBtnW, botBtnH);
        _functionNameLab.text = [NSString stringWithFormat:@"银行卡%d",index];
        [topView addSubview:_functionNameLab];
        
    }
    
    //功能栏
    UIView *gongnengView = [[UIView alloc] initWithFrame:CGRectMake(0, 214, SCREEN_WIDTH, 80)];
    gongnengView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:gongnengView];
    
    CGFloat gnbotBtnW = SCREEN_WIDTH/4;
    CGFloat gnbotBtnH = 80;
    CGFloat gnbotBtnX = 0;
    int gnbtnColumns = 4;
    CGFloat gnbtnMarginY = 0;
    //间隙 = (view的宽度 - 3 * 宽度) / 4
    CGFloat gnbtnMarginX = (self.view.frame.size.width - gnbtnColumns * (gnbotBtnW-10)) / (gnbtnColumns + 1);
    NSInteger gnaryCount = 4;
    for (int index = 0; index < gnaryCount; index++) {
        
        int gnbtnPage = index/gnbtnColumns;
        CGFloat gnbotLabX = gnbtnMarginX + index * (gnbotBtnW + gnbtnMarginX)+gnbtnPage*gnbtnMarginX;
        gnbotBtnX = gnbotBtnW * index;
        
        
        UIButton * botBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        botBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        botBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [botBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        botBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        botBtn.frame = CGRectMake(gnbotBtnX, gnbtnMarginY, gnbotBtnW, gnbotBtnH);
        //        [botBtn setTitle:title forState:UIControlStateNormal];
//                botBtn.backgroundColor = [UIColor redColor];
        //        [botBtn setTitle:[NSString stringWithFormat:@"银行卡%d",index] forState:UIControlStateNormal];
        botBtn.tag = 1000+index;
        //        [botBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [gongnengView addSubview:botBtn];
        
        UIImageView *gnImg = [[UIImageView alloc] init];
        gnImg.frame = CGRectMake(gnbotLabX, gnbtnMarginY+20, 51, 45);
//        if(index == 0){
//            gnImg.frame = CGRectMake(gnbotLabX, gnbtnMarginY+20, 25, 43);
//        }else{
//            gnImg.frame = CGRectMake(gnbotLabX, gnbtnMarginY+20, 51, 45);
//        }
        
        gnImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"gongneng%d",index]];
        [gongnengView addSubview:gnImg];
        
        //账户总览
        UIView *totalAssetsView = [[UIView alloc] initWithFrame:CGRectMake(0, 304, SCREEN_WIDTH, 128)];
        totalAssetsView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:totalAssetsView];
        
        UILabel *zhzlLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 60, 14)];
        zhzlLab.text = @"账户总览";
        zhzlLab.font = [UIFont systemFontOfSize:14];
        [totalAssetsView addSubview:zhzlLab];
        
        UIImageView *eyeImg = [[UIImageView alloc] init];
        eyeImg.frame = CGRectMake(74, 13, 15, 15);
        eyeImg.image = [UIImage imageNamed:@"eye_open"];
        [totalAssetsView addSubview:eyeImg];
        
        UILabel *zzcLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50/2, 34, 50, 14)];
        zzcLab.text = @"总资产";
        zzcLab.font = [UIFont systemFontOfSize:14];
        zzcLab.textAlignment = NSTextAlignmentCenter;
        [totalAssetsView addSubview:zzcLab];
        
        _totalAssets = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 200/2, 64, 200, 18)];
        _totalAssets.font = [UIFont systemFontOfSize:18];
        _totalAssets.text = @"$50000.00";
        _totalAssets.textAlignment = NSTextAlignmentCenter;
        [totalAssetsView addSubview:_totalAssets];
        
        _RMBtotalAssets = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 200/2, 97, 200, 11)];
        _RMBtotalAssets.font = [UIFont systemFontOfSize:11];
        _RMBtotalAssets.text = [NSString stringWithFormat:@"折合成$%@",@"1000000.00"];
        _RMBtotalAssets.textAlignment = NSTextAlignmentCenter;
        [totalAssetsView addSubview:_RMBtotalAssets];
        
        //本月收支
        UIView *benyueshouzhiView = [[UIView alloc] initWithFrame:CGRectMake(0, 442, SCREEN_WIDTH, 146)];
        benyueshouzhiView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:benyueshouzhiView];
        
        UILabel *byszLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 21, 60, 14)];
        byszLab.text = @"本月收支";
        byszLab.font = [UIFont systemFontOfSize:14];
        [benyueshouzhiView addSubview:byszLab];
        
        UILabel *srLab = [[UILabel alloc] initWithFrame:CGRectMake(51, 59, 25, 11)];
        srLab.font = [UIFont systemFontOfSize:12];
        srLab.text = @"收入";
        [benyueshouzhiView addSubview:srLab];
        
        UILabel *zcLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 51 - 23, 59, 25, 11)];
        zcLab.font = [UIFont systemFontOfSize:12];
        zcLab.text = @"支出";
        [benyueshouzhiView addSubview:zcLab];
        
        _income = [[UILabel alloc] initWithFrame:CGRectMake(40, 74, 200, 17)];
        _income.text = @"$26362";
        _income.font = [UIFont systemFontOfSize:17];
        [benyueshouzhiView addSubview:_income];
        
        _spending = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 200, 74, 200, 17)];
        _spending.text = @"$16112";
        _spending.font = [UIFont systemFontOfSize:17];
        _spending.textAlignment = NSTextAlignmentRight;
        [benyueshouzhiView addSubview:_spending];
        
        
        UILabel *srLine = [[UILabel alloc] initWithFrame:CGRectMake(41, 109, 0.62 * (SCREEN_WIDTH - 41*2), 5)];
        [srLine setBackgroundColor:[UIColor colorWithRed:202.0f/255.0f green:8.0f/255.0f blue:8.0f/255.0f alpha:1.0f]];
        [benyueshouzhiView addSubview:srLine];
        
        UILabel *zcLine = [[UILabel alloc] initWithFrame:CGRectMake(41 + srLine.frame.size.width, 109, 0.38 * (SCREEN_WIDTH - 41*2), 5)];
        [zcLine setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f]];
        [benyueshouzhiView addSubview:zcLine];
//        26362/(26362 + 16112)
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



@end
