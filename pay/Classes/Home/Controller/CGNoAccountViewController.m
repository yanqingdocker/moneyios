//
//  CGNoAccountViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/7.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGNoAccountViewController.h"
#import "CGCreatAccountViewController.h"

@interface CGNoAccountViewController ()

@end

@implementation CGNoAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav
{
    
    [self setBackButton:YES];
    self.navigationItem.title=@"账户提示";
}

- (void)initUI
{
    UIImageView * imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(128, 67, 125, 130);
    //    imgView.frame = CGRectMake(120, 62, 128, 72);
    [imgView  setImage:[UIImage imageNamed:@"noAccountImg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    [self viewToCenterXWithView:imgView];//X轴对称
    
    UILabel *tishiLab = [[UILabel alloc] init];
    tishiLab.text = @"提示";
    tishiLab.textColor = RGBCOLOR(51,51,51);
    tishiLab.font = [UIFont systemFontOfSize:22];
    tishiLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tishiLab];
    [tishiLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(imgView.mas_bottom).offset(59);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@21);
        make.width.mas_equalTo(@70);
    }];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"您还没有开通任何账户哦！";
    tipsLab.textColor = RGBCOLOR(51,51,51);
    tipsLab.font = [UIFont systemFontOfSize:16];
    tipsLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLab];
    [tipsLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(tishiLab.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo(@300);
    }];
    
    UIButton *openAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    openAccountBtn.frame = CGRectMake(20, 0+ 15+122+44, SCREEN_WIDTH-20*2, 44);
    [openAccountBtn setTitle:@"开通账户" forState:UIControlStateNormal];
    openAccountBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    openAccountBtn.layer.cornerRadius = 3;
    openAccountBtn.backgroundColor = RGBCOLOR(87,138,243);
    [openAccountBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openAccountBtn];
    [openAccountBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(tipsLab.mas_bottom).offset(45);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.width.mas_equalTo(@44);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    backBtn.frame = CGRectMake(20, 0+ 15+122+44, SCREEN_WIDTH-20*2, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBCOLOR(69,69,69) forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    backBtn.layer.cornerRadius = 3;
    [backBtn.layer setMasksToBounds:YES];
    [backBtn.layer setBorderWidth:0.5];
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 196,197,204, 1 });
//    [backBtn.layer setBorderColor:colorref];//边框颜色
    backBtn.layer.borderColor=RGBCOLOR(196,197,204).CGColor;
    backBtn.backgroundColor = RGBCOLOR(247,247,247);
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(openAccountBtn.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.width.mas_equalTo(@44);
    }];
    
}

-(void)submitClick{
    CGCreatAccountViewController *vc = [[CGCreatAccountViewController alloc] init];
    vc.from = @"noAccount";
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:true];
}


@end
