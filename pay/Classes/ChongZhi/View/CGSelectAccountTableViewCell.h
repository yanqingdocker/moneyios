//
//  CGSelectAccountTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGSelectAccountTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * accountLab;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
