//
//  CGTiXianResultsAlertView.m
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTiXianResultsAlertView.h"

#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间




@interface CGTiXianResultsAlertView()

@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *ContentLB;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *sureBtn;



@end

@implementation CGTiXianResultsAlertView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title alertMessage:(NSString *)msg confrimBolck:(void (^)())confrimBlock cancelBlock:(void (^)())cancelBlock{
    if (self = [super initWithFrame:frame]) {
        [self customUIwith:frame title:title message:msg];
        _sureBlock = confrimBlock;
        _cancleBlock = cancelBlock;
    }
    return self;
}


-(void)customUIwith:(CGRect)frame title:(NSString *)title message:(NSString *)msg{
    UIImageView *bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    //    bgimageview.image = [UIImage imageNamed:@"alertbg"];
    bgimageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgimageview];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.frame.size.width - 20, 20)];
    _titleLB.textColor = [UIColor blackColor];
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLB];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, 46, self.frame.size.width - 20, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    _ContentLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 273, self.frame.size.width - 20, 15)];
    _ContentLB.numberOfLines = 0;
    _ContentLB.textAlignment = NSTextAlignmentCenter;
//    _ContentLB.textColor = [UIColor darkGrayColor];
    _ContentLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:_ContentLB];
    
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _cancleBtn.frame = CGRectMake(self.frame.size.width - 20, 10, 10, 10);
    [self addSubview:_cancleBtn];
    [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];

//    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_cancleBtn setBackgroundImage:[UIImage imageNamed:@"alertCanclebtn"] forState:UIControlStateNormal];
//    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [_cancleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    _cancleBtn.frame = CGRectMake(20, 120, 70, 30);
//    [self addSubview:_cancleBtn];
//    [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *resultsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(89, 104, 108, 108)];
    UIImage *resultsImg = [UIImage imageNamed:@"success"];
    [resultsImgView setImage:resultsImg];
    [self addSubview:resultsImgView];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"alertSuerbtn"] forState:UIControlStateNormal];
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.frame = CGRectMake(150, 120, 70, 30);
//    [self addSubview:_sureBtn];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLB.text = title;
    _ContentLB.text = msg;
    
}

-(void)cancleBtnClick{
    [self hide];
    if (_cancleBlock) {
        _cancleBlock();
    }
}
-(void)sureBtnClick{
    [self hide];
    if (_sureBlock) {
        _sureBlock();
    }
}

-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *iview = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    iview.tag = TagValue;
    iview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [iview addGestureRecognizer:tap];
    iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}


//弹出隐藏
-(void)hide{
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgview) {
                [bgview removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
}
@end
