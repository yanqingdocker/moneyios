//
//  CGZhuanZhangConfirmViewController.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhuanZhangConfirmViewController.h"
#import "CGAccountBalanceTableViewCell.h"
#import "CGZhuanZhangJiLuViewController.h"

@interface CGZhuanZhangConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIButton *_headImgBtn;
    UILabel *_nameLab;
    UILabel *_phonenumLab;
    UITableView *_tableView;
    NSString *_amount;
    UITextField *_note;
}

@end

@implementation CGZhuanZhangConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNav{
    self.navigationItem.title = @"转账";
    [self setBackButton:YES];
    
        UIButton *zhuanzhangjiluBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zhuanzhangjiluBtn.frame = CGRectMake(0, 0, 50, 12);
        zhuanzhangjiluBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
        [zhuanzhangjiluBtn setTitle:@"转账记录" forState:UIControlStateNormal];
        [zhuanzhangjiluBtn addTarget:self action:@selector(jiluEven) forControlEvents:UIControlEventTouchUpInside];
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:zhuanzhangjiluBtn];
}

- (void)initUI{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    _headImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 89/2, 42, 89, 89)];
    [_headImgBtn setImage:[UIImage imageNamed:@"headImg"] forState:UIControlStateNormal];
    //    [headImgBtn addTarget:self action:@selector(headImgBtn) forControlEvents:UIControlEventTouchUpInside];
    _headImgBtn.layer.cornerRadius=_headImgBtn.frame.size.width/2;//裁成圆角
    _headImgBtn.layer.masksToBounds=YES;
    [bgView addSubview:_headImgBtn];
    
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, 142, 100, 13)];
    _nameLab.text = @"用户名称";
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_nameLab];
    
    _phonenumLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, 160, 100, 9)];
    _phonenumLab.text = @"13901212340";
    _phonenumLab.font = [UIFont systemFontOfSize:11];
    _phonenumLab.textColor = RGBCOLOR(204, 204, 204);
    _phonenumLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_phonenumLab];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 186, SCREEN_WIDTH, 120)  style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:_tableView];
    
    _note = [[UITextField alloc] init];
    _note.frame = CGRectMake(16, 322, SCREEN_WIDTH - 16*2, 10);
    _note.font = [UIFont systemFontOfSize:10];
    _note.placeholder = @"添加备注(20字以内)";
    _note.delegate = self;
    [bgView addSubview:_note];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 322+45, SCREEN_WIDTH - 15*2, 36)];
    [tixianBtn setTitle:@"确认转账" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(247, 195, 109)];
    [tixianBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [bgView addSubview:tixianBtn];
}

- (void)jiluEven{
    CGZhuanZhangJiLuViewController *vc = [[CGZhuanZhangJiLuViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

- (void)confirmEvent{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    if (indexPath.row == 0) {
        CGAccountBalanceTableViewCell *cell = [CGAccountBalanceTableViewCell cellForTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = [NSString stringWithFormat:@"转账金额"];
        cell.titleLab.textColor = [UIColor blackColor];
        cell.titleLab.font = [UIFont systemFontOfSize:11];
        cell.contentText.keyboardType =UIKeyboardTypeDecimalPad;
        cell.contentText.placeholder = @"0.00";
        cell.contentText.delegate =self;
        return cell;
    }
    
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _amount = textField.text;
}

@end
