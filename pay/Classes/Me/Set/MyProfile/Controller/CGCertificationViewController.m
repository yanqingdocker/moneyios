//
//  CGCertificationViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/17.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGCertificationViewController.h"
#import "SelectView.h"
#import "ITDatePicker.h"

@interface CGCertificationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ITAlertBoxDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSDictionary *dataArray;
@property (nonatomic , strong)UIButton *submitBtn;
@property (nonatomic , strong)UITextField *username;
@property (nonatomic , strong)UITextField *IDcard;
@property (nonatomic , strong)UILabel *birthdate;
@property (nonatomic , strong)UILabel *area;
@property (nonatomic , strong)UITextField *address;
@property (nonatomic , strong)UITextField *email;
@property (nonatomic , strong)UIView *datePickerView;
@property (nonatomic , strong)ITDatePicker *datePicker;
@end

@implementation CGCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)initNav{
    self.navigationItem.title = @"实名认证";
    [self setBackButton:YES];
}

- (void)initUI{
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(17, 13, 600, 12);
    titleLab.font = [UIFont systemFontOfSize:12];
    titleLab.text = @"基本资料";
    titleLab.textColor = RGBCOLOR(153,153,153);
    [self.view addSubview:titleLab];
    
    CGRect tableframe=CGRectMake(0, 30, SCREEN_WIDTH,SCREEN_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    if (_isauthentication == 0) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(20, 379, SCREEN_WIDTH-20*2, 44);
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _submitBtn.layer.cornerRadius = 3;
        _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitBtn];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isauthentication == 1) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return 0;
            }
        }
    }else{
//        return 50;
    }
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }
    return 8;//section头部高度
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGCertificationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//                [GlobalSingleton ]
    
    if (indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"真实姓名:";
            _username = [[UITextField alloc] init];
            _username.frame = CGRectMake(108, 3, SCREEN_WIDTH - 108 - 18 -5, 44);
            _username.delegate =self;
            _username.font = [UIFont systemFontOfSize:16];
            _username.placeholder = @"请输入姓名";
            if (_isauthentication == 1) {
                _username.text = [GlobalSingleton Instance].currentUser.username;
                _username.enabled = NO;
            }else{
                _username.clearButtonMode = UITextFieldViewModeAlways;
                _username.returnKeyType = UIReturnKeyDone;
            }
            [cell addSubview:_username];
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"身份证号码:";
            _IDcard = [[UITextField alloc] init];
            _IDcard.frame = CGRectMake(124, 3, SCREEN_WIDTH - 124 - 18 -5, 44);
            _IDcard.delegate =self;
            _IDcard.font = [UIFont systemFontOfSize:16];
            _IDcard.placeholder = @"请输入身份证号码";
            if (_isauthentication == 1) {
                _IDcard.text = [GlobalSingleton Instance].currentUser.idcard;
                _IDcard.enabled = NO;
            }else{
                _IDcard.clearButtonMode = UITextFieldViewModeAlways;
                _IDcard.keyboardType = UIKeyboardTypePhonePad;
                _IDcard.returnKeyType = UIReturnKeyDone;
            }
//            _IDcard.inputAccessoryView = [self addToolbar];
            [cell addSubview:_IDcard];
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"出生日期:";
            _birthdate = [[UILabel alloc] init];
            _birthdate.text = @"选择出生日期";
            if (_isauthentication == 1) {
                _birthdate.text = [GlobalSingleton Instance].currentUser.birthday;
            }else{
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            _birthdate.frame = CGRectMake(108, 3, SCREEN_WIDTH - 108 - 18 -5, 44);
            _birthdate.font = [UIFont systemFontOfSize:16];
            [cell addSubview:_birthdate];
            
        }
    }
    if (indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"地区:";
            _area = [[UILabel alloc] init];
            _area.text = @"选择地区";
            if (_isauthentication == 1) {
                cell.hidden = YES;
            }
            _area.frame = CGRectMake(81, 3, SCREEN_WIDTH - 81 - 18 -5, 44);
            _area.font = [UIFont systemFontOfSize:16];
            _area.numberOfLines = 0;
            [cell addSubview:_area];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row == 1){
            cell.textLabel.text = @"详细地址:";
            _address = [[UITextField alloc] init];
            _address.frame = CGRectMake(108, 3, SCREEN_WIDTH - 108 - 18 -5, 44);
            _address.delegate =self;
            _address.font = [UIFont systemFontOfSize:16];
            _address.placeholder = @"请输入详细地址";
            if (_isauthentication == 1) {
                _address.text = [GlobalSingleton Instance].currentUser.address;
                _address.enabled = NO;
            }else{
                _address.clearButtonMode = UITextFieldViewModeAlways;
                _address.returnKeyType = UIReturnKeyDone;
            }
            [cell addSubview:_address];
        }
        if(indexPath.row == 2){
            cell.textLabel.text = @"电子邮箱:";
            _email = [[UITextField alloc] init];
            _email.frame = CGRectMake(108, 3, SCREEN_WIDTH - 108 - 18 -5, 44);
            _email.delegate =self;
            _email.font = [UIFont systemFontOfSize:16];
            _email.placeholder = @"请输入电子邮箱";
            if (_isauthentication == 1) {
                _email.text = [GlobalSingleton Instance].currentUser.email;
                _email.enabled = NO;
            }else{
                _email.keyboardType = UIKeyboardTypeEmailAddress;
                _email.clearButtonMode = UITextFieldViewModeAlways;
                _email.returnKeyType = UIReturnKeyDone;
            }
            
            [cell addSubview:_email];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isauthentication == 0) {
        [self.view endEditing:YES];
        if (indexPath.section == 0){
            if(indexPath.row == 2){
                //            cell.textLabel.text = @"地区:";
                _datePickerView = [[UIView alloc] init];
                _datePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                _datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
                _datePickerView.userInteractionEnabled = YES;
                [_datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
                [self.view addSubview:_datePickerView];
                
                
                _datePicker = [[ITDatePicker alloc] init];
                _datePicker.frame = CGRectMake(0, SCREEN_HEIGHT - 260- 44, SCREEN_WIDTH, 260);
                _datePicker.tag = 100;
                _datePicker.delegate = self;
                _datePicker.showToday = NO;
                _datePicker.showOutsideDate = YES;
                _datePicker.mode = ITDatePickerModeyyyyMMdd;
                //            _datePicker.hidden = YES;
                
                [_datePickerView addSubview:_datePicker];
            }
        }
        if (indexPath.section == 1){
            if(indexPath.row == 0){
                //            cell.textLabel.text = @"地区:";
                SelectView *city = [[SelectView alloc]initWithZGQFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) SelectCityTtitle:@""];
                [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *disStr) {
                    _area.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,disStr];
                }];
            }
        }
    }
    
}

#pragma mark - ITAlertBoxDelegate

- (void)alertBox:(ITAlertBox *)alertBox didSelectedResult:(NSString *)dateString {
    
    if(dateString != nil){
        _birthdate.text = dateString;
//        _page = 0;
//        [self queryByDate:_queryDate];
        
    }
    
    [self disMissView];
}

- (void)disMissView {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         _datePickerView.alpha = 0.0;
                         [_datePicker setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260)];
                     }
                     completion:^(BOOL finished){
                         
                         [_datePickerView removeFromSuperview];
                         [_datePicker removeFromSuperview];
                     }];
    
}

-(void)submitClick{
    [self.view endEditing:YES];
    if(_username.text.length == 0 || _IDcard.text.length == 0 || [_birthdate.text isEqualToString:@"选择出生日期"] || [_area.text isEqualToString:@"选择地区"] || _address.text.length == 0 || _email.text.length == 0){
        [MBProgressHUD showText:@"请将基本资料全部填写" toView:self.view];
        return;
    }
    
    NSDictionary *datas = [NSDictionary dictionaryWithObjectsAndKeys:
                           _username.text,@"username",
                           _IDcard.text,@"idcard",
                           _birthdate.text,@"birthday",
                           _email.text,@"email",
                           [NSString stringWithFormat:@"%@%@",_area.text,_address.text],@"address",
                           nil];
    [[CGAFHttpRequest shareRequest] authenticationWithdatas:[self convertToJsonData:datas] serverSuccessFn:^(id dict) {
        if(dict){
            if([dict[@"code"] isEqualToString:@"1004"]){
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"认证成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
