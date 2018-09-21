//
//  CGConfirmPaymentView.m
//  pay
//
//  Created by v2 on 2018/8/7.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGConfirmPaymentView.h"
#import "CGBounceView.h"
#import "XLPasswordView.h"
#define CGConfirmPaymentViewHight 400

@interface CGConfirmPaymentView ()<UITableViewDelegate, UITableViewDataSource,XLPasswordViewDelegate>{
    UIView *_contentView;
    CGBounceView *_accountBV;
    NSMutableArray *_array;
    NSString *_accountType;
    NSString *_accountID;
    //    UITableView *detailTableView;
    UIView *fukuanfangshiView;
    UIButton *paymentBtn;
    UITableView *detailTableView;
    
//    UITableView *fukuanfangshiTableView;
}
@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic, strong) UITableView *fukuanfangshiTableView;
@property (nonatomic, strong) NSIndexPath *lastIndex;

@end

@implementation CGConfirmPaymentView

- (void)viewDidLoad {
    [super viewDidLoad];
    _array  = [[NSMutableArray alloc] init];
    if(_type){
        for (int i = 0; i < _dataArray.count; i++) {
            [_array addObject:[NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:i] objectForKey:@"countType"]]];
        }
        _accountType = [NSString stringWithFormat:@"%@", [[_dataArray objectAtIndex:0] objectForKey:@"countType"]];
        _accountID = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:0] objectForKey:@"id"]];
    }else{
//        for (int i = 0; i < _dataArray.count; i++) {
//            [_array addObject:_dataArray[i]];
//        }
        
            _accountType = [_dataArray[0] objectForKey:@"bankType"];
            _accountID = [_dataArray[0] objectForKey:@"bankCard"];//id
        
        
    }
    

    [self setupContent];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _lastIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_fukuanfangshiTableView selectRowAtIndexPath:_lastIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
    
    [self tableView:_fukuanfangshiTableView didSelectRowAtIndexPath:path];
    
}

- (void)setupContent {
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (_contentView == nil) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGConfirmPaymentViewHight , SCREEN_WIDTH, CGConfirmPaymentViewHight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
        // 右上角关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(20, 10, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:closeBtn];
        
        //title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        titleLabel.text = @"确认付款";
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:titleLabel];
        
        UILabel *line = [[UILabel alloc] init];
        line.frame = CGRectMake(0, 48, SCREEN_WIDTH, 1);
        line.backgroundColor = [UIColor lightGrayColor];
        [_contentView addSubview:line];
        
        UILabel *jine = [[UILabel alloc] initWithFrame:CGRectMake(0, 77, SCREEN_WIDTH, 36)];
        jine.text = [NSString stringWithFormat:@"充值金额:%@元",_amount];
        jine.textColor = RGBCOLOR(1, 1, 1);
        jine.font = [UIFont systemFontOfSize:18];
        jine.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:jine];
        
        paymentBtn = [[UIButton alloc] init];
        paymentBtn.frame = CGRectMake(15, 370 - NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH - 15*2, 50);
        [paymentBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [paymentBtn addTarget:self action:@selector(paymentEvent) forControlEvents:UIControlEventTouchUpInside];
        paymentBtn.layer.cornerRadius = 5;
        [paymentBtn setBackgroundColor:RGBCOLOR(26,132,207)];
        [_contentView addSubview:paymentBtn];
    }
    
    detailTableView = [[UITableView alloc] init];
    detailTableView.backgroundColor = [UIColor clearColor];
    detailTableView.frame = CGRectMake(0, 147, SCREEN_WIDTH, 89);
    [_contentView addSubview:detailTableView];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    self.detailTableView = detailTableView;
//    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _fukuanfangshiTableView){
        return _dataArray.count;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == _fukuanfangshiTableView){
        static NSString *identifire = @"CellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(_type){
            
            cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"];
        }else{
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@logo",[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankType"]]];
            cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankType"];
            NSInteger row = [indexPath row];
            
            
            
            NSInteger oldRow = [_lastIndex row];
            
            
            
            if (row == oldRow && _lastIndex!=nil) {
                
                
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                
                
            }else{
                
                
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                
                
            }
        }
        
        
        return cell;
    }else{
        static NSString *ID = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
            
            cell.backgroundColor = [UIColor clearColor];
            
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            cell.textLabel.textColor = RGBCOLOR(134, 134, 134);
            cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(indexPath.row == 0){
            
            cell.textLabel.text = _cellTextLabel1;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", _phoneNum];
        }
        if(indexPath.row == 1){
            cell.textLabel.text = _cellTextLabel2;
            cell.detailTextLabel.text = _accountType;
            //        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _fukuanfangshiTableView){
        if(_type){
            _accountID = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
            
            _accountType = [NSString stringWithFormat:@"%@", [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"countType"]];
            
        }else{
            _accountID = [NSString stringWithFormat:@"%@",[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankCard"]];
            
            _accountType = [NSString stringWithFormat:@"%@", [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"bankType"]];
            
            NSInteger newRow = [indexPath row];
            
            
            
            NSInteger oldRow = (_lastIndex !=nil)?[_lastIndex row]:-1;
            
            
            
            if (newRow != oldRow) {
                
                
                
                UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
                
                
                
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                
                
                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastIndex];
                
                
                
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                
                
                
                _lastIndex = indexPath;
                
                
                
            }
        }
        
        [_detailTableView reloadData];
        [self gobackView];
    }else{
        if (indexPath.row == 1){
            fukuanfangshiView = [[UIView alloc] init];
            fukuanfangshiView.frame = _contentView.bounds;
            fukuanfangshiView.backgroundColor = [UIColor whiteColor];
            [_contentView addSubview:fukuanfangshiView];
            
            // 右上角关闭按钮
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            closeBtn.frame = CGRectMake(20, 10, 20, 20);
            [closeBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(gobackView) forControlEvents:UIControlEventTouchUpInside];
            [fukuanfangshiView addSubview:closeBtn];
            
            //title
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            titleLabel.text = @"选择付款方式";
            titleLabel.font = [UIFont systemFontOfSize:20];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [fukuanfangshiView addSubview:titleLabel];
            
            UILabel *line = [[UILabel alloc] init];
            line.frame = CGRectMake(0, 48, SCREEN_WIDTH, 1);
            line.backgroundColor = [UIColor lightGrayColor];
            [fukuanfangshiView addSubview:line];
            
        }
        
        _fukuanfangshiTableView = [[UITableView alloc] init];
        _fukuanfangshiTableView.backgroundColor = [UIColor clearColor];
        _fukuanfangshiTableView.frame = CGRectMake(0, 49, SCREEN_WIDTH, fukuanfangshiView.frame.size.height - 49);
        [fukuanfangshiView addSubview:_fukuanfangshiTableView];
        _fukuanfangshiTableView.delegate = self;
        _fukuanfangshiTableView.dataSource = self;
        [_fukuanfangshiTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
}

- (void)paymentEvent{
    
    _selectbankcardblock(_accountID);
    [self disMissView];

}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self.view];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CGConfirmPaymentViewHight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.alpha = 1.0;
        
//        if(_amount){
            [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT - CGConfirmPaymentViewHight- NAVIGATIONBAR_HEIGHT , SCREEN_WIDTH, CGConfirmPaymentViewHight)];
            
//        }else{
//            [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT - CGConfirmPaymentViewHight- NAVIGATIONBAR_HEIGHT +36, SCREEN_WIDTH, CGConfirmPaymentViewHight)];
//            paymentBtn.frame = CGRectMake(15, 370 - NAVIGATIONBAR_HEIGHT - 36, SCREEN_WIDTH - 15*2, 50);
//            detailTableView.frame = CGRectMake(0, 147 - 36, SCREEN_WIDTH, 89);
//        }
        
    } completion:nil];
}
- (void)disMissView {
    
    [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT - CGConfirmPaymentViewHight, SCREEN_WIDTH, CGConfirmPaymentViewHight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.view.alpha = 0.0;
                         
                         [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, CGConfirmPaymentViewHight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self.view removeFromSuperview];
                         [_contentView removeFromSuperview];
                         
                     }];
    
}

-(void)gobackView{
    [fukuanfangshiView removeFromSuperview];
}

@end
