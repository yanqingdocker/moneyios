//
//  CGAccountBalanceTableViewCell.h
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGAccountBalanceTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLab;
@property (strong , nonatomic) NSString *key;
@property (strong , nonatomic) NSIndexPath *indexPath;
@property (strong , nonatomic) UITextField *contentText;

@property (assign , nonatomic) id delegate;

+ (CGFloat)calculateLabelHeight:(NSString *)text;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
