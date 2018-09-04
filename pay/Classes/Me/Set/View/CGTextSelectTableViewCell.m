//
//  CGTextSelectTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/9/4.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTextSelectTableViewCell.h"

@implementation CGTextSelectTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGTextSelectTableViewCell";
    CGTextSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGTextSelectTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    
    
    _selectImg =     ({
        UIImageView * img = [[UIImageView alloc]init];
        img.frame = CGRectMake(SCREEN_WIDTH - 15 -22 ,
                                    11,
                                    22,
                                    22);
        img;
    });
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_selectImg];
    
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
