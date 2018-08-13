//
//  CGTiXianResultsAlertView.h
//  pay
//
//  Created by v2 on 2018/8/6.
//  Copyright © 2018年 v2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OnCancleButtonClick)();
typedef void (^OnSureButtonClick)();

@interface CGTiXianResultsAlertView : UIView

@property (nonatomic, copy) OnCancleButtonClick cancleBlock;
@property (nonatomic, copy) OnSureButtonClick sureBlock;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title alertMessage:(NSString *)msg confrimBolck:(void (^)())confrimBlock cancelBlock:(void (^)())cancelBlock;
//弹出
-(void)show;

//隐藏
-(void)hide;

@end
