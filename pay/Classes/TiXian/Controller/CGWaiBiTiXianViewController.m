//
//  CGWaiBiTiXianViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/13.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGWaiBiTiXianViewController.h"
#import "CGTitleAndTextTableViewCell.h"
#import "CGWaiBiTiXianConfirmViewController.h"
@interface CGWaiBiTiXianViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIButton *submitBtn;
@property (nonatomic ,strong) UITextField *bankCardName;
@property (nonatomic ,strong) UITextField *bankCardType;
@property (nonatomic ,strong) UITextField *bankCardNum;
@end

@implementation CGWaiBiTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)initNav{
    self.navigationItem.title = @"外币提现";
    [self setBackButton:YES];
}

- (void)initUI{
        CGRect tableframe=CGRectMake(0, 0 + 15, SCREEN_WIDTH,44*3);
        _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces = NO;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
    
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.frame = CGRectMake(18, 0 + 15 + 44*3 +55, SCREEN_WIDTH-18*2, 44);
        [_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 3;
        _submitBtn.backgroundColor = RGBCOLOR(72,151,239);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
        [self.view addSubview:_submitBtn];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CGWaiBiTiXianCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"姓名";
        
        _bankCardName = [[UITextField alloc] initWithFrame:CGRectMake(77, 0, SCREEN_WIDTH - 17*2, 44)];
        _bankCardName.placeholder = @"请输入持卡人姓名";
        _bankCardName.font = [UIFont systemFontOfSize:16];
        _bankCardName.borderStyle = UIKeyboardTypeNumberPad;
        _bankCardName.clearButtonMode = UITextFieldViewModeAlways;
//        _bankCardName.keyboardType = UIKeyboardTypeDecimalPad;
        [cell addSubview:_bankCardName];
    }
    if(indexPath.row == 1){
        cell.textLabel.text = @"银行";
        _bankCardType = [[UITextField alloc] initWithFrame:CGRectMake(77, 0, SCREEN_WIDTH - 17*2, 44)];
            _bankCardType.placeholder = @"请输入银行卡类型";
        _bankCardType.borderStyle = UIKeyboardTypeNumberPad;
        _bankCardType.font = [UIFont systemFontOfSize:16];
        _bankCardType.clearButtonMode = UITextFieldViewModeAlways;
        _bankCardType.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:_bankCardType];
    }
    if(indexPath.row == 2){
        cell.textLabel.text = @"卡号";
        _bankCardNum = [[UITextField alloc] initWithFrame:CGRectMake(77, 0, SCREEN_WIDTH - 17*2, 44)];
        _bankCardNum.placeholder = @"请输入银行卡号";
        _bankCardNum.font = [UIFont systemFontOfSize:16];
        _bankCardNum.clearButtonMode = UITextFieldViewModeAlways;
        _bankCardNum.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:_bankCardNum];
    }
    
    return cell;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if(textField.tag == 1001){
//        _bankCardName = textField.text;
//    }
//    if(textField.tag == 1002){
//        _bankCardType = textField.text;
//    }
//    if(textField.tag == 1003){
//        _bankCardNum = textField.text;
//    }
//}



-(void)submitClick{
    [self.view endEditing:YES];
    
    if (_bankCardName.text.length == 0) {
        [MBProgressHUD showText:@"请输入姓名" toView:self.view];
        return;
    }
    if (_bankCardType.text.length == 0) {
        [MBProgressHUD showText:@"请输入银行" toView:self.view];
        return;
    }
    if(_bankCardNum.text.length == 0){
        [MBProgressHUD showText:@"请输入卡号" toView:self.view];
        return;
    }
    
    CGWaiBiTiXianConfirmViewController *vc = [[CGWaiBiTiXianConfirmViewController alloc] init];
    vc.bankCardName = _bankCardName.text;
    vc.bankCardType = _bankCardType.text;
    vc.bankCardNum = _bankCardNum.text;
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
