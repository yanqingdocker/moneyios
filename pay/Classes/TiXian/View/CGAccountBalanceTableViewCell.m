//
//  CGAccountBalanceTableViewCell.m
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//
#define leftSpace 13
#define topSpace 5

#import "CGAccountBalanceTableViewCell.h"

@implementation CGAccountBalanceTableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString * ID = @"CGAccountBalanceTableViewCell";
    CGAccountBalanceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CGAccountBalanceTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
        titleLab.frame = CGRectMake(leftSpace, topSpace, SCREEN_WIDTH - 2* leftSpace, 13);
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:13];
        titleLab.textColor = RGBCOLOR(179,179,179);
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab;
    });

    _img =     ({
    UIImageView * img = [[UIImageView alloc] init];
    img.frame = CGRectMake(leftSpace, 85, 25, 25);
//    if([_countType isEqualToString:@"CNY"]){
////        [img setImage:[UIImage imageNamed:@"CNYIcon"]];
//    }
//    if([_countType isEqualToString:@"USD"]){
//        [img setImage:[UIImage imageNamed:_countType]];
//    }
        img;
    });
        
    _contentText =     ({
        UITextField * contentText = [[UITextField  alloc] init];
        contentText.frame = CGRectMake(_img.frame.origin.x + _img.frame.size.width+5,
                                       70,
                                       SCREEN_WIDTH - _img.frame.origin.x + _img.frame.size.width - leftSpace - 75 ,
                                       50);
        //        contentText.textAlignment = NSTextAlignmentLeft;
//        contentText.backgroundColor = [UIColor redColor];
        contentText.font = [UIFont systemFontOfSize:40];
        
        contentText;
    });
    
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_img];
    [self.contentView addSubview:_contentText];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _titleLab.frame = CGRectMake(leftSpace, topSpace, SCREEN_WIDTH - 2* leftSpace, [CGAccountBalanceTableViewCell calculateLabelHeight:_titleLab.text]);



}
+ (CGFloat)calculateLabelHeight:(NSString *)text{
    
    //    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //    CGFloat conmentX = screenW / 320 * 10;
    
    CGFloat conmentW = SCREEN_WIDTH - 2* leftSpace;
    
    
    CGSize contentSize = CGSizeMake(conmentW, CGFLOAT_MAX);
    
    CGFloat labelHeight = [text boundingRectWithSize:contentSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName] context:nil].size.height;
    
    if (labelHeight < 34) {//少于一行
        labelHeight = 34;
    }
    
    return labelHeight;
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
