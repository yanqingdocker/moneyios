//
//  CGBankCardTopupTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/9/8.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBankCardTopupTableViewCell.h"

@implementation CGBankCardTopupTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGBankCardTopupTableViewCell";
    CGBankCardTopupTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGBankCardTopupTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    _moneyTypeIcon =     ({
        UIImageView * img = [[UIImageView alloc]init];
        img.frame = CGRectMake(14,
                                    10,
                                    40 ,
                                    40);
        img;
    });
    
    _moneyTypeLab =     ({
        UILabel * contentText = [[UILabel  alloc] init];
        contentText.frame = CGRectMake(64,
                                       25 ,
                                       200,
                                       17);
        
        contentText.font = [UIFont systemFontOfSize:18];
        
        contentText;
    });
    
    _selectImg =     ({
        UIImageView * img = [[UIImageView alloc]init];
        img.frame = CGRectMake(SCREEN_WIDTH - 15 -22 ,
                               22,
                               22,
                               22);
        img;
    });
    
    
    [self.contentView addSubview:_moneyTypeIcon];
    [self.contentView addSubview:_moneyTypeLab];
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
