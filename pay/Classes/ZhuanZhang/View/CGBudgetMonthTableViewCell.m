//
//  CGBudgetMonthTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBudgetMonthTableViewCell.h"
#define leftSpace 10
#define topSpace 0

@implementation CGBudgetMonthTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CGBudgetMonthTableViewCell";
    CGBudgetMonthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGBudgetMonthTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = RGB(240,239,245, 1);
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _titleLab =     ({
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.frame = CGRectMake(0,
                                    8,
                                    SCREEN_WIDTH ,
                                    10);
        titleLab.font = [UIFont systemFontOfSize:10];
        
        
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = RGBCOLOR(153,153,153);
        titleLab;
    });
    [self.contentView addSubview:_titleLab];
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
