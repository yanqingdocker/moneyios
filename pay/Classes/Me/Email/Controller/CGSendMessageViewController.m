//
//  CGSendMessageViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/29.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGSendMessageViewController.h"

@interface CGSendMessageViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong)UITextField *phone;
@property (nonatomic,strong)UITextField *theme;
@property (nonatomic,strong)UITextView *content;
@property (nonatomic,strong)UILabel *contentLab;
@end

@implementation CGSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)initNav{
    self.navigationItem.title = @"发消息";
    [self setBackButton:YES];
}
//style.layer.borderColor = UIColor(red: 203.0 / 255.0, green: 203.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
//style.layer.borderWidth = 0.5;
-(void)initUI{
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.borderWidth = 0.5;
    phoneView.layer.borderColor = RGBCOLOR(203, 203, 228).CGColor;
    [self.view addSubview:phoneView];
    
    _phone = [[UITextField alloc] initWithFrame:CGRectMake(17, 18, SCREEN_WIDTH - 17*2, 12)];
    _phone.placeholder = @"请输入收件人电话（仅限本平台用户）";
    _phone.font = [UIFont systemFontOfSize:12];
    _phone.delegate = self;
    _phone.borderStyle = UIKeyboardTypeNumberPad;
    [phoneView addSubview:_phone];
    
    UIView *themeView = [[UIView alloc] initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 44)];
    themeView.backgroundColor = [UIColor whiteColor];
    themeView.layer.borderWidth = 0.5;
    themeView.layer.borderColor = RGBCOLOR(203, 203, 228).CGColor;
    [self.view addSubview:themeView];
    
    _theme = [[UITextField alloc] initWithFrame:CGRectMake(17, 18, SCREEN_WIDTH - 17*2, 12)];
    _theme.placeholder = @"请输入邮件主题";
    _theme.font = [UIFont systemFontOfSize:12];
    _theme.delegate = self;
    [themeView addSubview:_theme];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 146, SCREEN_WIDTH, 100)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderWidth = 0.5;
    contentView.layer.borderColor = RGBCOLOR(203, 203, 228).CGColor;
    [self.view addSubview:contentView];
    
    _content = [[UITextView alloc] initWithFrame:CGRectMake(16, 14, SCREEN_WIDTH - 16*2, 146 - 14*2)];
    _content.delegate = self;
//    _content. = @"请输入邮件主题";
    _content.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:_content];
    
    //其次在UITextView上面覆盖个UILable,UILable设置为全局变量。
    _contentLab = [[UILabel alloc] init];
    _contentLab.frame =CGRectMake(20, 23, 100, 12);
    _contentLab.text = @"请输入邮件内容";
    _contentLab.enabled = NO;//lable必须设置为不可用
    _contentLab.backgroundColor = [UIColor clearColor];
    _contentLab.font = [UIFont systemFontOfSize:12];
    _contentLab.textColor = RGBCOLOR(153, 153, 153);
    [contentView addSubview:_contentLab];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(22, 268, SCREEN_WIDTH - 22*2, 44)];
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

//限制UITextView的行数，

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //内容（滚动视图）高度大于一定数值时
    
    if (textView.contentSize.height >80)
        
    {
        
        //删除最后一行的第一个字符，以便减少一行。
        
        textView.text = [textView.text substringToIndex:[textView.text length]-1];
        
        return NO;
        
    }
    
    
    
    return YES;
    
}

-(void)confirmEvent{
    [[CGAFHttpRequest shareRequest] sendCardWithreceivecount:_phone.text title:_theme.text content:_contentLab.text serverSuccessFn:^(id dict) {
        if(dict){
//            NSDictionary *_result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
//            NSLog(@"%@",_result);
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}
@end
