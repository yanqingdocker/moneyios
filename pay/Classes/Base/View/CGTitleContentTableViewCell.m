//
//  CGTitleContentTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTitleContentTableViewCell.h"

@implementation CGTitleContentTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGTitleContentTableViewCell";
    CGTitleContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGTitleContentTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
                                    15,
                                    70,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab;
    });
    
    
    _content =     ({
        UITextField * contentText = [[UITextField alloc]init];
        contentText.frame = CGRectMake(90,
                                14,
                                SCREEN_WIDTH - 90 -17,
                                16);
        
        contentText.font = [UIFont systemFontOfSize:16];
        contentText;
    });
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_content];
    
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
