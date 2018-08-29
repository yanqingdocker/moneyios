//
//  CGImageTextTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/8/29.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGImageTextTableViewCell.h"

@implementation CGImageTextTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGImageTextTableViewCell";
    CGImageTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGImageTextTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    
    _icon =     ({
        UIImageView * icon = [[UIImageView alloc]init];
        icon.frame = CGRectMake(17,
                                    20,
                                    15,
                                    15);
        
        icon;
    });
    
    
    _titleLab =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(44,
                                    20,
                                    200,
                                    16);
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab;
    });
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_icon];
    
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
