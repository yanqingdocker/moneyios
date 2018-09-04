//
//  CGBankCardListTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBankCardListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgimgView;
@property (nonatomic, strong) UIImageView *logoimgView;
@property (nonatomic, strong) UILabel *bankType;
@property (nonatomic, strong) UILabel *bankCard;
@property (nonatomic, strong) UIButton *untying;
+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
