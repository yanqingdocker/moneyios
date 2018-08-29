//
//  CGTitleAndTextTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/20.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTitleAndTextTableViewCell.h"

@implementation CGTitleAndTextTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGTitleAndTextTableViewCell";
    CGTitleAndTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGTitleAndTextTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
                                    12,
                                    120,
                                    14);
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab;
    });
    
    _contentText =     ({
        UITextField * contentText = [[UITextField  alloc] init];
        contentText.frame = CGRectMake(17,
                                       40 ,
                                       300,
                                       11);
        
        contentText.font = [UIFont systemFontOfSize:10];
        
        contentText;
    });
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_contentText];
    
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
