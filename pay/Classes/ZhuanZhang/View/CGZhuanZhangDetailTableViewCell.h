//
//  CGZhuanZhangDetailTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGZhuanZhangDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * typeLab;//类型
@property (nonatomic, strong) UILabel * moneyLab;//金额
@property (nonatomic, strong) UILabel * dateLab;//日期
@property (nonatomic, strong) UILabel * stateLab;//状态
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
