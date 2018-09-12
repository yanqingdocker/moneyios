//
//  CGSelectBankCardViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/12.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGSelectBankCardViewController.h"
#import "CGAddBankCardViewController.h"

@interface CGSelectBankCardViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *lastIndex;
//@property (nonatomic, strong) NSString *accountID;
@end

@implementation CGSelectBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    _lastIndex = [NSIndexPath indexPathForRow:_selectLine inSection:0];


}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryWithserverSuccessFn:^(id dict) {
        if(dict){
            _dataArray = dict[@"data"];
            [_tableView reloadData];
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}



- (void)initNav{
    self.navigationItem.title = @"选择银行卡";
    [self setBackButton:YES];
    
    UIButton *addBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankCardBtn.frame = CGRectMake(0, 0, 50, 50);
    addBankCardBtn.titleLabel.font = [UIFont systemFontOfSize: 24];
    [addBankCardBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBankCardBtn addTarget:self action:@selector(addBankCardEvent) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBankCardBtn];
}

- (void)initUI{
    CGRect tableframe=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIImageView *bankcardIcon = [[UIImageView alloc] init];
    [cell addSubview:bankcardIcon];
    [bankcardIcon mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(cell).offset(17);
        make.centerY.equalTo(cell);
        make.height.mas_equalTo(@35);
        make.width.mas_equalTo(@35);
    }];
    
    UILabel *bankcardTitle = [[UILabel alloc] init];
    bankcardTitle.textColor = RGBCOLOR(51,51,51);
    bankcardTitle.font = [UIFont systemFontOfSize:18];
    [cell addSubview:bankcardTitle];
    [bankcardTitle mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(bankcardIcon.mas_right).offset(14);
        make.top.equalTo(cell.mas_top).offset(20);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@200);
    }];
    
    UILabel *bankcardNum = [[UILabel alloc] init];
    bankcardNum.textColor = RGBCOLOR(102, 102, 102);
    bankcardNum.font = [UIFont systemFontOfSize:14];
    [cell addSubview:bankcardNum];
    [bankcardNum mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(bankcardIcon.mas_right).offset(14);
        make.top.equalTo(bankcardTitle.mas_bottom).offset(8);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@200);
    }];
    
    bankcardIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@logo",[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankType"]]];
    bankcardTitle.text = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankType"];
    NSString *bankCard = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankCard"];
    bankcardNum.text = [NSString stringWithFormat:@"尾号(%@)",[bankCard substringFromIndex:bankCard.length- 4]];
    
    NSInteger row = [indexPath row];
    NSInteger oldRow = [_lastIndex row];
    if (row == oldRow && _lastIndex!=nil) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectLine = indexPath.row;
    NSDictionary *selectData = [_dataArray objectAtIndex:indexPath.row];
    
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = (_lastIndex !=nil)?[_lastIndex row]:-1;
    if (newRow != oldRow) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastIndex];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _lastIndex = indexPath;
    }
    [self gobackView:selectData];
}

-(void)gobackView:(NSDictionary *)selectData{
    _selectbankcardblock(selectData,_selectLine);
    [self.navigationController popViewControllerAnimated:true];
}

-(void)addBankCardEvent{
    CGAddBankCardViewController *vc = [[CGAddBankCardViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

@end
