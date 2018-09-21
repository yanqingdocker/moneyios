//
//  CGTitleContentTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//  标题+内容上下(cell)

#import <UIKit/UIKit.h>

@interface CGTitleContentTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UITextField * content;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
