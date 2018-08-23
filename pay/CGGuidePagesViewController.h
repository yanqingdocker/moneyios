//
//  CGGuidePagesViewController.h
//  pay
//
//  Created by v2 on 2018/8/16.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol selectDelegate <NSObject>

- (void)clickEnter;

@end
@interface CGGuidePagesViewController : UIViewController
@property (nonatomic, strong) UIButton *btnEnter;
// 初始化引导页
- (void)guidePageControllerWithImages:(NSArray *)images;
+ (BOOL)isShow;
@property (nonatomic, assign) id<selectDelegate> delegate;
@end
