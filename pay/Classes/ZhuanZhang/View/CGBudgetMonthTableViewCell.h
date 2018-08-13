//
//  CGBudgetMonthTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBudgetMonthTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString * month;//月份
@property (nonatomic, strong) NSString * monthzhichu;//月支出
@property (nonatomic, strong) NSString * monthshouru;//月收入
@property (nonatomic, strong) UILabel * titleLab;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
