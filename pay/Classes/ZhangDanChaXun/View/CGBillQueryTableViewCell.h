//
//  CGBillQueryTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/8/26.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBillQueryTableViewCell : UITableViewCell
@property (nonatomic, strong) NSData * imgData;
@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UILabel * amount;
@property (nonatomic, strong) UILabel * type;
@property (nonatomic, strong) UILabel * date;


+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
