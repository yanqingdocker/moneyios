//
//  CGBankCardListViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBankCardListViewController.h"
#import "CGAddBankCardViewController.h"
#import "CGBankCardListTableViewCell.h"
#import "CGBankCardModel.h"
@interface CGBankCardListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  NSMutableArray *result;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CGBankCardModel *BCModel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *defaultImg;
@property (strong, nonatomic) UILabel *defaultLab;
@property (strong, nonatomic) UIButton *defaultBtn;

@end

@implementation CGBankCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void) viewWillAppear:(BOOL)animated{
    
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] queryWithserverSuccessFn:^(id dict) {
        if(dict){
            NSMutableArray *result = dict[@"data"];
            NSLog(@"%@",result);
            if(result.count == 0){
                _defaultImg.image = [UIImage imageNamed:@"bankCardDefault"];
                _defaultImg.hidden = NO;
                _defaultLab.text = @"您目前还没有添加银行卡!";
                _defaultLab.hidden = NO;
                _defaultBtn.hidden = NO;
            }else{
                _defaultImg.hidden = YES;
                _defaultLab.hidden = YES;
                _defaultBtn.hidden = YES;
                _result = [result mutableCopy];
            }
            [_tableView reloadData];
            
            
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            if(error.code == -1009 || error.code == -1001){
                _defaultImg.image = [UIImage imageNamed:@"nonetWork"];
                _defaultImg.hidden = NO;
                _defaultLab.text = @"呀,网络好像不给力!";
                _defaultLab.hidden = NO;
            }
            NSLog(@"%@",error);
        }
    }];
}

- (void)initNav{
    self.navigationItem.title = @"银行卡";
    [self setBackButton:YES];
    
    UIButton *addBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankCardBtn.frame = CGRectMake(0, 0, 50, 50);
    addBankCardBtn.titleLabel.font = [UIFont systemFontOfSize: 24];
    [addBankCardBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBankCardBtn addTarget:self action:@selector(addBankCardEvent) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBankCardBtn];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT -NAVIGATIONBAR_HEIGHT);
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
    
    _defaultImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    _defaultImg.image=[UIImage imageNamed:@"bankCardDefault"];
    _defaultImg.hidden = YES;
    [self.view addSubview:_defaultImg];
    
    _defaultLab = [[UILabel alloc] init];
    _defaultLab.text = @"您目前还没有添加银行卡!";
    _defaultLab.frame = CGRectMake(0, SCREEN_HEIGHT /2-55, SCREEN_WIDTH, 44);
    _defaultLab.textAlignment = NSTextAlignmentCenter;
    _defaultLab.textColor = RGBCOLOR(153,153,153);
    _defaultLab.hidden = YES;
    [self.view addSubview:_defaultLab];
    
    _defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _defaultBtn.frame = CGRectMake(20, SCREEN_HEIGHT /2-10, self.view.frame.size.width - 40, 40);
    [_defaultBtn setTitleColor:RGBCOLOR(85,135,243) forState:UIControlStateNormal];
    [_defaultBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
    [_defaultBtn setTitle:@"开通银行卡" forState:UIControlStateNormal];
    [_defaultBtn setBackgroundImage:[UIImage imageNamed:@"dottedLine"] forState:UIControlStateNormal];
    [_defaultBtn addTarget:self action:@selector(addBankCardEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_defaultBtn];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGBankCardListTableViewCell *cell = [CGBankCardListTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    _BCModel = [CGBankCardModel objectWithKeyValues:[_result objectAtIndex:indexPath.row]];
    
    [cell.bgimgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@bg",_BCModel.bankType]]];
    [cell.logoimgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@logo",_BCModel.bankType]]];
    cell.bankType.text = _BCModel.bankType;
    
    cell.bankCard.text = [self getNewBankNumWitOldBankNum:_BCModel.bankCard];
    
    cell.untying.tag = indexPath.row;
    [cell.untying addTarget:self action:@selector(untyingEvent:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

//-(NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum
//{
//    NSMutableString *mutableStr;
//    if (bankNum.length) {
//        mutableStr = [NSMutableString stringWithString:bankNum];
//        for (int i = 0 ; i < mutableStr.length; i ++) {
//            if (i>3&&i<mutableStr.length - 4) {
//                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
//            }
//        }
//        NSString *text = mutableStr;
//        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
//        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
//        NSString *newString = @"";
//        while (text.length > 0) {
//            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
//            newString = [newString stringByAppendingString:subString];
//            if (subString.length == 4) {
//                newString = [newString stringByAppendingString:@" "];
//            }
//            text = [text substringFromIndex:MIN(text.length, 4)];
//        }
//        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
//        return newString;
//    }
//    return bankNum;
//
//}

-(void)untyingEvent:(UIButton *)button {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认解绑银行卡?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _BCModel = [CGBankCardModel objectWithKeyValues:[_result objectAtIndex:button.tag]];
        [[CGAFHttpRequest shareRequest] unbindWithID:_BCModel.id serverSuccessFn:^(id dict) {
            if(dict){
                
//                NSDictionary *result = dict[@"data"];
                if ([[dict objectForKey:@"code"] isEqualToString:@"1004"]) {
                    [MBProgressHUD showText:[dict objectForKey:@"message"] toView:self.view];
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


-(void)addBankCardEvent{
    CGAddBankCardViewController *vc = [[CGAddBankCardViewController alloc] init];
    [self pushViewControllerHiddenTabBar:vc animated:YES];
}

@end
