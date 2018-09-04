//
//  CGAccountDisplayViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/3.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGAccountDisplayViewController.h"
#import "CGTextSelectTableViewCell.h"

@interface CGAccountDisplayViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray * _dataArray;
    NSArray * allkeys;
}
@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@end

@implementation CGAccountDisplayViewController

- (void)viewDidLoad {

    _dataArray  = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self requestForm];
}


- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{//queryMoneyTypeWithserverSuccessFn
            [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
                if(dict){
                    
                    _dataArray = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    
                    NSLog(@"%@",_dataArray);
//                    allkeys = [_dataArray allKeys];
                    
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
    self.navigationItem.title = @"账户设置";
    [self setBackButton:YES];
}

- (void)initUI{
    
    
    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@defaultCountType",[GlobalSingleton Instance].currentUser.userid]];
    
    UILabel *tips = [[UILabel alloc] init];
    tips.frame = CGRectMake(8, 9, 280,12);
    tips.text = @"选择您需要在个人中心显示的账户";
    tips.textColor = RGBCOLOR(153,153,153);
    tips.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tips];
    
    CGRect tableframe=CGRectMake(0, 25, SCREEN_WIDTH,SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 25);
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGTextSelectTableViewCell *cell = [CGTextSelectTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
//    __weak typeof(self) weakSelf = self;
    __block CGTextSelectTableViewCell *  weakCell = cell;
//    if (_selIndex == 0 && indexPath.row == 0) {
//        weakCell.selectImg.image = [UIImage imageNamed:@"addIcon"];
//    }
    
    if ([[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@defaultCountType",[GlobalSingleton Instance].currentUser.userid]]]) {
        weakCell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    }
    //当上下滑动时因为cell复用，需要判断哪个选择了
    else if (_selIndex == indexPath) {
        weakCell.selectImg.image = [UIImage imageNamed:@"selectIcon"];
    }else{
        weakCell.selectImg.image = [UIImage imageNamed:@"unselectIcon"];
    }

    
    return cell;
    
//    static NSString *ID = @"CGAccountDisplaycell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//
//    if (cell == nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//
//    cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
//
//    _selectImage.frame = CGRectMake(SCREEN_WIDTH - 15 -22 , 11, 22,22);
//    [cell addSubview:_selectImage];
////    if(indexPath.row == whichOne){
////        _selectImage.image = [UIImage imageNamed:@"bitcoin"];
////    }else{
////
////        _selectImage.image = [UIImage imageNamed:@"addIcon"];
////    }
//
//    NSInteger row = [indexPath row];
//
//    NSInteger oldRow = [_lastPath row];
//
//    if (row == oldRow && _lastPath!=nil) {
//
//        //这个是系统中对勾的那种选择框
//
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
////        _selectImage.image = [UIImage imageNamed:@"addIcon"];
//
//    }else{
//
//        cell.accessoryType = UITableViewCellAccessoryNone;
////        _selectImage.image = [UIImage imageNamed:@"bitcoin"];
//    }
//
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGTextSelectTableViewCell *celld = [tableView cellForRowAtIndexPath:_selIndex];
//    celld.selectImg.image = [UIImage imageNamed:@"未选"];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
//    CGTextSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectImg.image = [UIImage imageNamed:@"sele"];
    [_tableView reloadData];
    
//    _defaultCountType = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"] forKey:[NSString stringWithFormat:@"%@defaultCountType",[GlobalSingleton Instance].currentUser.userid]];
    
    [GlobalSingleton Instance].currentUser.defaultcount = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
    
    
    [self UpdateDefaultCount:[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"]];
//    NSInteger newRow = [indexPath row];
//
//    NSInteger oldRow = (self .lastPath !=nil)?[self .lastPath row]:-1;
//
//    if (newRow != oldRow) {
//
//        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//
//        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
//
//        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath];
//
//        oldCell.accessoryType = UITableViewCellAccessoryNone;
//
//        self .lastPath = indexPath;
//
//    }
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)UpdateDefaultCount:(NSString *)counttype{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] updatedefaultcountWithcounttype:counttype  serverSuccessFn:^(id dict) {
                if(dict){
                    
                    NSDictionary *dataArray = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    
                    NSLog(@"%@",dataArray);
                    
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                }
            }];
        });
    });
    
}

@end

