//
//  CGTopUpDetailTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//
#define leftSpace 15
#define topSpace 15

#import "CGTopUpDetailTableViewCell.h"

@implementation CGTopUpDetailTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGTopUpDetailTableViewCell";
    CGTopUpDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGTopUpDetailTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
        titleLab.frame = CGRectMake(leftSpace,
                                    topSpace,
                                    120,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab;
    });
    
    _dateLab =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(SCREEN_WIDTH - 70 - 15,
                                    19,
                                    70,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:11];
        titleLab.textColor = RGBCOLOR(153, 153, 153);
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    UILabel * yueLab = [[UILabel alloc]init];
    yueLab.frame = CGRectMake(leftSpace,
                                34,
                                40,
                                12);
    yueLab.font = [UIFont systemFontOfSize:12];
    yueLab.text = @"余额:";
    
    _balanceLab =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(leftSpace + 45,
                                    34,
                                    120,
                                    12);
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab;
    });
    
    _changeLab =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(SCREEN_WIDTH - 120 - 15,
                                    35,
                                    120,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:yueLab];
    [self.contentView addSubview:_dateLab];
    [self.contentView addSubview:_balanceLab];
    [self.contentView addSubview:_changeLab];
    
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
