//
//  CGShouKuanMaViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/24.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGShouKuanMaViewController.h"
#import "HMScannerController.h"
#import "CGShouKuanSheZhiViewController.h"

@interface CGShouKuanMaViewController (){
    UILabel *_amountLab;
    UIImage *_avatar;
}

@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation CGShouKuanMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBCOLOR(69, 86, 103);
    [self requestForm];
}

- (void)requestForm{
    
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            
            NSDictionary *_result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            
//            _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
//            //            _nameArray = [NSArray arrayWithObjects:@"USD",@"CNY",nil];
//            //            NSArray *_nameArray = [[NSArray alloc] init];
//            _array  = [[NSMutableArray alloc] init];
//            for (int i = 0; i < _result.count; i++) {
//                [_array addObject:[NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:i] objectForKey:@"cardId"],[[_result objectAtIndex:i] objectForKey:@"countType"]]];
//            }
//            _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
//            [_tableView reloadData];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
    
}

- (void)initNav
{

    [self setBackButton:YES];
    self.navigationItem.title=@"收款";
}

- (void)initUI
{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(15, 15, SCREEN_WIDTH - 15*2, 480);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"扫描二维码向我付款";
    titleLab.frame =CGRectMake(0, 15, bgView.frame.size.width , 15);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLab];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame =CGRectMake(0, 50, bgView.frame.size.width , 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    
    NSData *data=[[NSData alloc] initWithBase64EncodedString:[GlobalSingleton Instance].currentUser.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[GlobalSingleton Instance].currentUser.phone forKey:@"phone"];//转入账户的手机号
//    [dic setObject:img forKey:@"img"];//头像
    [dic setObject:[GlobalSingleton Instance].currentUser.username forKey:@"username"];//用户名
    
    if(data == nil){
        _avatar = [UIImage imageNamed:@"headImg"];
    }else{
        _avatar = [UIImage imageWithData:data];
    }
    _imageView = [[UIImageView alloc] init];
    
    [bgView addSubview:_imageView];
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(bgView.mas_left).mas_offset(40);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-40);
        make.top.equalTo(bgView).offset(70);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(_imageView.mas_width);
    }];
    
    [HMScannerController cardImageWithCardName:[self convertToJsonData:dic] avatar:_avatar scale:0.2 completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    _amountLab = [[UILabel alloc] init];
//    _amountLab.text = @"12232414";
    _amountLab.textColor = [UIColor blackColor];
    _amountLab.textAlignment = NSTextAlignmentCenter;
    _amountLab.font = [UIFont systemFontOfSize:22];
    _amountLab.hidden = YES;
    [bgView addSubview:_amountLab];
    [_amountLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@200);
    }];
    
    UILabel *divider = [[UILabel alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:divider];
    [divider mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_imageView.mas_bottom).offset(50);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@1);
    }];

    UIButton *saveimageBtn = [[UIButton alloc] init];
    [saveimageBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [saveimageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveimageBtn addTarget:self action:@selector(saveimageClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:saveimageBtn];
    [saveimageBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_imageView.mas_bottom).offset(57);
        make.right.equalTo(divider.mas_left).offset(-50);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@80);
    }];
    
    UIButton *receivingsetBtn = [[UIButton alloc] init];
    [receivingsetBtn setTitle:@"收款设置" forState:UIControlStateNormal];
    [receivingsetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [receivingsetBtn addTarget:self action:@selector(receivingsetClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:receivingsetBtn];
    [receivingsetBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_imageView.mas_bottom).offset(57);
        make.left.equalTo(divider.mas_right).offset(50);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@80);
    }];
    
    UIButton *jiaoyijiluBtn = [[UIButton alloc] init];
    [jiaoyijiluBtn setTitle:@"交易记录" forState:UIControlStateNormal];
    [jiaoyijiluBtn addTarget:self action:@selector(jiaoyijiluClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jiaoyijiluBtn];
    [jiaoyijiluBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(bgView.mas_bottom).offset(13);
        
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@80);
    }];
}

-(void)saveimageClick{
    [self loadImageFinished:self.imageView.image];
}
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
//    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (error) {
        [MBProgressHUD showText:@"保存失败" toView:self.view];
    }else{
        [MBProgressHUD showText:@"保存成功" toView:self.view];
    }
}

-(void)receivingsetClick{
    CGShouKuanSheZhiViewController *vc = [[CGShouKuanSheZhiViewController alloc] init];
    vc.selectbankcardblock = ^(NSString *str){
        NSString * moneynum = [str substringFromIndex:1];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[GlobalSingleton Instance].currentUser.phone forKey:@"phone"];//转入账户的手机号
        [dic setObject:moneynum forKey:@"moneynum"];//收款金额
//        [dic setObject:[GlobalSingleton Instance].currentUser.img forKey:@"img"];//头像
        [dic setObject:[GlobalSingleton Instance].currentUser.username forKey:@"username"];//用户名
        
        
        _amountLab.text = str;//¥
        _amountLab.hidden = NO;
        [HMScannerController cardImageWithCardName:[self convertToJsonData:dic] avatar:_avatar scale:0.2 completion:^(UIImage *image) {
            self.imageView.image = image;
        }];
    };
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

-(void)jiaoyijiluClick{
//    CGShouKuanSheZhiViewController *vc = [[CGShouKuanSheZhiViewController alloc] init];
//    [self pushViewControllerHiddenTabBar:vc animated:YES];
    
    [[CGAFHttpRequest shareRequest] queryCountWithID:@"61" serverSuccessFn:^(id dict) {
        if(dict){
            
            
            NSDictionary *_result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}
@end
