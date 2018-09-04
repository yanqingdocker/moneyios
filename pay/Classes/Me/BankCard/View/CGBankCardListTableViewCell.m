//
//  CGBankCardListTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/8/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBankCardListTableViewCell.h"

@implementation CGBankCardListTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGBankCardListTableViewCell";
    CGBankCardListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGBankCardListTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    _bgimgView =     ({
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(15,
                                     15,
                                     SCREEN_WIDTH - 15*2,
                                     140);
        imageView;
    });
    
    _logoimgView =     ({
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(35,
                                     35,
                                     45,
                                     45);
        imageView;
    });
    
    _bankType =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(90,
                                    40,
                                    200,
                                    17);
        titleLab.textColor = RGBCOLOR(255,255,255);
        titleLab.font = [UIFont systemFontOfSize:18];
        titleLab;
    });
    
    
    _bankCard =     ({
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(35,
                                 130,
                                 200,
                                 11);
        label.textColor = RGBCOLOR(255,255,255);
        label.font = [UIFont systemFontOfSize:14];
        label;
    });
    
    _untying =     ({
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 50 -60, 130, 60, 12);
        [button setTitle:@"解绑" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:RGBCOLOR(242,242,245) forState:UIControlStateNormal];
        button;
    });
    
    [self.contentView addSubview:_bgimgView];
    [self.contentView addSubview:_logoimgView];
    [self.contentView addSubview:_bankType];
    [self.contentView addSubview:_bankCard];
    [self.contentView addSubview:_untying];
    
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
