//
//  CGOutBoxViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGOutBoxViewController.h"
#import "CGOutBoxTableViewCell.h"
#import "CGInBoxModel.h"
#import "CGEmailContentView.h"

#import "CGImageTextTableViewCell.h"
#import "CGConfirmPaymentView.h"


@interface CGOutBoxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *result;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *isRead;
@property (strong, nonatomic) CGConfirmPaymentView *confirmPaymentView;
@property (strong, nonatomic) CGEmailContentView *ECView;
@end

@implementation CGOutBoxViewController

- (void)viewDidLoad {
    _result = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self requestForm];
}

-(void)requestForm{
    [[CGAFHttpRequest shareRequest] querysendWithserverSuccessFn:^(id dict) {
        if(dict){
            
            
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
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
    self.navigationItem.title = @"发件箱";
    [self setBackButton:YES];
}

-(void)initUI{
    CGRect tableframe=CGRectMake(0, 0+15, SCREEN_WIDTH,SCREEN_HEIGHT - 15 - NAVIGATIONBAR_HEIGHT);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    //    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(22, 268, SCREEN_WIDTH - 22*2, 44)];
    //    [tixianBtn setTitle:@"提交" forState:UIControlStateNormal];
    //    [tixianBtn setTintColor:[UIColor whiteColor]];
    //    [tixianBtn setBackgroundColor:RGBCOLOR(72,151,239)];//金色247, 195, 109
    //    [tixianBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    //    tixianBtn.layer.cornerRadius = 5;
    //    [self.view addSubview:tixianBtn];
}

#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _result.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGOutBoxTableViewCell *cell = [CGOutBoxTableViewCell cellForTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[CGJiaoYiDetailsModel objectWithKeyValues:[_result objectAtIndex:0]];
    CGInBoxModel *IBModel = [CGInBoxModel objectWithKeyValues:[_result objectAtIndex:indexPath.row]];
    cell.titleLab.text = [NSString stringWithFormat:@"标题:%@",IBModel.title];
    cell.dateLab.text = IBModel.createTime;
    [cell.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
    
    //    cell.deleteBlock = ^(UITableViewCell *currentCell){
    //
    //        //获取准确的indexPath
    //
    //        NSIndexPath *currentIndexPath = [_tableView indexPathForCell:currentCell];
    //
    //        //        NSString *value = _dataArr[currentIndexPath.row];
    //
    //        [_result removeObjectAtIndex:currentIndexPath.row];
    //
    //        //beginUpdates和endUpdates中执行insert,delete,select,reload row时，动画效果更加同步和顺滑，否则动画卡顿且table的属性（如row count）可能会失效
    //
    //        [self.tableView beginUpdates];
    //
    //        //这里不能直接使用cellForRowAtIndexPath代理方法中传入的indexPath，因为在删除一次后如果继续向下删除，indexPath会因为没有刷新而产生错误
    //
    //        [self.tableView deleteRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    //
    //        [self.tableView endUpdates];
    //
    //    };
    
    
    cell.senderLab.text = [NSString stringWithFormat:@"收件人:%@",IBModel.username];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGInBoxModel *IBModel = [CGInBoxModel objectWithKeyValues:[_result objectAtIndex:indexPath.row]];
    
    _ECView = [[CGEmailContentView alloc]init];
    _ECView.titleStr = @"邮件内容";
    _ECView.content = IBModel.content;
    [_ECView showInView:self.view];
    
    
    
}

//-(void)CancelButtonClicked:(UIButton*)sender
//{
//    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
//    [sortedContacts removeObjectAtIndex:indexPath.row];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView reloadData];
//}
-(void)deleteClick:(UIButton *)btn{
    
    [[CGAFHttpRequest shareRequest] messagedeleteWithID:[[_result objectAtIndex:btn.tag] objectForKey:@"id"] serverSuccessFn:^(id dict) {
        if(dict){
            
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",result);
            
            //            _result = [_result  mutableCopy];
            //            [_result removeObjectAtIndex:btn.tag];
            //            [_tableView reloadData];
            
            [self requestForm];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
            NSLog(@"%@",error);
        }
    }];
    
}


@end
