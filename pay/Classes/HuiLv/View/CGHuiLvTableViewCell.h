//
//  CGHuiLvTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGHuiLvTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * currency;
@property (nonatomic, strong) UILabel * buyPic;
@property (nonatomic, strong) UILabel * sellPic;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
