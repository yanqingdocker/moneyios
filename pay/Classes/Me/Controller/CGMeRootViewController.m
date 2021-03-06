//
//  CGMeRootViewController.m
//  pay
//
//  Created by v2 on 2018/8/1.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGMeRootViewController.h"
#import "CGMeRootModel.h"
#import "CGSetViewController.h"//设置
#import "CGMyEmailViewController.h"//我的信箱
#import "CGZhangHuZongLanViewController.h"//账户总览
#import "CGBillQueryViewController.h"//账单查询 收支记录
#import "CGBankCardListViewController.h"//银行卡列表

@interface CGMeRootViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIButton *_headImgBtn;//头像
    UILabel *_nameLab;//用户名称
    UILabel *_lastLoginLab;//最后登录时间
    UILabel * _numLab;//各个功能数字
    UILabel * _functionNameLab;//功能名称
    UILabel *_totalAssets;//总资产
    UILabel *_RMBtotalAssets;//折合总资产
    UILabel *_income;//收入
    UILabel *_spending;//支出
    UILabel *srLine;//收入线
    UILabel *zcLine;//支出线
    
    UILabel * _banknumLab;//银行卡功能数字
}

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) CGMeRootModel *model;
@end

@implementation CGMeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] getPersonCountWithserverSuccessFn:^(id dict) {
                if([[dict objectForKey:@"code"] integerValue] == 1004){
                    _model = [CGMeRootModel objectWithKeyValues:dict[@"data"]];

                    _nameLab.text = [GlobalSingleton Instance].currentUser.username;
                    _lastLoginLab.text = [GlobalSingleton Instance].currentUser.lasttime;//最后登录时间
                    _totalAssets.text = _model.num;//总资产
                    _RMBtotalAssets.text = _model.title;//总资产描述文字


                    [[NSUserDefaults standardUserDefaults] setObject:[GlobalSingleton Instance].currentUser.defaultcount forKey:[NSString stringWithFormat:@"%@defaultCountType",[GlobalSingleton Instance].currentUser.userid]];
                    _income.text = _model.inmoney;//收入
                    _spending.text = _model.outmoney;//支出
                    
                    _banknumLab.text = [NSString stringWithFormat:@"%@",_model.banknum];
                    
                    
                    float xian1 = [_model.inmoney floatValue]/([_model.inmoney floatValue] + [_model.outmoney floatValue]);

                    float xian2 = [_model.outmoney floatValue]/([_model.inmoney floatValue] + [_model.outmoney floatValue]);

                    srLine.frame = CGRectMake(41, 109, xian1 * (SCREEN_WIDTH - 41*2), 5);
                    zcLine.frame = CGRectMake(41 + srLine.frame.size.width, 109, xian2 * (SCREEN_WIDTH - 41*2), 5);
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        });
    });
    
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
    [setBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:setBtn];
    
    
    _headImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 48/2, 69, 48, 48)];
    
    if([GlobalSingleton Instance].currentUser.img){
        NSData *data=[[NSData alloc] initWithBase64EncodedString:[GlobalSingleton Instance].currentUser.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
        [_headImgBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    }else{
        [_headImgBtn setImage:[UIImage imageNamed:@"headImg"] forState:UIControlStateNormal];
    }
    
     
    [_headImgBtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
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
        [botBtn addTarget:self action:@selector(bankCardClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:botBtn];
        
        if(index == 0){
            _banknumLab = [[UILabel alloc] init];
            _banknumLab.font = [UIFont systemFontOfSize:10];
            _banknumLab.textColor = [UIColor whiteColor];
            _banknumLab.textAlignment = NSTextAlignmentCenter;
            _banknumLab.frame = CGRectMake(botLabX, btnMarginY-12, botBtnW, botBtnH);
            _banknumLab.text = @"0";
            [topView addSubview:_banknumLab];
        }else{
            _numLab = [[UILabel alloc] init];
            _numLab.font = [UIFont systemFontOfSize:10];
            _numLab.textColor = [UIColor whiteColor];
            _numLab.textAlignment = NSTextAlignmentCenter;
            _numLab.frame = CGRectMake(botLabX, btnMarginY-12, botBtnW, botBtnH);
            _numLab.text = [NSString stringWithFormat:@"%d",index];
            [topView addSubview:_numLab];
        }
        
        _functionNameLab = [[UILabel alloc] init];
        _functionNameLab.font = [UIFont systemFontOfSize:13];
        _functionNameLab.textColor = [UIColor whiteColor];
        _functionNameLab.textAlignment = NSTextAlignmentCenter;
        _functionNameLab.frame = CGRectMake(botLabX, btnMarginY+10, botBtnW, botBtnH);
        if(index == 0){
            _functionNameLab.text = [NSString stringWithFormat:@"银行卡"];
        }else{
            _functionNameLab.text = [NSString stringWithFormat:@"银行卡%d",index];
        }
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
        botBtn.tag = 2000+index;
        [botBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        
        
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0+topView.frame.size.height+gongnengView.frame.size.height + 6, SCREEN_WIDTH,128+146 + 6)];// SCREEN_HEIGHT-44-66-topView.frame.size.height-_horizontalMarquee.frame.size.height
    scrollView.backgroundColor = [UIColor whiteColor];
    
            if(IS_IPHONE_5){
                scrollView.contentSize = CGSizeMake(0, 128+146 + 6+44);
            }
    
    [self.view addSubview:scrollView];
    
    //账户总览
//    UIView *totalAssetsView = [[UIView alloc] initWithFrame:CGRectMake(0, 304, SCREEN_WIDTH, 128)];
    UIView *totalAssetsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 128)];
    totalAssetsView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:totalAssetsView];
    
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
    //        _totalAssets.text = @"0.00";
    _totalAssets.textAlignment = NSTextAlignmentCenter;
    [totalAssetsView addSubview:_totalAssets];
    
    _RMBtotalAssets = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 200/2, 97, 200, 11)];
    _RMBtotalAssets.font = [UIFont systemFontOfSize:11];
    //        _RMBtotalAssets.text = [NSString stringWithFormat:@"折合成$%@",@"1000000.00"];
    _RMBtotalAssets.textAlignment = NSTextAlignmentCenter;
    [totalAssetsView addSubview:_RMBtotalAssets];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 128, SCREEN_WIDTH, 6);
    line.backgroundColor = RGBCOLOR(245,245,247);
    [scrollView addSubview:line];
    
    //本月收支
//    UIView *benyueshouzhiView = [[UIView alloc] initWithFrame:CGRectMake(0, 442, SCREEN_WIDTH, 146)];
    UIView *benyueshouzhiView = [[UIView alloc] initWithFrame:CGRectMake(0, 134, SCREEN_WIDTH, 146)];
    benyueshouzhiView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:benyueshouzhiView];
    
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
    //        _income.text = @"$26362";
    _income.font = [UIFont systemFontOfSize:17];
    [benyueshouzhiView addSubview:_income];
    
    _spending = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 200, 74, 200, 17)];
    //        _spending.text = @"$16112";
    _spending.font = [UIFont systemFontOfSize:17];
    _spending.textAlignment = NSTextAlignmentRight;
    [benyueshouzhiView addSubview:_spending];
    
    srLine = [[UILabel alloc] initWithFrame:CGRectMake(41, 109, 0.5 * (SCREEN_WIDTH - 41*2), 5)];
    [srLine setBackgroundColor:[UIColor colorWithRed:202.0f/255.0f green:8.0f/255.0f blue:8.0f/255.0f alpha:1.0f]];
    [benyueshouzhiView addSubview:srLine];
    
    zcLine = [[UILabel alloc] initWithFrame:CGRectMake(41 + srLine.frame.size.width, 109, 0.5 * (SCREEN_WIDTH - 41*2), 5)];
    [zcLine setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:154.0f/255.0f blue:153.0f/255.0f alpha:1.0f]];
    [benyueshouzhiView addSubview:zcLine];
}

#pragma mark -头像UIImageview的点击事件-
- (void)headClick {
    //自定义消息框
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
//    sheet.tag = 2550;
//    //显示消息框
//    [sheet showInView:self.view];
    
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

//获取选择的图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [_headImgBtn setImage:image forState:UIControlStateNormal];
//    self.imageView.image = image;
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
//
//    NSLog(@"changdu:%lu",(unsigned long)imageData.length);
    NSData *imageData =[self compressWithMaxLength:100000 image:image];
//    NSLog(@"changdu:%lu",(unsigned long)Datas.length);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
    //上传头像
    [[CGAFHttpRequest shareRequest] uploadimgAllWithimg:encodedImageStr serverSuccessFn:^(id dict) {
        if(dict){
//            NSDictionary *result = dict[@"data"];
            
                [GlobalSingleton Instance].currentUser.img = encodedImageStr;
            

        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"error:%@",error);
        }
    }];

        });
    });
}


//从相机或者相册界面弹出
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self requestForm];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self topBar];
}

-(void)setClick{
    CGSetViewController *vc = [[CGSetViewController alloc] init];
//    vc.defaultCountType = _defaultCountType;
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

-(void)botBtnClick:(UIButton *)btn
{
    if(btn.tag == 2000){
        CGMyEmailViewController *vc = [[CGMyEmailViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
    if(btn.tag == 2002){
        CGBillQueryViewController *vc = [[CGBillQueryViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
    if(btn.tag == 2003){
        CGZhangHuZongLanViewController *vc = [[CGZhangHuZongLanViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
    
}

-(void)bankCardClick:(UIButton *)btn
{
    if(btn.tag == 1000){
        CGBankCardListViewController *vc = [[CGBankCardListViewController alloc] init];
        [self pushViewControllerHiddenTabBar:vc animated:YES];
    }
//    if(btn.tag == 2003){
//        CGZhangHuZongLanViewController *vc = [[CGZhangHuZongLanViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
    
}
@end
