//
//  CGTitleAndTextTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGTitleAndTextTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (strong , nonatomic) UITextField *contentText;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
