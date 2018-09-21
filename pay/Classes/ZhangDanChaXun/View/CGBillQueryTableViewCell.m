//
//  CGBillQueryTableViewCell.m
//  pay
//
//  Created by 胡彦清 on 2018/8/26.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBillQueryTableViewCell.h"

@implementation CGBillQueryTableViewCell
+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGBillQueryTableViewCell";
    CGBillQueryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGBillQueryTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    _headimg =     ({
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(17,
                                    19,
                                    50,
                                    50);
    //圆形图片
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imgView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imgView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imgView.layer.mask = maskLayer;
    
        imgView;
    });
    
    _title =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(87,
                                    20,
                                    280,
                                    16);
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab;
    });
    
    _amount =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(SCREEN_WIDTH - 14 - 160,
                                    20,
                                    160,
                                    15);
        titleLab.font = [UIFont systemFontOfSize:18];
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    _type =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(87,
                                    46,
                                    120,
                                    12);
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.textColor = RGBCOLOR(102, 102  , 102);
//        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    _date =     ({
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.frame = CGRectMake(87,
                                    67,
                                    150,
                                    12);
        titleLab.font = [UIFont systemFontOfSize:12];
//        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab;
    });
    
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_amount];
    [self.contentView addSubview:_type];
    [self.contentView addSubview:_date];
    [self.contentView addSubview:_headimg];
    
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
