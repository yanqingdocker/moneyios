//
//  CGSelectAccountTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGSelectAccountTableViewCell.h"

@implementation CGSelectAccountTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGSelectAccountTableViewCell";
    CGSelectAccountTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGSelectAccountTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _titleLab =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(17,
                                    11,
                                    160,
                                    14);
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab;
    });
    
    
    _accountLab =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(17,
                                    37,
                                    200,
                                    14);
        titleLab.font = [UIFont systemFontOfSize:14];
//        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_accountLab];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
