//
//  CGFeedbackViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/4.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGFeedbackViewController.h"

@interface CGFeedbackViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITextView *content;
@property (nonatomic,strong)UILabel *contentLab;
@end

@implementation CGFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"意见反馈";
    [self setBackButton:YES];
}

-(void)initUI{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(11, 15, SCREEN_WIDTH - 11 *2, 150)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderWidth = 0.5;
    contentView.layer.borderColor = RGBCOLOR(203, 203, 228).CGColor;
    [self.view addSubview:contentView];
    
    _content = [[UITextView alloc] initWithFrame:CGRectMake(16, 14, SCREEN_WIDTH - 16*2 - 11, 150 - 14*2)];
    _content.delegate = self;
    //    _content. = @"请输入邮件主题";
    _content.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:_content];
    
    //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
    _contentLab = [[UILabel alloc] init];
    _contentLab.frame =CGRectMake(20, 23, 150, 12);
    _contentLab.text = @"请填写您的反馈意见";
    _contentLab.enabled = NO;//lable必须设置为不可用
    _contentLab.backgroundColor = [UIColor clearColor];
    _contentLab.font = [UIFont systemFontOfSize:12];
    _contentLab.textColor = RGBCOLOR(153, 153, 153);
    [contentView addSubview:_contentLab];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(19, 188, SCREEN_WIDTH - 19*2, 44)];
    [tixianBtn setTitle:@"提交" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(72,151,239)];//金色247, 195, 109
    [tixianBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [self.view addSubview:tixianBtn];
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _contentLab.hidden = NO;
    }else{
        _contentLab.hidden = YES;
    }
}

-(void)confirmEvent{
//    [[CGAFHttpRequest shareRequest] sendCardWithreceivecount:_phone.text title:_theme.text content:_content.text serverSuccessFn:^(id dict) {
//        if(dict){
//            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            if ([[result objectForKey:@"code"] isEqualToString:@"fail"]) {
//                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
//            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:skipAction];
                [self presentViewController:alertController animated:YES completion:nil];
//            }
//
//        }
//    } serverFailureFn:^(NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//    }];
}

@end
