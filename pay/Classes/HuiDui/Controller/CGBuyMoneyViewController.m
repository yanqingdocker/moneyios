//
//  CGBuyMoneyViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/8/28.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBuyMoneyViewController.h"

@interface CGBuyMoneyViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSDictionary *_result;
    UILabel *_huilvLab;
    UITableView *_tableView;
    UITextField *_amount;
    UILabel *_duihuanAmount;
}

@end

@implementation CGBuyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestForm];
}

//这么请求有问题啊,但是后台也不好改,有空再想想怎么优化吧
- (void)requestForm{
    [[CGAFHttpRequest shareRequest] getSingleRateWithtype:[NSString stringWithFormat:@"%@%@",_sellType,_buyType] serverSuccessFn:^(id dict) {
        if(dict){
            
            
            _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
            NSLog(@"%@",_result);
            
            
            _huilvLab.text = [NSString stringWithFormat:@"当前汇率:%@",[_result objectForKey:@"sellPic"]];
            //            for (int i = 0; i<_result.count; i++) {
            //                if(![[[_result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:@"CNY"]){
            //                    NSLog(@"没有人民币账户,无法买入人民币");
            //                }
            //                if(![[[_result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:@"USD"]){
            //                    NSLog(@"没有美元账户,无法买入美元");
            //                }
            //            }
            
            //            _countType = [[_result objectAtIndex:0] objectForKey:@"countType"];
            //            _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
            //
            //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            //            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            //
            //            [_tableView reloadRowsAtIndexPaths:@[indexPath,indexPath1] withRowAnimation:UITableViewRowAnimationNone];
            //
            //            //            _nameArray = [NSArray arrayWithObjects:@"USD",@"CNY",nil];
            //            //            NSArray *_nameArray = [[NSArray alloc] init];
            //            _array  = [[NSMutableArray alloc] init];
            //            for (int i = 0; i < _result.count; i++) {
            //                [_array addObject:[NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:i] objectForKey:@"cardId"],[[_result objectAtIndex:i] objectForKey:@"countType"]]];
            //            }
            //            _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
            //                                [_tableView reloadData];
        }
    } serverFailureFn:^(NSError *error) {
        if(error){
//            NSLog(@"%@",error);
            [[CGAFHttpRequest shareRequest] getSingleRateWithtype:[NSString stringWithFormat:@"%@%@",_buyType,_sellType] serverSuccessFn:^(id dict) {
                if(dict){
                    
                    
                    _result = [NSJSONSerialization JSONObjectWithData:dict options:kNilOptions error:nil];
                    NSLog(@"%@",_result);
                    
                    _huilvLab.text = [NSString stringWithFormat:@"当前汇率:%@",[_result objectForKey:@"sellPic"]];
                    //            for (int i = 0; i<_result.count; i++) {
                    //                if(![[[_result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:@"CNY"]){
                    //                    NSLog(@"没有人民币账户,无法买入人民币");
                    //                }
                    //                if(![[[_result objectAtIndex:i] objectForKey:@"countType"] isEqualToString:@"USD"]){
                    //                    NSLog(@"没有美元账户,无法买入美元");
                    //                }
                    //            }
                    
                    //            _countType = [[_result objectAtIndex:0] objectForKey:@"countType"];
                    //            _account = [NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:0] objectForKey:@"cardId"],[[_result objectAtIndex:0] objectForKey:@"countType"]];
                    //
                    //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    //            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
                    //
                    //            [_tableView reloadRowsAtIndexPaths:@[indexPath,indexPath1] withRowAnimation:UITableViewRowAnimationNone];
                    //
                    //            //            _nameArray = [NSArray arrayWithObjects:@"USD",@"CNY",nil];
                    //            //            NSArray *_nameArray = [[NSArray alloc] init];
                    //            _array  = [[NSMutableArray alloc] init];
                    //            for (int i = 0; i < _result.count; i++) {
                    //                [_array addObject:[NSString stringWithFormat:@"%@(%@)",[[_result objectAtIndex:i] objectForKey:@"cardId"],[[_result objectAtIndex:i] objectForKey:@"countType"]]];
                    //            }
                    //            _accountID = [NSString stringWithFormat:@"%@",[[_result objectAtIndex:0] objectForKey:@"id"]];
                    //                                [_tableView reloadData];
                }
            } serverFailureFn:^(NSError *error) {
                if(error){
                    NSLog(@"%@",error);
                    
                }
            }];
        }
    }];
    
}

- (void)initNav{
    if([_buyType isEqualToString:@"USD"]){
        self.navigationItem.title = @"买入美元";
    }
    else if([_buyType isEqualToString:@"CNY"]){
        self.navigationItem.title = @"买入人民币";
    }
//    else{
//        self.navigationItem.title = @"买入资金";
//    }
    
    [self setBackButton:YES];
}

- (void)initUI{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 15, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIImageView *moneyIcon = [[UIImageView alloc] init];
    moneyIcon.frame = CGRectMake(15, 19, 40, 40);
    [bgView addSubview:moneyIcon];
    
    UILabel *selectLab = [[UILabel alloc] init];
    selectLab.textColor = RGBCOLOR(102, 102, 102);
    selectLab.font = [UIFont systemFontOfSize:18];
    [bgView addSubview:selectLab];
    [selectLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(moneyIcon.mas_right).offset(10);
        make.top.equalTo(bgView).offset(31);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@200);
    }];
    
    
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"本人已充分了解本保险产品,并承诺投保信息的真实性,理解并同意《商户协议》《保险条约》的全部内容"];
//    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, attributedStr.length) ];
//    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#01A3FE"] range:NSMakeRange(30,12)];
//    selectLab.attributedText = attributedStr;
    
    _huilvLab = [[UILabel alloc] init];
    _huilvLab.textColor = RGBCOLOR(102, 102, 102);
    _huilvLab.font = [UIFont systemFontOfSize:12];
    _huilvLab.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:_huilvLab];
    [_huilvLab mas_remakeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(bgView.mas_right).offset(-24);
        make.top.equalTo(bgView).offset(34);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@120);
    }];
    
    
    if([_buyType isEqualToString:@"USD"]){
        moneyIcon.image = [UIImage imageNamed:@"selectUSD"];
        selectLab.text = @"买入美元(USD)";
        _huilvLab.text = [NSString stringWithFormat:@"当前汇率:%@",[_result objectForKey:@"buyPic"]];//有点搞不清楚哪个用买入哪个用卖出
    }
    else if([_buyType isEqualToString:@"CNY"]){
        moneyIcon.image = [UIImage imageNamed:@"selectCNY"];
        selectLab.text = @"买入人民币(CNY)";
        _huilvLab.text = [NSString stringWithFormat:@"当前汇率:%@",[_result objectForKey:@"sellPic"]];
    }
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 70, SCREEN_WIDTH, 1);
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    
    CGRect tableframe=CGRectMake(0, 107 , SCREEN_WIDTH,94*2);
    _tableView=[[UITableView alloc]initWithFrame:tableframe style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces = NO;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UIButton *tixianBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, _tableView.frame.origin.y+_tableView.frame.size.height +22, SCREEN_WIDTH - 15*2, 36)];
    [tixianBtn setTitle:@"确认" forState:UIControlStateNormal];
    [tixianBtn setTintColor:[UIColor whiteColor]];
    [tixianBtn setBackgroundColor:RGBCOLOR(72,151,239)];//金色247, 195, 109
    [tixianBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.layer.cornerRadius = 5;
    [bgView addSubview:tixianBtn];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 94;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UILabel *duihuanjine = [[UILabel alloc] init];
    duihuanjine.font = [UIFont systemFontOfSize:18];
    duihuanjine.frame = CGRectMake(18, 32, 150, 17);
    [cell addSubview:duihuanjine];
    
    UIImageView * img = [[UIImageView alloc] init];
    img.frame = CGRectMake(18, 73, 12, 16);
    [cell addSubview:img];
    
    if(indexPath.row == 0){
        duihuanjine.text = @"兑换金额";
        if([_sellType isEqualToString:@"CNY"]){
            [img setImage:[UIImage imageNamed:@"CNYIcon"]];
            
        }
        if([_sellType isEqualToString:@"USD"]){
            [img setImage:[UIImage imageNamed:@"USDIcon"]];
        }
        
        _amount = [[UITextField alloc] init];
        _amount.frame = CGRectMake(37, 76, 320, 12);
        _amount.delegate =self;
        _amount.font = [UIFont systemFontOfSize:12];
        _amount.placeholder = [NSString stringWithFormat:@"可兑换金额:%@",_blance];
        [_amount addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell addSubview:_amount];
    }
    if(indexPath.row == 1){
        duihuanjine.text = @"兑换后金额";
        
        _duihuanAmount = [[UILabel alloc] init];
        _duihuanAmount.frame = CGRectMake(18, 76, 320, 12);
        _duihuanAmount.font = [UIFont systemFontOfSize:12];
        _duihuanAmount.text = @"0.0000";
        [cell addSubview:_duihuanAmount];
    }
    
    
    return cell;
}

-(void) textFieldChanged:(UITextField *)textField{
    
    float huilv =  [textField.text floatValue];
    
    if([_buyType isEqualToString:@"USD"]){
        
        float huilv2 = [[_result objectForKey:@"buyPic"] floatValue];
        _duihuanAmount.text = [NSString stringWithFormat:@"%0.4f",huilv / huilv2];
    }
    if([_buyType isEqualToString:@"CNY"]){
        
        float huilv2 = [[_result objectForKey:@"sellPic"] floatValue];
        _duihuanAmount.text = [NSString stringWithFormat:@"%0.4f",huilv * huilv2];
    }
    
}


-(void) confirmEvent{
    [self.view endEditing:YES];
    
}
@end
