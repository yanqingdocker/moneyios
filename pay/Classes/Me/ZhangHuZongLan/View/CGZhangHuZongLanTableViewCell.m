//
//  CGZhangHuZongLanTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGZhangHuZongLanTableViewCell.h"

@implementation CGZhangHuZongLanTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGZhangHuZongLanTableViewCell";
    CGZhangHuZongLanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGZhangHuZongLanTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
        imageView.frame = CGRectMake(20,
                                    0,
                                    SCREEN_WIDTH - 20*2,
                                    157);
        imageView;
    });
    
    _countType =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(41,
                                    24,
                                    150,
                                    12);
        titleLab.textColor = RGBCOLOR(255,255,255);
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab;
    });
    
    _eyeBtn =     ({
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 59 -21, 24, 21, 9);
//        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button;
    });
    
    _blance =     ({
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(41,
                                 43,
                                 230,
                                 16);
        label.textColor = RGBCOLOR(255,255,255);
        label.font = [UIFont systemFontOfSize:20];
        label;
    });
    
    
//    _deleteBtn =     ({
//        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(SCREEN_WIDTH - 17 -25, 22, 25, 9);
//        [button setTitle:@"删除" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:10];
//        //        [button addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
//        [button setTitleColor:RGBCOLOR(218,44,44) forState:UIControlStateNormal];
//        button;
//    });
//    
    _cardId =     ({
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(39,
                                 126,
                                 200,
                                 10);
        label.textColor = RGBCOLOR(255,255,255);
        label.font = [UIFont systemFontOfSize:12];
        label;
    });

    _closeAccount =     ({
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 59 -60, 125, 60, 12);
        [button setTitle:@"注销账户" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:RGBCOLOR(242,242,245) forState:UIControlStateNormal];
        button;
    });
    
    
    _inAccount =     ({
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(22, 167, 144, 36);
        [button setTitle:@"转入" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.backgroundColor = RGBCOLOR(218,221,232);
        button.layer.cornerRadius = 18;
        [button setTitleColor:RGBCOLOR(51,51,51) forState:UIControlStateNormal];
        button;
    });
    
    _outAccount =     ({
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 22 - 144, 167, 144, 36);
        [button setTitle:@"转出" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.backgroundColor = RGBCOLOR(242,106,106);
        button.layer.cornerRadius = 18;
        [button setTitleColor:RGBCOLOR(255,255,255) forState:UIControlStateNormal];
        button;
    });
//    _isreadLab =     ({
//        UILabel * label = [[UILabel alloc]init];
//        label.frame = CGRectMake(SCREEN_WIDTH - 17 -25, 51, 25, 9);
//        label.textColor = RGBCOLOR(102,102,102);
//        label.font = [UIFont systemFontOfSize:10];
//        label;
//    });
//    
//    
//    
    [self.contentView addSubview:_bgimgView];
    [self.contentView addSubview:_countType];
    [self.contentView addSubview:_eyeBtn];
    [self.contentView addSubview:_blance];
    [self.contentView addSubview:_cardId];
    [self.contentView addSubview:_closeAccount];
    [self.contentView addSubview:_inAccount];
    [self.contentView addSubview:_outAccount];
    
}


//-(void)deleteClick{
//    _deleteBlock(self);
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
