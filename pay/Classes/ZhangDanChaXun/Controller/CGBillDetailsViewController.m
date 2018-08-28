//
//  CGBillDetailsViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/27.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBillDetailsViewController.h"
#import "CGJiaoYiDetailsModel.h"

@interface CGBillDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_result;
    CGJiaoYiDetailsModel *_jyModel;
    UILabel *nameLab;
    UILabel *amountLab;
}
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CGBillDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self requestForm];
}

- (void)requestForm{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[CGAFHttpRequest shareRequest] queryByIdWithid:_liushuiID serverSuccessFn:^(id dict) {
                if(dict){
                    
                    
                    _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    NSLog(@"%@",_result);
                    
                    _jyModel = [CGJiaoYiDetailsModel objectWithKeyValues:[_result objectAtIndex:0]];
                    
                    nameLab.text = _jyModel.operaUser;
                    amountLab.text = _jyModel.num;
                    
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
    self.navigationItem.title = @"账单详情";
    [self setBackButton:YES];
}

-(void)initUI{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIImageView *headImgView = [[UIImageView alloc] init];
    headImgView.frame = CGRectMake(SCREEN_WIDTH/2 - 50, 26, 25, 25);
    //圆形图片
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headImgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:headImgView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = headImgView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    headImgView.layer.mask = maskLayer;
    
//    if(_dataArray){
//        NSData *data=[[NSData alloc] initWithBase64EncodedString:[_dataArray objectForKey:@"img"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
//        headImgView.image = [UIImage imageWithData:data];
//
//    }else{
        headImgView.image = [UIImage imageNamed:@"headImg"];
//    }
    
    [bgView addSubview:headImgView];
    
    nameLab = [[UILabel alloc] init];
    nameLab.frame = CGRectMake(SCREEN_WIDTH/2 + 7 -25, 30, 120, 14);
    nameLab.text = @"用户名称";//默认值
    nameLab.font = [UIFont systemFontOfSize:14];
//    nameLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:nameLab];
    
    amountLab = [[UILabel alloc] init];
    amountLab.text = @"";//默认值
    amountLab.textColor = [UIColor blackColor];
    amountLab.textAlignment = NSTextAlignmentCenter;
    amountLab.font = [UIFont systemFontOfSize:24];
    [bgView addSubview:amountLab];
    [amountLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(bgView).offset(67);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(@19);
        make.width.mas_equalTo(@200);
    }];
    
    UILabel *successLab = [[UILabel alloc] init];
    successLab.text = @"交易成功";
    successLab.textColor = RGBCOLOR(102, 102, 102);
    successLab.textAlignment = NSTextAlignmentCenter;
    successLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:successLab];
    [successLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(bgView).offset(103);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(@13);
        make.width.mas_equalTo(@200);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 149, SCREEN_WIDTH, 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    
    CGRect tableframe=CGRectMake(0, 150, SCREEN_WIDTH,SCREEN_HEIGHT - 150 - 66);
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
    return 10;
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
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"账户操作人";
            cell.detailTextLabel.text = _jyModel.operaUser;
            break;
        case 1:
            cell.textLabel.text = @"货币类型";
            cell.detailTextLabel.text = _jyModel.countType;
            break;
        case 2:
            cell.textLabel.text = @"账户ID";
            cell.detailTextLabel.text = _jyModel.countid;
            break;
        case 3:
            cell.textLabel.text = @"交易网点";
            cell.detailTextLabel.text = _jyModel.servicebranch;
            break;
        case 4:
            cell.textLabel.text = @"收支类型";
            if([_jyModel.oi integerValue] == 1){
                cell.detailTextLabel.text = @"收入";
            }else{
                cell.detailTextLabel.text = @"支出";
            }
            break;
        case 5:
            cell.textLabel.text = @"转账时间";
            cell.detailTextLabel.text = _jyModel.operaTime;
            break;
        case 6:
            cell.textLabel.text = @"流水号";
            cell.detailTextLabel.text = _jyModel.snumber;
            break;
        case 7:
            cell.textLabel.text = @"对订单有疑问";
//            cell.detailTextLabel.text = _jyModel.;
            break;
        case 8:
            cell.textLabel.text = @"查看往来记录";
//            cell.detailTextLabel.text = _jyModel.;
            break;
        case 9:
            cell.textLabel.text = @"备注";
            cell.detailTextLabel.text = @"未设置";
            break;
            
        default:
            break;
    }
    
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"交易类型";
//        if(_jyModel.){
//            cell.detailTextLabel.text = _jyModel.;
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
//
//    }
//    if (indexPath.row == 1) {
//        cell.textLabel.text = @"货币类型";
//        if([_result objectForKey:@"countType"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"countType"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
//    }
//    if (indexPath.row == 2) {
//        cell.textLabel.text = @"交易时间";
//        if([_result objectForKey:@"operaTime"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"operaTime"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
//    }
//    if (indexPath.row == 3) {
//        cell.textLabel.text = @"流水号";
//        if([_result objectForKey:@"snumber"]){
//            cell.detailTextLabel.text = [_result objectForKey:@"snumber"];
//        }else{
//            cell.detailTextLabel.text = @"";
//        }
//
//    }
    
    return cell;
}
@end
