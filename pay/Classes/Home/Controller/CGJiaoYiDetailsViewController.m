//
//  CGJiaoYiDetailsViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/27.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGJiaoYiDetailsViewController.h"
#import "CGJiaoYiDetailsModel.h"

@interface CGJiaoYiDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_result;
    UILabel *_jiaoyiType;
    UILabel *_money;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CGJiaoYiDetailsModel *jyModel;
@end

@implementation CGJiaoYiDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestForm];
}

- (void)requestForm{
//    _liushuiID
    [[CGAFHttpRequest shareRequest] queryByIdWithid:_liushuiID serverSuccessFn:^(id dict) {
        if(dict){
            
            
            _result = dict[@"data"];
            NSLog(@"%@",_result);
            
            _jyModel = [CGJiaoYiDetailsModel objectWithKeyValues:[_result objectAtIndex:0]];
            
            _jiaoyiType.text = _jyModel.operaType;
            _money.text = _jyModel.num;
            
            [_tableView reloadData];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
    
}

- (void)initNav{
    self.navigationItem.title = @"交易详情";
    [self setBackButton:YES];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(0, 0, 50, 12);
    completeBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeEven) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
}

-(void)initUI{
    UIImageView *dagouImgView = [[UIImageView alloc] init];
    dagouImgView.frame =CGRectMake(17, 13, 40,40);
    dagouImgView.image = [UIImage imageNamed:@"successfulTrade"];
    [self.view addSubview:dagouImgView];
    
    UILabel *successLab= [[UILabel alloc] init];
    successLab.frame = CGRectMake(68, 26, 100, 17);
    successLab.text = @"提交成功";
    successLab.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:successLab];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 60, SCREEN_WIDTH, 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    _jiaoyiType = [[UILabel alloc] init];
    _jiaoyiType.text = _jyModel.operaType;
    _jiaoyiType.font = [UIFont systemFontOfSize:14];
    _jiaoyiType.textColor = RGBCOLOR(104, 104, 104);
    _jiaoyiType.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_jiaoyiType];
    [_jiaoyiType mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(101);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(13);
    }];
    
    _money = [[UILabel alloc] init];
    _money.text = _jyModel.operaType;
    _money.font = [UIFont systemFontOfSize:30];
//    _money.textColor = RGBCOLOR(104, 104, 104);
    _money.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_money];
    [_money mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(129);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(23);
    }];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.frame = CGRectMake(0, 183, SCREEN_WIDTH, 1);
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    CGRect tableframe=CGRectMake(0, 184, SCREEN_WIDTH,44*4);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
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
        cell.textLabel.text = @"交易类型";
//        if([_result objectForKey:@"operaType"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"operaType"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
        
        cell.detailTextLabel.text  = _jyModel.operaType;
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"货币类型";
//        if([_result objectForKey:@"countType"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"countType"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
        cell.detailTextLabel.text  = _jyModel.countType;
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"交易时间";
//        if([_result objectForKey:@"operaTime"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"operaTime"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
        cell.detailTextLabel.text  = _jyModel.operaTime;
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"流水号";
//        if([_result objectForKey:@"snumber"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"snumber"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
        cell.detailTextLabel.text  = _jyModel.snumber;
        
    }
    
    return cell;
}
- (void)completeEven{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
