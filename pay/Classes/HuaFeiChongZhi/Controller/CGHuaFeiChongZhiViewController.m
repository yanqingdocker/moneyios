//
//  CGHuaFeiChongZhiViewController.m
//  pay
//
//  Created by v2 on 2018/8/7.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGHuaFeiChongZhiViewController.h"
#import "CGTopUpDetailViewController.h"
#import "CGConfirmPaymentView.h"
#import "XLPasswordView.h"

@interface CGHuaFeiChongZhiViewController ()<XLPasswordViewDelegate>{
    UIButton *btnView;
    NSMutableArray    *  _listDataArray;
    UITextField *_phoneNum;
    NSString *_amount;
    CGConfirmPaymentView *_confirmPaymentView;
    
    
    NSMutableArray *_result;
    UITextField *_beizhu;
    NSString *_account;
    NSString *_accountID;
    NSString *_countType;
}
@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation CGHuaFeiChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _amount = @"1";//默认金额
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            if ([_result count] == 0) {
                
            }else{
                if([[[_result objectAtIndex:0] objectForKey:@"code"] isEqualToString:@"fail"]){
                    [MBProgressHUD showText:[[_result objectAtIndex:0] objectForKey:@"message"] toView:self.view];
                }else{
                    
                    _countType = [[_result objectAtIndex:0] objectForKey:@"countType"];
//                    _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
                    
                    
                    _array  = [[NSMutableArray alloc] init];
                    for (int i = 0; i < _result.count; i++) {
                        [_array addObject:[NSString stringWithFormat:@"%@",[[_result objectAtIndex:i] objectForKey:@"countType"]]];
                    }
                    _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
                }
            }
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (void)initNav{
    self.navigationItem.title = @"话费充值";
    [self setBackButton:YES];
    
    UIButton *chongzhijiluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chongzhijiluBtn.frame = CGRectMake(0, 0, 15, 15);
    chongzhijiluBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    [chongzhijiluBtn setTitle:@"充值记录" forState:UIControlStateNormal];
    [chongzhijiluBtn addTarget:self action:@selector(jiluEven) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chongzhijiluBtn];
}

- (void)initUI{
    _listDataArray = [NSMutableArray array];
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 520 - 0);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *quhaoLab = [[UILabel alloc] init];
    quhaoLab.frame = CGRectMake(16, 16, 120, 11);
    quhaoLab.font = [UIFont systemFontOfSize:15];
    quhaoLab.text = @"中国 +86";
    [bgView addSubview:quhaoLab];
    
    _phoneNum = [[UITextField alloc] init];
    _phoneNum.placeholder = @"请输入手机号";
    _phoneNum.font = [UIFont systemFontOfSize:33];
    _phoneNum.frame = CGRectMake(17, 47, SCREEN_WIDTH - 17*2, 27);
    [bgView addSubview:_phoneNum];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 93, SCREEN_WIDTH, 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    
    UILabel *chonghuafeiLab = [[UILabel alloc] init];
    chonghuafeiLab.frame = CGRectMake(18, 127, 120, 17);
    chonghuafeiLab.font = [UIFont systemFontOfSize:18];
    chonghuafeiLab.text = @"充话费";
    [bgView addSubview:chonghuafeiLab];
    
    UIView *jiugonggeView = [[UIView alloc] initWithFrame:CGRectMake(0, 164, SCREEN_WIDTH, 69*2+20)];
//    jiugonggeView.backgroundColor = [UIColor yellowColor];
    [bgView addSubview:jiugonggeView];
    
    //每个Item宽高
    CGFloat W = 104;
    CGFloat H = 69;
    //每行列数
    NSInteger rank = 3;
    //每列间距
    CGFloat rankMargin = (self.view.frame.size.width - rank * W) / (rank);
//    CGFloat rankMargin = 15;
    //每行间距
    //    CGFloat rowMargin = 52;
    CGFloat rowMargin = 20;
    //Item索引 ->根据需求改变索引
    NSUInteger index = 6;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin);
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        
        btnView = [[UIButton alloc ]init];
        [btnView setTitleColor:RGBCOLOR(26,132,207) forState:UIControlStateNormal];
        [btnView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnView.layer.cornerRadius = 3;
        btnView.layer.borderColor = RGBCOLOR(26,132,207).CGColor;
        btnView.layer.borderWidth = 1.5;
        btnView.frame = CGRectMake(X+rankMargin/2, Y, W, H);
        
        [btnView reloadInputViews];
        
        if(i == 0){
            [btnView setTitle:@"1" forState:UIControlStateNormal];
            [btnView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnView setBackgroundColor:RGBCOLOR(26,132,207)];
            btnView.tag = i;
        }else if(i == 1){
            [btnView setTitle:@"5" forState:UIControlStateNormal];
            btnView.tag = i;
        }else if(i == 2){
            [btnView setTitle:@"10" forState:UIControlStateNormal];
            btnView.tag = i;
        }else if(i == 3){
            [btnView setTitle:@"20" forState:UIControlStateNormal];
            btnView.tag = i;
        }else if(i == 4){
            [btnView setTitle:@"50" forState:UIControlStateNormal];
            btnView.tag = i;
        }else if(i == 5){
            [btnView setTitle:@"100" forState:UIControlStateNormal];
            btnView.tag = i;
        }
        [jiugonggeView addSubview:btnView];
        
        [_listDataArray addObject:btnView];
    }
    
    UIButton *paymentBtn = [[UIButton alloc] init];
    paymentBtn.frame = CGRectMake(48, 421, SCREEN_WIDTH - 48*2, 39);
    [paymentBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [paymentBtn addTarget:self action:@selector(paymentEvent) forControlEvents:UIControlEventTouchUpInside];
    paymentBtn.layer.cornerRadius = 5;
    [paymentBtn setBackgroundColor:RGBCOLOR(26,132,207)];
    [self.view addSubview:paymentBtn];
}

- (void)btnClick:(UIButton *)btn
{
    for (int i = 0; i<_listDataArray.count; i++) {
        if(i == btn.tag){
            [_listDataArray[btn.tag] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_listDataArray[btn.tag] setBackgroundColor:RGBCOLOR(26,132,207)];
        }else{
            [_listDataArray[i] setTitleColor:RGBCOLOR(26,132,207) forState:UIControlStateNormal];
            [_listDataArray[i] setBackgroundColor:[UIColor whiteColor]];
        }
        
    }
    if(btn.tag == 0){
        _amount = @"1";
    }else if(btn.tag == 1){
        _amount = @"5";
    }else if(btn.tag == 2){
        _amount = @"10";
    }else if(btn.tag == 3){
        _amount = @"20";
    }else if(btn.tag == 4){
        _amount = @"50";
    }else if(btn.tag == 5){
        _amount = @"100";
    }
}

- (void)paymentEvent
{
    _confirmPaymentView = [[CGConfirmPaymentView alloc]init];
    _confirmPaymentView.cellTextLabel1 = @"充值号码";
    _confirmPaymentView.cellTextLabel2 = @"付款方式";
    _confirmPaymentView.amount = _amount;
    _confirmPaymentView.phoneNum = _phoneNum.text;
    _confirmPaymentView.dataArray = _result;
    [_confirmPaymentView showInView:self.view];
    //            __weak __typeof(self)wself = self;
    __block CGHuaFeiChongZhiViewController *  blockSelf = self;
    _confirmPaymentView.selectbankcardblock = ^(NSString *str){
        _accountID = str;
        XLPasswordView *passwordView = [XLPasswordView passwordView];
        passwordView.delegate = blockSelf;
        [passwordView showPasswordInView:blockSelf.view];
    };
}

- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
    //    NSLog(@"输入密码位数已满,在这里做一些事情,例如自动校验密码");
    [[CGAFHttpRequest shareRequest] payMentWithcountId:_accountID cardNum:_amount phone:_phoneNum.text payPwd:password serverSuccessFn:^(id dict) {
        if(dict){
            
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]){
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
                [passwordView clearPassword];
            }
            if([[result objectForKey:@"code"] isEqualToString:@"success"]){
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"充值成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                [alertController addAction:skipAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (void)jiluEven{
    CGTopUpDetailViewController *tudvc = [[CGTopUpDetailViewController alloc] init];
    [self pushViewControllerHiddenTabBar:tudvc animated:YES];
}

@end
