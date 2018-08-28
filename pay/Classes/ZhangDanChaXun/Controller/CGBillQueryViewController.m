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

@interface CGBillQueryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITapGestureRecognizer *_tapGesture;
    
    UIView *datePickerView;
    UIDatePicker *datePicker;
    UIView *datePickerMenu;
    
    NSMutableArray *result;
}
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CGBillQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    result = [[NSMutableArray alloc] init];
    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] operaQueryByUseridWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    result= [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    
                    NSLog(@"%@",result);
                    [_tableView reloadData];
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
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
    [self.view addSubview:bgView];
    
    UIButton *typeBtn =  [[UIButton alloc] init];
    typeBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2,44);
    typeBtn.backgroundColor = [UIColor whiteColor];
    [typeBtn setTitle:@"全部" forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [typeBtn addTarget:self action:@selector(selectTypeClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:typeBtn];
    
    UIButton *dateBtn =  [[UIButton alloc] init];
    dateBtn.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2,44);
    dateBtn.backgroundColor = [UIColor whiteColor];
    [dateBtn setTitle:@"日期" forState:UIControlStateNormal];
    [dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(selectDateClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:dateBtn];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];

    CGRect tableframe=CGRectMake(0, 45, SCREEN_WIDTH,SCREEN_HEIGHT - 45 - 66);
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

-(void)selectTypeClick{
    
}

-(void)selectDateClick{
//    self.view.frame = CGRectMake(0, 0+65, SCREEN_WIDTH, SCREEN_HEIGHT);
//    self.view
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    datePickerView = [[UIView alloc] init];
//    datePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    datePickerView.frame = self.view.frame;
    datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    datePickerView.userInteractionEnabled = YES;
    [datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    [self.view addSubview:datePickerView];
    
    

//    datePickerMenu = [[UIView alloc] init];
    //    datePickerMenu.userInteractionEnabled = NO;
//    datePickerMenu.frame = CGRectMake(0, SCREEN_HEIGHT-216 -44, SCREEN_WIDTH, 44);    datePickerMenu.backgroundColor = [UIColor whiteColor];
//    [datePickerView addSubview:datePickerMenu];
//    UIButton *confirmBtn = [[UIButton alloc] init];
//    confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 4, 60, 36);
//    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [confirmBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
//    [datePickerMenu addSubview:confirmBtn];
//    UIButton *cancelBtn = [[UIButton alloc] init];
//    cancelBtn.frame = CGRectMake(4, 4, 60, 36);
//    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
//    [datePickerMenu addSubview:cancelBtn];
    datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0,300,SCREEN_WIDTH,SCREEN_HEIGHT)];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.datePickerMode = UIDatePickerModeDate;

    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [datePickerView addSubview:datePicker];

}

- (void)confirmEvent {
    
    NSDate *theDate = datePicker.date;
    //    NSLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@",[dateFormatter stringFromDate:theDate]);
    [self disMissView];
}
- (void)disMissView {
    
    [datePickerMenu setFrame:CGRectMake(0, SCREEN_HEIGHT - 216 -44, SCREEN_WIDTH, 44)];
    [datePicker setFrame:CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         datePickerView.alpha = 0.0;
                         
                         [datePickerMenu setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44)];
                         [datePicker setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216)];
                     }
                     completion:^(BOOL finished){
                         
                         [datePickerView removeFromSuperview];
                         //                         [datePicker removeFromSuperview];
                     }];
    
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGBillQueryTableViewCell *cell = [CGBillQueryTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.imgData = 
    cell.title.text = [[result objectAtIndex:indexPath.row] objectForKey:@"operaUser"];
    if([[[result objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"CNY"]){
        cell.amount.text = [NSString stringWithFormat:@"¥%@",[[result objectAtIndex:indexPath.row] objectForKey:@"num"]];
    }
    if([[[result objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:@"USD"]){
        cell.amount.text = [NSString stringWithFormat:@"$%@",[[result objectAtIndex:indexPath.row] objectForKey:@"num"]];
    }
    if([[[result objectAtIndex:indexPath.row] objectForKey:@"oi"] integerValue] == 0){
        cell.amount.textColor = [UIColor greenColor];
    }else{
        cell.amount.textColor = [UIColor redColor];
    }
    cell.type.text = [NSString stringWithFormat:@"[%@]",[[result objectAtIndex:indexPath.row] objectForKey:@"operaType"]];
    cell.date.text = [[result objectAtIndex:indexPath.row] objectForKey:@"operaTime"];
        
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGBillDetailsViewController *vc = [[CGBillDetailsViewController alloc] init];
    vc.liushuiID = [[result objectAtIndex:indexPath.row] objectForKey:@"snumber"];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
//    NSLog(@"%@",[[result objectAtIndex:indexPath.row] objectForKey:@"snumber"]);
}

@end
