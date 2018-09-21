//
//  CGImageTextTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/8/29.
//  Copyright © 2018年 v2. All rights reserved.
//  图文(cell)

#import <UIKit/UIKit.h>

@interface CGImageTextTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * titleLab;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
