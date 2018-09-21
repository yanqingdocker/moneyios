//
//  CGChangePhoneViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/18.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGChangePhoneViewController.h"
#import "LMJDropdownMenu.h"
@interface CGChangePhoneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,LMJDropdownMenuDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIButton *submitBtn;
@property (nonatomic , strong)LMJDropdownMenu *dropdownMenu;
@property (nonatomic , strong)UITextField *telphone;
@property (nonatomic , strong)UITextField *check;
@property (strong, nonatomic) UIButton *getCheckBtn;

@end

@implementation CGChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initNav{
    self.navigationItem.title = @"更换手机号";
    [self setBackButton:YES];
}

- (void)initUI{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(17, 22, 300, 14);
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.text = @"更换手机号后 下次登录可使用新手机号登录";
    titleLab.textColor = RGBCOLOR(153,153,153);
    [self.view addSubview:titleLab];
    
    CGRect tableframe=CGRectMake(0, 43, SCREEN_WIDTH,44*2);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _dropdownMenu = [[LMJDropdownMenu alloc] init];
//    _dropdownMenu.backgroundColor = [UIColor redColor];
    [_dropdownMenu setFrame:CGRectMake(0, 58, 125, 16)];
    [_dropdownMenu setMenuTitles:countries rowHeight:30];
    _dropdownMenu.delegate = self;
    [_dropdownMenu.mainBtn setTitle:@"选择国家" forState:UIControlStateNormal];
    _dropdownMenu.mainBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    //            [_dropdownMenu.mainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _dropdownMenu.mainBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [self.view addSubview:_dropdownMenu];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake(20, 197 - 44, SCREEN_WIDTH-20*2, 44);
    [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
    [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGChangePhonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
        if(indexPath.row == 0){
            
            
            
            _telphone = [[UITextField alloc] init];
            _telphone.frame = CGRectMake(125, 0, SCREEN_WIDTH - 125 -5, 44);//242
//            _telphone.textColor = [UIColor whiteColor];
            _telphone.placeholder = @"请填写手机号码";
            _telphone.clearButtonMode = UITextFieldViewModeAlways;
            _telphone.delegate = self;
            _telphone.font = [UIFont systemFontOfSize:16];
            _telphone.borderStyle = UITextBorderStyleNone;
            _telphone.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:_telphone];
//            cell.textLabel.text = @"真实姓名:";
//            _username = [[UITextField alloc] init];
//            _username.frame = CGRectMake(108, 3, SCREEN_WIDTH - 108 - 18 -5, 44);
//            _username.delegate =self;
//            _username.font = [UIFont systemFontOfSize:16];
//            _username.placeholder = @"请输入姓名";
//            if (_isauthentication == 1) {
//                _username.text = [GlobalSingleton Instance].currentUser.username;
//                _username.enabled = NO;
//            }else{
//                _username.clearButtonMode = UITextFieldViewModeAlways;
//                _username.returnKeyType = UIReturnKeyDone;
//            }
//            [cell addSubview:_username];
        }
        if(indexPath.row == 1){
            _check = [[UITextField alloc] init];
            _check.frame = CGRectMake(17, 0, 200, 44);
//            _check.textColor = [UIColor whiteColor];
            _check.placeholder = @"请填写短信验证码";
            _check.clearButtonMode = UITextFieldViewModeNever;
            _check.delegate = self;
            _check.font = [UIFont systemFontOfSize:16];
            _check.borderStyle = UITextBorderStyleNone;
            _check.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:_check];
            
            UILabel *shuline = [[UILabel alloc] init];
            shuline.frame = CGRectMake(SCREEN_WIDTH -125 -35, 0, 1, 44);
            shuline.backgroundColor = RGBCOLOR(229,229,245);
            [cell addSubview:shuline];
            
            _getCheckBtn = [[UIButton alloc] init];
            _getCheckBtn.frame = CGRectMake(SCREEN_WIDTH - 125 - 17, 0, 125, 44);
            [_getCheckBtn setTitleColor:RGBCOLOR(58,58,58) forState:UIControlStateNormal];
            [_getCheckBtn setTitle:@"获取验证码" forState:UIControlStateNormal];//
            [_getCheckBtn addTarget:self action:@selector(getCheckClick) forControlEvents:UIControlEventTouchUpInside];
            _getCheckBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
            [cell addSubview:_getCheckBtn];
        }
   
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_isauthentication == 0) {
//        [self.view endEditing:YES];
//        if (indexPath.section == 0){
//            if(indexPath.row == 2){
//                //            cell.textLabel.text = @"地区:";
//                _datePickerView = [[UIView alloc] init];
//                _datePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//                _datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//                _datePickerView.userInteractionEnabled = YES;
//                [_datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
//                [self.view addSubview:_datePickerView];
//
//
//                _datePicker = [[ITDatePicker alloc] init];
//                _datePicker.frame = CGRectMake(0, SCREEN_HEIGHT - 260- 44, SCREEN_WIDTH, 260);
//                _datePicker.tag = 100;
//                _datePicker.delegate = self;
//                _datePicker.showToday = NO;
//                _datePicker.showOutsideDate = YES;
//                _datePicker.mode = ITDatePickerModeyyyyMMdd;
//                //            _datePicker.hidden = YES;
//
//                [_datePickerView addSubview:_datePicker];
//            }
//        }
//        if (indexPath.section == 1){
//            if(indexPath.row == 0){
//                //            cell.textLabel.text = @"地区:";
//                SelectView *city = [[SelectView alloc]initWithZGQFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) SelectCityTtitle:@""];
//                [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *disStr) {
//                    _area.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,disStr];
//                }];
//            }
//        }
//    }
//
//}


-(void)submitClick{
    [self.view endEditing:YES];
    [_dropdownMenu hideDropDown];
    if(_telphone.text.length == 0 || _check.text.length == 0 ){
        [MBProgressHUD showText:@"请填写手机号及验证码" toView:self.view];
        return;
    }
//
//    NSDictionary *datas = [NSDictionary dictionaryWithObjectsAndKeys:
//                           _username.text,@"username",
//                           _IDcard.text,@"idcard",
//                           _birthdate.text,@"birthday",
//                           _email.text,@"email",
//                           [NSString stringWithFormat:@"%@%@",_area.text,_address.text],@"address",
//                           nil];
    [[CGAFHttpRequest shareRequest] updatephoneWithchecknum:_check.text newphone:_telphone.text serverSuccessFn:^(id dict) {
        if(dict){
            if([dict[@"code"] isEqualToString:@"1004"]){
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更换成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_dropdownMenu hideDropDown];
}

- (void)getCheckClick{
    [self.view endEditing:YES];
    [_dropdownMenu hideDropDown];
    [[CGAFHttpRequest shareRequest] checkPhoneWithtelphone:_telphone.text
                                           serverSuccessFn:^(id dict)
     {
         if([dict[@"code"] isEqualToString:@"1004"]){
             [self startTimer:_getCheckBtn];
         }
     }serverFailureFn:^(NSError *error){
         if(error){
             NSLog(@"%@",error);
         }
     }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_dropdownMenu hideDropDown];
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor grayColor];
    //    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextTextField)];
    //    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(prevTextField)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[ space, bar];//nextButton, prevButton,
    return toolbar;
}

-(void)textFieldDone{
    [self.view endEditing:YES];
}

@end
