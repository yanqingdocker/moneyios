//
//  CGTextSelectTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/9/4.
//  Copyright © 2018年 v2. All rights reserved.
//单选(cell)

#import <UIKit/UIKit.h>

@interface CGTextSelectTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UIImageView * selectImg;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
