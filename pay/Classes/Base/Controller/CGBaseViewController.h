//
//  CGBaseViewController.h
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGBaseViewController;

@protocol CGBaseViewControllerDelegate <NSObject>

@required

- (void)initNav;

- (void)initUI;

@optional
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)pushViewControllerHiddenTabBar:(CGBaseViewController *)viewController animated:(BOOL)animated;
@end

@interface CGBaseViewController : UIViewController <CGBaseViewControllerDelegate>
//@property (nonatomic, assign) id <CGBaseViewControllerDelegate>delegate;
@property (nonatomic, strong, readonly) UIView *topBar;

@property (nonatomic, assign) BOOL  isHiddenTabBar;
@property (nonatomic, copy) NSString *navigationTitle;
- (void)setBackButton:(BOOL)isShown;
- (void)goBack;

- (void)startTimer:(UIButton *)btn;

-(NSString *)convertToJsonData:(NSDictionary *)dict;//NSDictionary 转 NSString
-(NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum;
#pragma mark - 界面居中布局
- (void)viewToCenterXWithView:(UIView *)view ;
#pragma mark - 图片质量及尺寸压缩
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength image:(UIImage *)image;
@end
