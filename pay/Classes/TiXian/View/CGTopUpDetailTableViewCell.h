//
//  CGTopUpDetailTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGTopUpDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * dateLab;
@property (nonatomic, strong) UILabel * balanceLab;
@property (nonatomic, strong) UILabel * changeLab;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
