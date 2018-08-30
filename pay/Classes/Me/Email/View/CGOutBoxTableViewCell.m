//
//  CGOutBoxTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGOutBoxTableViewCell.h"

@implementation CGOutBoxTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGOutBoxTableViewCell";
    CGOutBoxTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGOutBoxTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
        titleLab.frame = CGRectMake(7,
                                    20,
                                    200,
                                    17);
        titleLab.textColor = RGBCOLOR(40,134,231);
        titleLab.font = [UIFont systemFontOfSize:18];
        titleLab;
    });
    
    
    _deleteBtn =     ({
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 17 -25, 22, 25, 9);
        [button setTitle:@"删除" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        //        [button addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:RGBCOLOR(218,44,44) forState:UIControlStateNormal];
        button;
    });
    
    _senderLab =     ({
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(7,
                                 50,
                                 200,
                                 14);
        label.textColor = RGBCOLOR(51,51,51);
        label.font = [UIFont systemFontOfSize:14];
        label;
    });
    
    _dateLab =     ({
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(SCREEN_WIDTH - 17 - 120,
                                 52,
                                 120,
                                 8);
        label.textColor = RGBCOLOR(102,102,102);
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentRight;
        label;
    });
    
//    _markBtn =     ({
//        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(SCREEN_WIDTH - 47 -25, 51, 25, 9);
//        [button setTitle:@"标记" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:10];
//        [button setTitleColor:RGBCOLOR(51,51,51) forState:UIControlStateNormal];
//        button;
//    });
//
//    _isreadLab =     ({
//        UILabel * label = [[UILabel alloc]init];
//        label.frame = CGRectMake(SCREEN_WIDTH - 17 -25, 51, 25, 9);
//        label.textColor = RGBCOLOR(102,102,102);
//        label.font = [UIFont systemFontOfSize:10];
//        label;
//    });
    
    
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_dateLab];
    [self.contentView addSubview:_deleteBtn];
    [self.contentView addSubview:_senderLab];
//    [self.contentView addSubview:_markBtn];
//    [self.contentView addSubview:_isreadLab];
    
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
