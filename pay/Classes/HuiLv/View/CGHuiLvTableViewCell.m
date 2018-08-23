//
//  CGHuiLvTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//
#define leftSpace 15
#define topSpace 15

#import "CGHuiLvTableViewCell.h"

@implementation CGHuiLvTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGHuiLvTableViewCell";
    CGHuiLvTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGHuiLvTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    _currency =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(leftSpace,
                                    topSpace,
                                    120,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:11];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab;
    });
    
    _buyPic =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(0,
                                    topSpace,
                                    SCREEN_WIDTH,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:11];
//        titleLab.textColor = RGBCOLOR(153, 153, 153);
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab;
    });
    
    _sellPic =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(SCREEN_WIDTH - leftSpace - 120,
                                    topSpace,
                                    120,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:11];
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    
    
    [self.contentView addSubview:_currency];
    [self.contentView addSubview:_buyPic];
    [self.contentView addSubview:_sellPic];
    
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
