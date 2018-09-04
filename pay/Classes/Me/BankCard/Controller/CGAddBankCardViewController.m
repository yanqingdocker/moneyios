//
//  CGAddBankCardViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGAddBankCardViewController.h"
#import "CGTitleContentTableViewCell.h"

@interface CGAddBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIWebViewDelegate>
@property (strong, nonatomic)  NSMutableArray *result;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *submitBtn;
@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *idcard;
@property (strong, nonatomic) NSString *bankcard;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *banktype;
@property (strong, nonatomic) UIWebView * webView;
@property (strong, nonatomic) UIImageView *bankCardimg;
@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSString *flag;


@end

@implementation CGAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = @"0";
}
- (void)initNav{
    self.navigationItem.title = @"绑定银行卡";
    [self setBackButton:YES];
}

-(void)initUI{
    UILabel *tips = [[UILabel alloc] init];
    tips.frame = CGRectMake(17, 15, 300,20);
    tips.text = @"请绑定持卡人本人的银行卡";
    tips.font = [UIFont systemFontOfSize:15];
    tips.textColor = RGBCOLOR(102, 102, 102);
    [self.view addSubview:tips];
    
    CGRect tableframe=CGRectMake(0, 35, SCREEN_WIDTH,SCREEN_HEIGHT -NAVIGATIONBAR_HEIGHT -35);
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
    
    
//    _webView = [[UIWebView alloc] init];
//
//    _webView.frame =CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height);
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//    [self.view addSubview:_webView];
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
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.backgroundColor = RGBCOLOR(72,151,239);
        [sureBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
        [footerView addSubview:sureBtn];
        
        _footerView = footerView;
    }
    
    _tableView.tableFooterView = _footerView;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 3){
        if([_flag isEqualToString:@"0"]){
            return 0;
        }else{
            return 44;
        }
    }
    return 44;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGTitleContentTableViewCell *cell = [CGTitleContentTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content.delegate = self;
    
    switch (indexPath.row) {
        case 0:
            cell.titleLab.text = @"姓       名:";
            cell.content.tag = indexPath.row;
            cell.content.placeholder = @"请填写持卡人姓名";
            break;
        case 1:
            cell.titleLab.text = @"身份证号:";
            cell.content.tag = indexPath.row;
            cell.content.placeholder = @"请填写持卡人身份证号";
            break;
        case 2:
            cell.titleLab.text = @"银行卡号:";
            cell.content.tag = indexPath.row;
            cell.content.placeholder = @"请填写银行卡号";
            break;
        case 3:
            if([_flag isEqualToString:@"0"]){
                cell.titleLab.text = @"";
            }else{
                cell.titleLab.text = @"卡号类型:";
            }
            
            cell.content.enabled = NO;
            _bankCardimg = [[UIImageView alloc] init];
            _bankCardimg.frame = CGRectMake(90, 0, self.view.frame.size.width - 90*2, 44);
            _bankCardimg.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:_bankCardimg];
            
//            cell.hidden = YES;
            
//            _webView = [[UIWebView alloc] init];
//
//            _webView.frame =CGRectMake(90, 0, self.view.frame.size.width - 90*2, 40);
//            _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//
//            _webView.contentMode = UIViewContentModeScaleAspectFit;
//            _webView.scalesPageToFit = YES;
//
////            _webView.multipleTouchEnabled = NO;
////            _webView.userInteractionEnabled = NO;
////            _webView.scrollView.scrollEnabled = NO;
//
//            _webView.delegate = self;
//
//
//
//            _webView.scrollView.bounces = NO;
//            _webView.scrollView.showsHorizontalScrollIndicator = NO;
//            _webView.scrollView.scrollEnabled = NO;
//
//            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apiserver.qiniudn.com/guangda.png"]]];

//            [cell addSubview:_webView];
            
//            self.webView = webView;
//            UIImageView *bankCardimg = [[UIImageView alloc] init];
//            bankCardimg.image = [UIImage imag];
//            [cell addSubview:bankCardimg];
//            UIWebView *bankCardimg = [[UIWebView alloc] init];
//            [bankCardimg ]
//            cell.hidden = YES;
            break;
        case 4:
            cell.titleLab.text = @"预留电话:";
            cell.content.tag = indexPath.row;
            cell.content.placeholder = @"请填写银行预留电话";
            break;
        case 5:
            cell.titleLab.text = @"开户地址:";
            cell.content.tag = indexPath.row;
            cell.content.placeholder = @"请填写开户地址";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.tag == 2){
        if(![string isEqualToString:@""]){
            _bankcard = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }else{
            _bankcard = [textField.text substringToIndex:([textField.text length]-1)];
//            _bankcard = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        
        if(_bankcard.length > 5){//@"6226661701682969"
            [[CGAFHttpRequest shareRequest] getTypeWithbankcardid:_bankcard serverSuccessFn:^(id dict) {
                if(dict){
                    
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    NSLog(@"%@",result);
                    if ([[result objectForKey:@"code"] isEqualToString:@"success"]) {
                        
                        
                        NSString * jsonString = [result objectForKey:@"message"];
                        
                        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                        
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                        
                        NSLog(@"%@",dic);
                        
                        
                        
                        
                        _data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"logUrl"]]];
                        

                        
                        _banktype = [dic objectForKey:@"bankType"];


                        _bankCardimg.image = [UIImage imageWithData:_data];
                        
                        _flag = @"1";

                        [_tableView reloadData];
                        
                        
                    }else{
                        _flag = @"0";
//                        _bankCardimg.image = [UIImage imageNamed:@"白底"];
                        _bankCardimg.image = nil;
                        _banktype = @"";
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];

                        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                    
                    
                    
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        }
    }
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 0){
        _username = textField.text;
    }else if(textField.tag == 1){
        _idcard = textField.text;
    }else if(textField.tag == 2){
        _bankcard = textField.text;
        
        
    }else if(textField.tag == 4){
        _phone = textField.text;
    }else if(textField.tag == 5){
        _address = textField.text;
    }
    
    
}


-(void)confirmClick{
    [self.view endEditing:YES];
    NSDictionary *datas = [NSDictionary dictionaryWithObjectsAndKeys:
                           _username,@"username",
                           _idcard,@"idcard",
                           _bankcard,@"bankcard",
                           _phone,@"phone",
                           _address,@"address",
                           _banktype,@"banktype",
                           nil];
    
    [[CGAFHttpRequest shareRequest]  bindBankCardWithdatas:[self convertToJsonData:datas] serverSuccessFn:^(id dict) {
        if(dict){
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            if([[result objectForKey:@"code"] isEqualToString:@"fail"]) {
                [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
            }
            if ([[result objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"绑定成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
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
@end
