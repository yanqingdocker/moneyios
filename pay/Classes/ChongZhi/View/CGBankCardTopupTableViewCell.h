//
//  CGBankCardTopupTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/9/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBankCardTopupTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * moneyTypeIcon;
@property (strong , nonatomic) UILabel *moneyTypeLab;
@property (nonatomic, strong) UIImageView * selectImg;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
