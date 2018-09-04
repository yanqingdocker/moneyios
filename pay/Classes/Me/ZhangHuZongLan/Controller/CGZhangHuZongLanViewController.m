//
//  CGZhangHuZongLanViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhangHuZongLanViewController.h"
#import "CGZhangHuZongLanModel.h"
#import "CGZhangHuZongLanTableViewCell.h"
#import "CGCreatAccountViewController.h"

@interface CGZhangHuZongLanViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL flag;
    int sum;
    int sum1;
}
@property (strong, nonatomic)  NSMutableArray *result;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) CGZhangHuZongLanModel *ZHZLModel;
@end

@implementation CGZhangHuZongLanViewController

- (void)viewDidLoad {
    sum = 0;
    sum1 = 0;
    flag = true;
    _result = [[NSMutableArray alloc] init];
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated{
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryCountByUseridWithserverSuccessFn:^(id dict) {
        if(dict){
            
            NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            _result = [result mutableCopy];
            NSLog(@"%@",_result);
            
            [_tableView reloadData];
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
}

- (void)initNav{
    self.navigationItem.title = @"账户总览";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,SCREEN_HEIGHT - 15 -NAVIGATIONBAR_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self addFooterView];
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
        [sureBtn setTitleColor:RGBCOLOR(85,135,243) forState:UIControlStateNormal];
        [sureBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
        [sureBtn setTitle:@"开通账户" forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"dottedLine"] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(createAccountClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
        [footerView addSubview:sureBtn];
        
        _footerView = footerView;
    }
    
    _tableView.tableFooterView = _footerView;
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGZhangHuZongLanTableViewCell *cell = [CGZhangHuZongLanTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _ZHZLModel = [CGZhangHuZongLanModel objectWithKeyValues:[_result objectAtIndex:indexPath.row]];
    
    if ([_ZHZLModel.countType isEqualToString:@"CNY"]) {
        [cell.bgimgView setImage:[UIImage imageNamed:@"bgImgCNY"]];
        cell.countType.text = @"人民币总资产(CNY)";
    }else if ([_ZHZLModel.countType isEqualToString:@"USD"]) {
        [cell.bgimgView setImage:[UIImage imageNamed:@"bgImgUSD"]];
        cell.countType.text = @"美元总资产(USD)";
    }
    

//    UIButton *button = [[UIButton alloc] init];
//    button.frame = CGRectMake(SCREEN_WIDTH - 59 -21, 24, 21, 9);
//    [button setImage:[UIImage imageNamed:@"eye_open_white"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
//    button.tag = indexPath.row;
//    [cell addSubview:button];
    
    [cell.eyeBtn setImage:[UIImage imageNamed:@"eye_open_white"] forState:UIControlStateNormal];
    [cell.eyeBtn setImage:[UIImage imageNamed:@"eye_close_white"] forState:UIControlStateSelected];
    [cell.eyeBtn addTarget:self action:@selector(eyeEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.eyeBtn.tag = indexPath.row;
    
    cell.closeAccount.tag = indexPath.row;
    [cell.closeAccount addTarget:self action:@selector(closeAccountEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.blance.text = _ZHZLModel.blance;
    cell.cardId.text = [self getNewBankNumWitOldBankNum:_ZHZLModel.cardId];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0){
//        CGSendMessageViewController *vc = [[CGSendMessageViewController alloc] init];
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
//    if (indexPath.row == 1){
//        CGInBoxViewController *vc = [[CGInBoxViewController alloc] init];
//        //        vc.title = @"水费代缴";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
//    if (indexPath.row == 2){
//        CGOutBoxViewController *vc = [[CGOutBoxViewController alloc] init];
//        //        vc.title = @"电费代缴";
//        [self pushViewControllerHiddenTabBar:vc animated:YES];
//    }
}

-(void)eyeEvent:(UIButton *)button {
    _ZHZLModel = [CGZhangHuZongLanModel objectWithKeyValues:[_result objectAtIndex:button.tag]];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"blance%ld",(long)button.tag]]){
        [[NSUserDefaults standardUserDefaults] setObject:_ZHZLModel.blance forKey:[NSString stringWithFormat:@"blance%ld",(long)button.tag]];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:[NSString stringWithFormat:@"flag%ld",(long)button.tag]];
    }else{
        if(![[NSString stringWithFormat:@"%@",[[_result objectAtIndex:button.tag] objectForKey:@"blance"]]   isEqualToString:@"****"]){
            if([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"blance%ld",(long)button.tag]] floatValue] != [[[_result objectAtIndex:button.tag] objectForKey:@"blance"] floatValue]){
                [[NSUserDefaults standardUserDefaults] setObject:[[_result objectAtIndex:button.tag] objectForKey:@"blance"] forKey:[NSString stringWithFormat:@"blance%ld",(long)button.tag]];
            }
        }
        
    }
    button.selected = !button.selected;
//    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"flag%ld",(long)button.tag]]
    
    
    if(button.selected){
        
//        NSLog(@"闭眼");
//        _ZHZLModel.blance = @"****";
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];

        NSDictionary *item = [_result objectAtIndex:button.tag];

        NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];

        [mutableItem setObject:@"****" forKey:@"blance"];
        
        [_result replaceObjectAtIndex:button.tag withObject:mutableItem];
////        button.selected = NO;
//        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView reloadData];
//        [button setImage:[UIImage imageNamed:@"eye_close_white"] forState:UIControlStateNormal];
        
//        if (sum == 0) {
//            [self eyeEvent:button];
//            sum = 1;
//        }else{
//            sum = 0;
//        }
        
//        [[NSUserDefaults standardUserDefaults] setBool:false forKey:[NSString stringWithFormat:@"flag%ld",(long)button.tag]];
        
//        flag = false;
    }else{
//        NSLog(@"睁眼");
//        _blance.text = ZHZLModel.blance;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
        
        NSDictionary *item = [_result objectAtIndex:button.tag];
        
        NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
        
        [mutableItem setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"blance%ld",(long)button.tag]] forKey:@"blance"];
        
        [_result replaceObjectAtIndex:button.tag withObject:mutableItem];
////        button.selected = YES;
//        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView reloadData];
//        [button setImage:[UIImage imageNamed:@"eye_open_white"] forState:UIControlStateNormal];
        
//        [[NSUserDefaults standardUserDefaults] setBool:true forKey:[NSString stringWithFormat:@"flag%ld",(long)button.tag]];
//        flag = true;
//        if (sum == 0) {
//            [self eyeEvent:button];
//            sum = 1;
//        }else{
//            sum = 0;
//        }
    }
    
    
    //    _blance.secureTextEntry = !_blance.secureTextEntry;
}

-(void)closeAccountEvent:(UIButton *)button {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认注销账户?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _ZHZLModel = [CGZhangHuZongLanModel objectWithKeyValues:[_result objectAtIndex:button.tag]];
        [[CGAFHttpRequest shareRequest] logoutCountWithID:_ZHZLModel.id serverSuccessFn:^(id dict) {
            if(dict){
                
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                if ([[result objectForKey:@"code"] isEqualToString:@"fail"]) {
                    [MBProgressHUD showText:[result objectForKey:@"message"] toView:self.view];
                }else{
                    [self requestForm];
                }
                
            }
        } serverFailureFn:^(NSError *error) {
            if(error){
                NSLog(@"%@",error);
            }
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:skipAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



-(void)createAccountClick{
    CGCreatAccountViewController *vc = [[CGCreatAccountViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

@end
