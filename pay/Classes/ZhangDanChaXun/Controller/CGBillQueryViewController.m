//
//  CGBillQueryViewController.m
//  pay
//
//  Created by v2 on 2018/8/22.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBillQueryViewController.h"
#import "CGBillQueryTableViewCell.h"
#import "CGBillDetailsViewController.h"
#import "ITDatePicker.h"
#import "MJRefresh.h"
#import "CGBillQueryModel.h"

@interface CGBillQueryViewController ()<UITableViewDelegate,UITableViewDataSource,ITAlertBoxDelegate,UIGestureRecognizerDelegate>{
    UITapGestureRecognizer *_tapGesture;
    
    UIView *datePickerView;
    
    NSMutableArray *result;
    
    
    ITDatePicker *datePicker1;
    ITDatePicker *datePicker;
    UIButton *dateTypeSelect;
    
    NSArray *typeArray;
    UIImageView *defaultImg;
    UILabel *defaultLab;
    
    UIButton *typeBtn;
    UIButton *dateBtn;
}
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITableView *typeTableView;
@property (nonatomic, assign) NSInteger page;//当前页
@property (strong, nonatomic) NSString *queryType;
@property (strong, nonatomic) NSString *queryDate;
@property (strong , nonatomic) CGBillQueryModel *model;
@property (nonatomic, assign) BOOL flag;//类型选择时解决手势和tableview冲突flag

@end

@implementation CGBillQueryViewController

- (void)viewDidLoad {
    _flag = NO;
    _queryDate = nil;
    _queryType = nil;
    [super viewDidLoad];
    result = [[NSMutableArray alloc] init];
    [self requestForm];
    typeArray = [NSArray arrayWithObjects:@"全部", @"兑换", @"转账", @"充值", @"话费充值", @"提现",nil];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] operaQueryByUseridWithpage:_page serverSuccessFn:^(id dict) {
                
                _tableView.footer.hidden = NO;
                [_tableView.header endRefreshing];
                
                [_tableView.footer endRefreshing];
                if([dict[@"code"] integerValue] == 1004){
                    
                    
                    if(_page == 0){
                        [result removeAllObjects];
                    }
                    [result addObjectsFromArray:dict[@"data"]];
                    
                    if(result.count == 0){
                        defaultImg.image = [UIImage imageNamed:@"billQueryDefault"];
                        defaultImg.hidden = NO;
                        defaultLab.text = @"您目前还没有相关账单信息!";
                        defaultLab.hidden = NO;
                    }else{
                        defaultImg.hidden = YES;
                        defaultLab.hidden = YES;
                    }
                    
                    NSLog(@"%@",result);
                    [_tableView reloadData];
                    
                    //如果已经加载到最后一页
                    if([dict[@"data"] count] == 0){
                        [_tableView.footer noticeNoMoreData];
                        if(_page == 0){
                            _tableView.footer.hidden = YES;
                        }
                        
                    }
                }
                
                
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                    if(error.code == -1009 || error.code == -1001){
                        defaultImg.image = [UIImage imageNamed:@"nonetWork"];
                        defaultImg.hidden = NO;
                        defaultLab.text = @"呀,网络好像不给力!";
                        defaultLab.hidden = NO;
                    }
                    [_tableView.header endRefreshing];
                    
                    [_tableView.footer endRefreshing];
                }
            }];
        });
    });
    
}

- (void)initNav{
    self.navigationItem.title = @"账单";
    [self setBackButton:YES];
}

-(void)initUI{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    bgView.backgroundColor = [UIColor whiteColor];
//    bgView.hidden = YES;
    [self.view addSubview:bgView];
    
    CGRect tableframe=CGRectMake(0, 45, SCREEN_WIDTH,SCREEN_HEIGHT - 45 - 66);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tag = 10001;
    //    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _tableView.footer.hidden = YES;
    [bgView addSubview:_tableView];
    
    defaultImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    defaultImg.image=[UIImage imageNamed:@"billQueryDefault"];
    defaultImg.hidden = YES;
    [bgView addSubview:defaultImg];
    
    defaultLab = [[UILabel alloc] init];
    defaultLab.text = @"您目前还没有相关账单信息!";
    defaultLab.frame = CGRectMake(0, SCREEN_HEIGHT /2-20, SCREEN_WIDTH, 44);
    defaultLab.textAlignment = NSTextAlignmentCenter;
    defaultLab.textColor = RGBCOLOR(153,153,153);
    defaultLab.hidden = YES;
    [bgView addSubview:defaultLab];

    typeBtn =  [[UIButton alloc] init];
    typeBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2,44);
    typeBtn.backgroundColor = [UIColor whiteColor];
    [typeBtn setTitle:@"全部" forState:UIControlStateNormal];
    [typeBtn setTitleColor:RGBCOLOR(57,135,245) forState:UIControlStateNormal];
    [typeBtn addTarget:self action:@selector(selectTypeClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:typeBtn];

    dateBtn =  [[UIButton alloc] init];
    dateBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2,44);
    dateBtn.backgroundColor = [UIColor whiteColor];
    [dateBtn setTitle:@"日期" forState:UIControlStateNormal];
    [dateBtn setTitleColor:RGBCOLOR(125,123,123) forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(selectDateClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:dateBtn];

    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
}
#pragma mark - 下拉刷新

- (void)headRefresh{
    self.page = 0;
    _tableView.footer.hidden = NO;
    if(_queryType == nil && _queryDate == nil){
        [self requestForm];
        return;
    }else if(_queryType == nil){
        [self queryByDate:_queryDate];
    }else if(_queryDate == nil){
        [self queryByType:_queryType];
    }
    
    
}

#pragma mark - 上拉加载

- (void)footerRefresh{
    self.page ++;
//    [self requestForm];
//    [self queryByType:_queryType];
    if(_queryType == nil && _queryDate == nil){
        [self requestForm];
        return;
    }else if(_queryType == nil){
        [self queryByDate:_queryDate];
    }else if(_queryDate == nil){
        [self queryByType:_queryType];
    }
    
}
//解决tableView和手势冲突问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(_flag){
        if ([NSStringFromClass([touch.view class]) isEqual:@"UITableViewCellContentView"]) {
            
            return NO;
            
        }
    }
    return YES;

}

-(void)selectTypeClick{
    
    
    datePickerView = [[UIView alloc] init];
    datePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    datePickerView.userInteractionEnabled = YES;
//    [datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    _flag = YES;
    //添加手势
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)];
    [datePickerView addGestureRecognizer:backTap];
    
    //遵守协议，添加代理
    backTap.delegate = self;
    
    [self.view addSubview:datePickerView];
    
    UIView *typeView = [[UIView alloc] init];
    typeView.frame = CGRectMake(0, 45, 130, SCREEN_HEIGHT);
    typeView.backgroundColor = [UIColor whiteColor];
    [datePickerView addSubview:typeView];
    
    CGRect tableframe=CGRectMake(0, 45, 130,SCREEN_HEIGHT - 45 - 66);
    _typeTableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _typeTableView.delegate=self;
    _typeTableView.dataSource=self;
    _typeTableView.bounces = NO;
    _typeTableView.estimatedRowHeight = 0;
    _typeTableView.estimatedSectionHeaderHeight = 0;
    _typeTableView.estimatedSectionFooterHeight = 0;
    _typeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [datePickerView addSubview:_typeTableView];
}

-(void)selectDateClick{
    datePickerView = [[UIView alloc] init];
    datePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    datePickerView.userInteractionEnabled = YES;
    [datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    [self.view addSubview:datePickerView];

    
    datePicker = [[ITDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, SCREEN_HEIGHT - 260- 44, SCREEN_WIDTH, 260);
    datePicker.tag = 100;
    datePicker.delegate = self;
    datePicker.showToday = NO;
    datePicker.showOutsideDate = YES;
    datePicker.mode = ITDatePickerModeyyyyMMdd;
    datePicker.hidden = YES;
    
    [datePickerView addSubview:datePicker];
    
    
    datePicker1 = [[ITDatePicker alloc] init];
    datePicker1.frame = CGRectMake(0, SCREEN_HEIGHT - 260- 44, SCREEN_WIDTH, 260);
    datePicker1.tag = 100;
    datePicker1.delegate = self;
    datePicker1.showToday = NO;
//    datePicker1.defaultDate = self.startDate;
//    datePicker1.maximumDate = self.endDate;
    datePicker1.showOutsideDate = YES;
    datePicker1.hidden = NO;
    [self.view addSubview:datePicker1];
    
    dateTypeSelect = [[UIButton alloc] init];
    dateTypeSelect.frame = CGRectMake(SCREEN_WIDTH /2 -50, SCREEN_HEIGHT - 260 + 15- 44, 100, 12);
    [dateTypeSelect setTitle:@"按日选择" forState:UIControlStateNormal];
    [dateTypeSelect setTitleColor:RGBCOLOR(57,135,245) forState:UIControlStateNormal];
    [dateTypeSelect addTarget:self action:@selector(dateTypeSelectEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dateTypeSelect];
    
}
- (void)disMissView {
    _flag = NO;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         datePickerView.alpha = 0.0;
                         dateTypeSelect.frame = CGRectMake(SCREEN_WIDTH /2 -50, SCREEN_HEIGHT + 15, 100, 12);
                         [datePicker setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260)];
                         [datePicker1 setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260)];
                     }
                     completion:^(BOOL finished){
                         
                         [datePickerView removeFromSuperview];
                         [dateTypeSelect removeFromSuperview];
                         [datePicker removeFromSuperview];
                         [datePicker1 removeFromSuperview];
                     }];
    
}

-(void)dateTypeSelectEvent{
    datePicker.hidden = !datePicker.hidden;
    datePicker1.hidden = !datePicker1.hidden;
    if(datePicker.hidden){
        [dateTypeSelect setTitle:@"按日选择" forState:UIControlStateNormal];
    }else{
        [dateTypeSelect setTitle:@"按月选择" forState:UIControlStateNormal];
    }
    
}

#pragma mark - ITAlertBoxDelegate

- (void)alertBox:(ITAlertBox *)alertBox didSelectedResult:(NSString *)dateString {
    
    if(dateString != nil){
        [typeBtn setTitleColor:RGBCOLOR(125,123,123) forState:UIControlStateNormal];
        [dateBtn setTitleColor:RGBCOLOR(57,135,245) forState:UIControlStateNormal];
        [dateBtn setTitle:dateString forState:UIControlStateNormal];
        [typeBtn setTitle:@"全部" forState:UIControlStateNormal];
        _queryDate = dateString;
        _page = 0;
        [self queryByDate:_queryDate];
        
    }
    
    [self disMissView];
}

-(void)queryByDate:(NSString *)date{
    [[CGAFHttpRequest shareRequest] queryByDateWithdate:date page:_page serverSuccessFn:^(id dict) {
        _tableView.footer.hidden = NO;
        [_tableView.header endRefreshing];
        
        [_tableView.footer endRefreshing];
        if([dict[@"code"] integerValue] == 1004){
            if(_page == 0){
                [result removeAllObjects];
            }
            _queryType = nil;
            [result addObjectsFromArray:dict[@"data"]];
            if(result.count == 0){
                defaultImg.image = [UIImage imageNamed:@"billQueryDefault"];
                defaultImg.hidden = NO;
                defaultLab.text = @"您目前还没有相关账单信息!";
                defaultLab.hidden = NO;
            }else{
                defaultImg.hidden = YES;
                defaultLab.hidden = YES;
            }
            NSLog(@"%@",result);
            [_tableView reloadData];
            
            //如果已经加载到最后一页
            if([dict[@"data"] count] == 0){
                [_tableView.footer noticeNoMoreData];
                if(_page == 0){
                    _tableView.footer.hidden = YES;
                }
            }
        }
        
        
        
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
            if(error.code == -1009 || error.code == -1001){
                defaultImg.image = [UIImage imageNamed:@"nonetWork"];
                defaultImg.hidden = NO;
                defaultLab.text = @"呀,网络好像不给力!";
                defaultLab.hidden = NO;
            }
            [_tableView.header endRefreshing];
            
            [_tableView.footer endRefreshing];
        }
    }];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _tableView){
        return result.count;
    }else{
        return 6;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        return 97;
    }else{
        return 70;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        CGBillQueryTableViewCell *cell = [CGBillQueryTableViewCell cellForTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _model = [CGBillQueryModel objectWithKeyValues:[result objectAtIndex:indexPath.row]];
        
        NSData *data=[[NSData alloc] initWithBase64EncodedString:_model.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        headImgView.image = [UIImage imageWithData:data];

        for (int i = 0 ; i < typeArray.count; i++) {
            if([_model.operaType isEqualToString:typeArray[i]]){
                if([typeArray[i] isEqualToString:@"转账"]){
                    if(data.length > 0){
                        //            imgView.image = [UIImage imageWithData:_imgData];
                        cell.headimg.image = [UIImage imageWithData:data];
                    }else{
                        //            imgView.image = [UIImage imageNamed:@"headImg"];
                        cell.headimg.image = [UIImage imageNamed:@"headImg"];
                    }
                }else{
                    cell.headimg.image = [UIImage imageNamed:typeArray[i]];
                }
            }
        }
        
        
        
        
        
        cell.title.text = _model.operaUser;
        if([_model.countType isEqualToString:@"CNY"]){
            cell.amount.text = [NSString stringWithFormat:@"¥%@",_model.num];
        }
        if([_model.countType isEqualToString:@"USD"]){
            cell.amount.text = [NSString stringWithFormat:@"$%@",_model.num];
        }
        if([_model.oi integerValue] == 1){
            cell.amount.textColor = RGBCOLOR(216,40,40);
        }
        cell.type.text = [NSString stringWithFormat:@"[%@]",_model.operaType];
        cell.date.text = _model.operaTime;
        
        return cell;
    }else{
        static NSString *identifire = @"CellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //"全部", "兑换", "转账", "充值", "话费充值", "提现"
        cell.textLabel.text = typeArray[indexPath.row];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        UIImage *headimg = [[UIImage alloc] init];
        _model = [CGBillQueryModel objectWithKeyValues:[result objectAtIndex:indexPath.row]];
        
        NSData *data=[[NSData alloc] initWithBase64EncodedString:_model.img options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        for (int i = 0 ; i < typeArray.count; i++) {
            if([_model.operaType isEqualToString:typeArray[i]]){
                if([typeArray[i] isEqualToString:@"转账"]){
                    if(data.length > 0){
                        //            imgView.image = [UIImage imageWithData:_imgData];
                        headimg = [UIImage imageWithData:data];
                    }else{
                        //            imgView.image = [UIImage imageNamed:@"headImg"];
                        headimg = [UIImage imageNamed:@"headImg"];
                    }
                }else{
                    headimg = [UIImage imageNamed:typeArray[i]];
                }
            }
        }
        
        CGBillDetailsViewController *vc = [[CGBillDetailsViewController alloc] init];
        vc.liushuiID = [[result objectAtIndex:indexPath.row] objectForKey:@"snumber"];
        vc.headimg = headimg;
        [self pushViewControllerHiddenTabBar:vc animated:YES];
        
    }else{
        _flag = NO;
        _queryType = typeArray[indexPath.row];
        _page = 0;
        
        [typeBtn setTitleColor:RGBCOLOR(57,135,245) forState:UIControlStateNormal];
        [dateBtn setTitleColor:RGBCOLOR(125,123,123) forState:UIControlStateNormal];
        [typeBtn setTitle:_queryType forState:UIControlStateNormal];
        [dateBtn setTitle:@"日期" forState:UIControlStateNormal];
        
        [self queryByType:_queryType];
    }
}

-(void)queryByType:(NSString *)type{
    [[CGAFHttpRequest shareRequest] queryByTypeWithtype:type page:_page serverSuccessFn:^(id dict) {
        _tableView.footer.hidden = NO;
        [_tableView.header endRefreshing];
        
        [_tableView.footer endRefreshing];
        if([dict[@"code"] integerValue] == 1004){
            if(_page == 0){
                [result removeAllObjects];
            }
            _queryDate = nil;
//            result= dict[@"data"];
            [result addObjectsFromArray:dict[@"data"]];
            if(result.count == 0){
                defaultImg.hidden = NO;
                defaultLab.hidden = NO;
            }else{
                defaultImg.hidden = YES;
                defaultLab.hidden = YES;
            }
            NSLog(@"%@",result);
            [_tableView reloadData];
            
            //如果已经加载到最后一页
            if([dict[@"data"] count] == 0){
                [_tableView.footer noticeNoMoreData];
                if(_page == 0){
                    _tableView.footer.hidden = YES;
                }
            }
        }
        
        
        
        [self disMissView];
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
            
            [_tableView.header endRefreshing];
            
            [_tableView.footer endRefreshing];
            
        }
    }];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    if (textField.tag == 100) {
        [textField resignFirstResponder];
        return NO;
    }else
    {
        return YES;
    }
}

@end
