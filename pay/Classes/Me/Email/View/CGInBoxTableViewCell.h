//
//  CGInBoxTableViewCell.h
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGInBoxTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * dateLab;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel * senderLab;
@property (nonatomic, strong) UIButton * markBtn;
@property (nonatomic, strong) UILabel * isreadLab;
+ (instancetype)cellForTableView:(UITableView *)tableView;
@end
