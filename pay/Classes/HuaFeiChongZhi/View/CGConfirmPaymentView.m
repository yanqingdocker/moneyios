//
//  CGConfirmPaymentView.m
//  pay
//
//  Created by v2 on 2018/8/7.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGConfirmPaymentView.h"
#define CGConfirmPaymentViewHight 400

@interface CGConfirmPaymentView ()<UITableViewDelegate, UITableViewDataSource>{
    UIView *_contentView;
    //    UITableView *detailTableView;
}
@property (nonatomic, strong) UITableView *detailTableView;


@end

@implementation CGConfirmPaymentView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupContent];
}

- (void)setupContent {
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (_contentView == nil) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CGConfirmPaymentViewHight, SCREEN_WIDTH, CGConfirmPaymentViewHight)];
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
        
        UILabel *amountLab = [[UILabel alloc] init];
        amountLab.frame = CGRectMake(0, 77, SCREEN_WIDTH, 36);
        amountLab.text = _amount;
        amountLab.font = [UIFont systemFontOfSize:37];
        amountLab.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:amountLab];
        
        UIButton *paymentBtn = [[UIButton alloc] init];
        paymentBtn.frame = CGRectMake(15, 370, SCREEN_WIDTH - 15*2, 50);
        [paymentBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [paymentBtn addTarget:self action:@selector(paymentEvent) forControlEvents:UIControlEventTouchUpInside];
        paymentBtn.layer.cornerRadius = 5;
        [paymentBtn setBackgroundColor:RGBCOLOR(26,132,207)];
        [_contentView addSubview:paymentBtn];
    }
    
    UITableView *detailTableView = [[UITableView alloc] init];
    detailTableView.backgroundColor = [UIColor clearColor];
    detailTableView.frame = CGRectMake(0, 147, SCREEN_WIDTH, 89);
    [_contentView addSubview:detailTableView];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    self.detailTableView = detailTableView;
//    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    // 假数据
    
    if(indexPath.row == 0){
        
        cell.textLabel.text = _cellTextLabel1;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", _phoneNum];
//        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    if(indexPath.row == 1){
        
        cell.textLabel.text = _cellTextLabel2;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", @"支付宝"];
//        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == _tuanModel.count){
//        NSLog(@"去新界面");
//    }else{
//
//        _selectbankcardblock([_tuanModel objectAtIndex:indexPath.row]);
//        [self disMissView];
//    }
}

- (void)paymentEvent{
    NSLog(@"支付成功");
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
        
        [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT - CGConfirmPaymentViewHight, SCREEN_WIDTH, CGConfirmPaymentViewHight)];
        
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

@end
