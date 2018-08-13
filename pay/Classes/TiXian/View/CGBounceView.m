//
//  CGBounceView.m
//  pay
//
//  Created by v2 on 2018/8/3.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBounceView.h"

#define ZLBounceViewHight 400
#define ZLTuanNumViewHight 200

@interface CGBounceView ()<UITableViewDelegate, UITableViewDataSource>{
    UIView *_contentView;
//    UITableView *detailTableView;
}
@property (nonatomic, strong) UITableView *detailTableView;


@end

@implementation CGBounceView

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
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - ZLTuanNumViewHight, SCREEN_WIDTH, ZLBounceViewHight)];
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
        titleLabel.text = @"选择储值银行卡";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:titleLabel];
    }
    
    UITableView *detailTableView = [[UITableView alloc] init];
    detailTableView.backgroundColor = [UIColor clearColor];
    detailTableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, ZLBounceViewHight - 40);
    [_contentView addSubview:detailTableView];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    self.detailTableView = detailTableView;
    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tuanModel.count+1;
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
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
//        cell.textLabel.textColor = ZLColor(102, 102, 102);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
//        cell.detailTextLabel.textColor = ZLColor(102, 102, 102);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 假数据
    
//    cell.detailTextLabel.text = @"已购";
    if(indexPath.row == _tuanModel.count){
        cell.textLabel.text = @"使用新卡储值";
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [_tuanModel objectAtIndex:indexPath.row]];
    }
    
//    self.total.text = [NSString stringWithFormat:@"总计:%@吨", @"100"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _tuanModel.count){
        NSLog(@"去新界面");
    }else{
        
        _selectbankcardblock([_tuanModel objectAtIndex:indexPath.row]);
        [self disMissView];
    }
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self.view];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ZLBounceViewHight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.alpha = 1.0;
        
        [self->_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT - ZLBounceViewHight, SCREEN_WIDTH, ZLBounceViewHight)];
        
    } completion:nil];
}
- (void)disMissView {
    
    [_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT - ZLBounceViewHight, SCREEN_WIDTH, ZLBounceViewHight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.view.alpha = 0.0;
                         
                         [self->_contentView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, ZLBounceViewHight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self.view removeFromSuperview];
                         [self->_contentView removeFromSuperview];
                         
                     }];
    
}


@end
