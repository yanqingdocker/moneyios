//
//  CGAilpayRechargeViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/18.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGAilpayRechargeViewController.h"
#import <WebKit/WebKit.h>
#import "CGSelectAccountTableViewCell.h"
#import "CGTitleAndTextTableViewCell.h"
#import "CGBankCardTopupTableViewCell.h"
#import "CGConfirmPaymentView.h"
#import "XLPasswordView.h"

@interface CGAilpayRechargeViewController ()<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *_tableView;
    UIButton *_submitBtn;
    
    NSString *_amount;
    NSString *_password;
    UIImageView *_moneyTypeIcon;
    UITextField *_moneyNum;
    NSMutableArray *_dataArray;
    NSString *_countType;
    NSString *_countId;
    //    NSMutableArray *_bankcardArray;
    NSString *_bankCard;
}

//@property (strong, nonatomic) CGConfirmPaymentView *confirmPaymentView;
@property (strong, nonatomic) UIView *footerView;
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (nonatomic,strong) WKWebView *wkWebView;
@end

@implementation CGAilpayRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
    
}

- (void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            _dataArray = dict[@"data"];
            NSLog(@"%@",_dataArray);
            _countType = [[_dataArray objectAtIndex:0] objectForKey:@"countType"];
            _countId = [[_dataArray objectAtIndex:0] objectForKey:@"id"];
            [_tableView reloadData];
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
    
}

- (void)initNav{
    self.navigationItem.title = @"支付宝充值";
    [self setBackButton:YES];
}

//- (void)initUI{
////    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
////    //注册js方法
////    config.userContentController = [[WKUserContentController alloc]init];
////    //webViewAppShare这个需保持跟服务器端的一致，服务器端通过这个name发消息，客户端这边回调接收消息，从而做相关的处理
////    [config.userContentController addScriptMessageHandler:self name:@"cibApp"];
//
//
//
//
//
//    UIWebView *uiWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];
//    [uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.31.12:8888/api/orderPay?money=50&countid=61"]]];
//    uiWebView.delegate = self;
//    [self.view addSubview:uiWebView];
//
//
////    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];//configuration:config
////    [_wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
////    _wkWebView.allowsBackForwardNavigationGestures =YES;
////    [_wkWebView setNavigationDelegate:self];
////    [_wkWebView setUIDelegate:self];
////    [_wkWebView setMultipleTouchEnabled:YES];
////    [_wkWebView setAutoresizesSubviews:YES];
////    _wkWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
////    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.31.12:8888/api/orderPay?money=50&countid=61"]]];
////    [self.view addSubview:_wkWebView];
//}

- (void)initUI{
    UIView *bgView = [[UIView alloc] init];
    //    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *czjeLab = [[UILabel alloc] init];
    czjeLab.frame = CGRectMake(18  , 12, 80, 14);
    czjeLab.font = [UIFont systemFontOfSize:15];
    //    czjeLab.textColor = RGBCOLOR(216, 74, 74);
    czjeLab.text = @"充值金额";
    [bgView addSubview:czjeLab];
    
    _moneyTypeIcon = [[UIImageView alloc] init];
    _moneyTypeIcon.frame = CGRectMake(18, 63, 25, 25);
    //    if([_type isEqualToString:@"CNY"]){
    _moneyTypeIcon.image = [UIImage imageNamed:@"CNYIcon"];
    //    }else if([_type isEqualToString:@"USD"]){
    //        _moneyTypeIcon.image = [UIImage imageNamed:@"USDIcon"];
    //    }
    [bgView addSubview:_moneyTypeIcon];
    
    _moneyNum = [[UITextField alloc] init];
    _moneyNum.frame = CGRectMake(18+25+5 , 50, SCREEN_WIDTH -18*2 - 30, 44);
    _moneyNum.delegate =self;
    _moneyNum.font = [UIFont systemFontOfSize:40];
    _moneyNum.placeholder = [NSString stringWithFormat:@"0.0000"];
    _moneyNum.clearButtonMode = UITextFieldViewModeAlways;
    _moneyNum.keyboardType = UIKeyboardTypeDecimalPad;
    //    [_moneyNum addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:_moneyNum];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 7)];
    line.backgroundColor = RGBCOLOR(245,245,247);
    [bgView addSubview:line];
    
    UILabel *czdLab = [[UILabel alloc] init];
    czdLab.frame = CGRectMake(18  , 118, 80, 16);
    czdLab.font = [UIFont systemFontOfSize:16];
    czdLab.text = @"充值到";
    [bgView addSubview:czdLab];
    
    CGRect tableframe=CGRectMake(0, 146, SCREEN_WIDTH,SCREEN_HEIGHT - 146 -NAVIGATIONBAR_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [self addFooterView];
    //
    //    _submitBtn = [[UIButton alloc] init];
    //    _submitBtn.frame = CGRectMake(18, 0 + 15 + 216, SCREEN_WIDTH-18*2, 44);
    //    _submitBtn.layer.cornerRadius = 3;
    //    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    //    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    //    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.view addSubview:_submitBtn];
}

- (void)addFooterView {
    if (!_footerView) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor clearColor];
        footerView.frame = CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 80.f);
        
        CGFloat sureBtnH = 40;
        CGFloat sureBtnY = 20;
        UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(20, sureBtnY, self.view.frame.size.width - 40, sureBtnH);
        //        [sureBtn setTitleColor:RGBCOLOR(72,135,239) forState:UIControlStateNormal];
        //        [sureBtn setTitleColor:RGBCOLOR(72,135,239) forState:UIControlStateNormal];
        sureBtn.backgroundColor = RGBCOLOR(72,135,239);
        //        [sureBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
        [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
        //        [sureBtn setBackgroundImage:[UIImage imageNamed:@"dottedLine"] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
        [footerView addSubview:sureBtn];
        
        _footerView = footerView;
    }
    
    _tableView.tableFooterView = _footerView;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        if(indexPath.row == 0){
    //            CGSelectAccountTableViewCell *cell = [CGSelectAccountTableViewCell cellForTableView:tableView];
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //            cell.titleLab.text = [NSString stringWithFormat:@"请选择充值账户"];
    //            cell.accountLab.text = @"1258424(人民币)";
    //            return cell;
    //        }
    //    CGTitleAndTextTableViewCell *cell = [CGTitleAndTextTableViewCell cellForTableView:tableView];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        if(indexPath.row == 1){
    //
    //            cell.titleLab.text = [NSString stringWithFormat:@"充值金额"];
    //            cell.contentText.placeholder = @"请输入充值金额";
    //            cell.contentText.borderStyle = UIKeyboardTypeNumberPad;
    //            cell.contentText.delegate = self;
    //            cell.contentText.tag = 1001;
    //        }
    //        if(indexPath.row == 2){
    ////            CGTitleAndTextTableViewCell *cell = [CGTitleAndTextTableViewCell cellForTableView:tableView];
    ////            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //            cell.titleLab.text = [NSString stringWithFormat:@"资金密码"];
    //            cell.contentText.placeholder = @"请输入资金密码";
    //            cell.contentText.secureTextEntry = YES;
    //            cell.contentText.delegate = self;
    //            cell.contentText.tag = 1002;
    //        }
    //    static NSString *identifire = @"CellID";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    }
    //
    //
    //    UIImageView *moneyIcon = [[UIImageView alloc] init];
    //    moneyIcon.frame = CGRectMake(14, 10, 40, 40);
    //    [cell addSubview:moneyIcon];
    //
    //    UILabel *selectLab = [[UILabel alloc] init];
    //    selectLab.textColor = RGBCOLOR(102, 102, 102);
    //    selectLab.font = [UIFont systemFontOfSize:18];
    //    [cell addSubview:selectLab];
    //    [selectLab mas_remakeConstraints:^(MASConstraintMaker *make){
    //        make.left.equalTo(moneyIcon.mas_right).offset(10);
    //        make.centerY.equalTo(cell);
    //        make.height.mas_equalTo(@17);
    //        make.width.mas_equalTo(@200);
    //    }];
    //
    //    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"CNY"]) {
    //        moneyIcon.image = [UIImage imageNamed:@"selectCNY"];
    //        selectLab.text = @"人民币(CNY)充值";
    //
    //    }
    //    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"USD"]) {
    //        moneyIcon.image = [UIImage imageNamed:@"selectUSD"];
    //        selectLab.text = @"美元(USD)充值";
    //    }
    //
    //    UIImageView * selectImg = [[UIImageView alloc]init];
    //    selectImg.frame = CGRectMake(SCREEN_WIDTH - 15 -22 ,
    //                           22,
    //                           22,
    //                           22);
    //    [cell addSubview:selectImg];
    
    CGBankCardTopupTableViewCell *cell = [CGBankCardTopupTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __block CGBankCardTopupTableViewCell *  weakCell = cell;
    
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"CNY"]) {
        cell.moneyTypeIcon.image = [UIImage imageNamed:@"selectCNY"];
        cell.moneyTypeLab.text = @"人民币(CNY)充值";
        
    }
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"USD"]) {
        cell.moneyTypeIcon.image = [UIImage imageNamed:@"selectUSD"];
        cell.moneyTypeLab.text = @"美元(USD)充值";
    }
    
    //当上下滑动时因为cell复用，需要判断哪个选择了
    if (_selIndex == indexPath) {
        weakCell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    }else{
        weakCell.selectImg.image = [UIImage imageNamed:@"unselectIcon"];
    }
    if (_selIndex == nil && indexPath.row == 0) {
        weakCell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    _countType = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
    _countId = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    CGBankCardTopupTableViewCell *celld = [tableView cellForRowAtIndexPath:_selIndex];
    celld.selectImg.image = [UIImage imageNamed:@"unselectIcon"];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    CGBankCardTopupTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    [_tableView reloadData];
}

-(void)nextClick{
    [self.view endEditing:YES];
//    if([StringUtil isNullOrEmptyOrZero:_moneyNum.text]){
//        [MBProgressHUD showText:@"请输入充值金额" toView:self.view];
//        return;
//    }
//    else if([_moneyNum.text intValue] < 50){
//        [MBProgressHUD showText:@"充值金额不得低于50" toView:self.view];
//        return;
//    }
    
    
    [self.view endEditing:YES];
    
    [MBProgressHUD showMessage:@"跳转支付宝中"];
    UIWebView *uiWebView = [[UIWebView alloc] init];
//    uiWebView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?money=%@&countid=%@",BASEURL,ORDERPAY,@"10",_countId]]]];//@"http://192.168.31.12:8888/api/orderPay?money=50&countid=61"
    uiWebView.delegate = self;
    
    [self.view addSubview:uiWebView];

//    _confirmPaymentView = [[CGConfirmPaymentView alloc]init];
//    _confirmPaymentView.cellTextLabel1 = @"订单信息";
//    _confirmPaymentView.cellTextLabel2 = @"付款方式";
//    _confirmPaymentView.amount = _moneyNum.text;
//    _confirmPaymentView.phoneNum = @"充值";
//    _confirmPaymentView.dataArray = _bankcardArray;
//    [_confirmPaymentView showInView:self.view];
//    //            __weak __typeof(self)wself = self;
//    __block CGBankCardTopUpViewController *  blockSelf = self;
//    _confirmPaymentView.selectbankcardblock = ^(NSString *str){
//        _bankCard = str;
//        XLPasswordView *passwordView = [XLPasswordView passwordView];
//        passwordView.delegate = blockSelf;
//        [passwordView showPasswordInView:blockSelf.view];
//    };
}

//- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
//{
//    NSLog(@"%@%@%@%@",_bankCard,_moneyNum.text,_countType,password);
//
//    NSDictionary *datas = [NSDictionary dictionaryWithObjectsAndKeys:
//                           _moneyNum.text,@"tradeMoney",
//                           _countType,@"payType",
//                           _bankCard,@"countId",
//                           password,@"payPwd",
//                           nil];
//
//
//    [[CGAFHttpRequest shareRequest] rechargeWithdatas:[self convertToJsonData:datas] serverSuccessFn:^(id dict) {
//        if(dict){
//            NSDictionary *result= dict[@"data"];
//            NSLog(@"result%@",result);
//        }
//    } serverFailureFn:^(NSError *error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//    }];
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return ([StringUtil validateMoney:_moneyNum.text Range:range String:string]);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* reqUrl = request.URL.absoluteString;
    if ([reqUrl hasPrefix:@"alipays://"] || [reqUrl hasPrefix:@"alipay://"]) {
        [MBProgressHUD hideHUD];
        BOOL bSucc = [[UIApplication sharedApplication] openURL:request.URL];
//        bSucc是否成功调起支付宝
        if (!bSucc) {
            NSLog(@"调用失败");
            return NO;
        }
    }
    return YES;
}

@end
