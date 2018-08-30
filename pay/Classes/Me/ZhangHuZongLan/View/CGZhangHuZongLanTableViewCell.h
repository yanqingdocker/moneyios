//
//  CGZhangHuZongLanTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGZhangHuZongLanTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *bgimgView;
@property (nonatomic, strong) UILabel *countType;
@property (nonatomic, strong) UIButton * eyeBtn;
@property (nonatomic, strong) UILabel * blance;
@property (nonatomic, strong) UILabel *cardId;
@property (nonatomic, strong) UIButton * closeAccount;
@property (nonatomic, strong) UIButton * inAccount;
@property (nonatomic, strong) UIButton * outAccount;
+ (instancetype)cellForTableView:(UITableView *)tableView;

@end
