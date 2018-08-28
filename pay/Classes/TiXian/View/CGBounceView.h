//
//  CGBounceView.h
//  pay
//
//  Created by v2 on 2018/8/3.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGBounceView : UIViewController
@property(nonatomic,strong)void(^selectbankcardblock)(NSString *);
@property (nonatomic,strong)NSArray *tuanModel;
@property (nonatomic,strong)NSString *BVtitle;
- (void)showInView:(UIView *)view;
@end
