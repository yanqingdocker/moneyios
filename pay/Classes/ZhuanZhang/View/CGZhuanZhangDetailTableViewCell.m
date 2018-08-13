//
//  CGZhuanZhangDetailTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhuanZhangDetailTableViewCell.h"
#define leftSpace 10
#define topSpace 0
@implementation CGZhuanZhangDetailTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CGZhuanZhangDetailTableViewCell";
    CGZhuanZhangDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGZhuanZhangDetailTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor  whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _typeLab =     ({
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(20,
                                    15,
                                    100 ,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:15];
        
        titleLab;
    });
    [self.contentView addSubview:_typeLab];
    
    _moneyLab =     ({
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(120,
                                    15,
                                    SCREEN_WIDTH- 15*2 -100 ,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:15];
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    [self.contentView addSubview:_moneyLab];
    
    _dateLab =     ({
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(20,
                                    40,
                                    SCREEN_WIDTH ,
                                    12);
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.textColor = RGBCOLOR(153,153,153);
        titleLab;
    });
    [self.contentView addSubview:_dateLab];
    
    _stateLab =     ({
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(120,
                                    40,
                                    SCREEN_WIDTH- 15*2 -100  ,
                                    12);
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.textColor = RGBCOLOR(153,153,153);
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    [self.contentView addSubview:_stateLab];
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
