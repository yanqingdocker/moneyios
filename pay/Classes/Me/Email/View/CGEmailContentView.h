//
//  CGEmailContentView.h
//  pay
//
//  Created by 胡彦清 on 2018/8/30.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGEmailContentView : UIViewController
@property (nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)NSString *content;
- (void)showInView:(UIView *)view;

@end
