//
//  AppSingleton.m
//  pay
//
//  Created by v2 on 2018/8/2.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "AppSingleton.h"

@interface AppSingleton (){
    MBProgressHUD *hudView;
    NSInteger hudCount;
    UIImageView *_animView;
    UIView *_animBackView;
    UILabel *_statusLabel;
}

@end

@implementation AppSingleton
//#pragma mark ------------------  单例构造
//static AppSingleton *sharedInstance = nil;
//
//+ (id)sharedInstance
//{
//    @synchronized (self)
//    {
//        if (sharedInstance == nil)
//        {
//            sharedInstance = [[self alloc]init];
//        }
//    }
//    return sharedInstance;
//}
//
//+ (id)allocWithZone:(NSZone *)zone
//{
//    @synchronized(self)
//    {
//        if (sharedInstance == nil)
//        {
//            sharedInstance = [super allocWithZone:zone];
//            return  sharedInstance;
//        }
//    }
//    return nil;
//}
//
//#pragma mark ------------------------ 单例方法
///**
// *  显示动画HUD
// */
////- (void)showAnimationView
////{
////
////    if (!_animBackView) {
////
////        _animBackView = [PublicMethod createUIView:getAppWindow().bounds backgroundColor:sysClearColor()];
////        [getAppWindow() addSubview:_animBackView];
////        if (IOS7_OR_EARLY&&iPad) {
////            _animBackView.transform=CGAffineTransformMakeRotation(-M_PI/2);
////        }
////    }
////
////    float height=((float)(312.0/343.0))*120;
////    if (!_animView) {
////
////        _animView = [PublicMethod createImageView:CGRECT(([ConfigurationInfo sharedConfigurationInfo].screenwidth_pad-343/4)/2, ([ConfigurationInfo sharedConfigurationInfo].screenheight_pad-312/4)/2, 343/4, 312/4) image:nil];
////        _animView.frame=CGRECT(0,0, 120, height);
////
////
////        NSString * str = nil;
////        NSMutableArray * ary = [NSMutableArray array];
////        for (int index = 0; index < 22; index++) {
////            str = [NSString stringWithFormat:@"loading%d",index];
////            [ary addObject:[UIImage imageNamed:str]];
////        }
////
////        _animView.animationImages = [NSArray arrayWithArray:ary];
////
////        _animView.animationDuration = 2.0;
////        _animView.animationRepeatCount = 0;
////        [_animView startAnimating];
////        [_animBackView addSubview:_animView];
////        _animView.center=_animBackView.center;
////    }
////
////}
//
///**
// *  显示动画+文字HUD
// */
////- (void)showAnimationTitleView:(NSString *)title
////{
////
////    if (!_animBackView) {
////
////        _animBackView = [PublicMethod createUIView:getAppWindow().bounds backgroundColor:sysClearColor()];
////        [getAppWindow() addSubview:_animBackView];
////        if (IOS7_OR_EARLY&&iPad) {
////            _animBackView.transform=CGAffineTransformMakeRotation(-M_PI/2);
////        }
////    }
////
////    float height=((float)(312.0/343.0))*120;
////    if (!_animView) {
////
////        _animView = [PublicMethod createImageView:CGRECT(([ConfigurationInfo sharedConfigurationInfo].screenwidth_pad-343/4)/2, ([ConfigurationInfo sharedConfigurationInfo].screenheight_pad-312/4)/2, 343/4, 312/4) image:nil];
////        _animView.frame=CGRECT(0,0, 120, height);
////
////
////        NSString * str = nil;
////        NSMutableArray * ary = [NSMutableArray array];
////        for (int index = 0; index < 22; index++) {
////            str = [NSString stringWithFormat:@"loading%d",index];
////            [ary addObject:[UIImage imageNamed:str]];
////        }
////
////        _animView.animationImages = [NSArray arrayWithArray:ary];
////
////        _animView.animationDuration = 2.0;
////        _animView.animationRepeatCount = 0;
////        [_animView startAnimating];
////        [_animBackView addSubview:_animView];
////        _animView.center=_animBackView.center;
////    }
////
////    UIView *view = nil;
////
////    if (iPad) {
////        view = [PublicMethod createUIView:getAppWindow().bounds
////                          backgroundColor:sysClearColor()];
////        view.tag = WINDOW_HUD_VIEW_TAG;
////        [getAppWindow() addSubview:view];
////    }
////
////    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(iPad)?view:getAppWindow() animated:YES];
////
////    if (IOS7_OR_EARLY&&iPad) {
////        hud.transform=CGAffineTransformMakeRotation(-M_PI/2);
////    }
////    hud.userInteractionEnabled=NO;
////    hud.mode = MBProgressHUDModeText;
////    if (title.length > 0) {
////        hud.detailsLabelText = title;
////        hud.detailsLabelFont = [UIFont systemFontOfSize:15];
////    }
////    hud.yOffset = 100;
////    hud.delegate = self;
////    [hud show:YES];
////    [hud hide:YES afterDelay:2.5];
////}
//
///**
// *  移除动画显示
// */
//- (void)stopAnimationView
//{
//    if (_animView) {
//        [_animView stopAnimating];
//        [_animView removeFromSuperview];
//        _animView = nil;
//    }
//    if (_animBackView) {
//        [_animBackView removeFromSuperview];
//        _animBackView = nil;
//    }
//}
//
//- (void)showLoadingHUD
//{
//    //    UIView *view = [PublicMethod createUIView:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-0)
//    //                              backgroundColor:sysClearColor()];
//    //    view.backgroundColor = sysRedColor();
//    //    [getAppWindow() addSubview:view];
//    
//    if (hudView == nil) {
//        hudCount = 0;
//        hudView = [MBProgressHUD showHUDAddedTo:getAppWindow() animated:YES];
//    }
//    hudCount += 1;
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//}

//- (void)showHUDWithTitle:(NSString *)title
//{
//    UIView *view = nil;
//
//    if (iPad) {
//        view = [PublicMethod createUIView:getAppWindow().bounds
//                          backgroundColor:sysClearColor()];
//        view.tag = WINDOW_HUD_VIEW_TAG;
//        [getAppWindow() addSubview:view];
//    }
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(iPad)?view:getAppWindow() animated:YES];
//
//    if (IOS7_OR_EARLY&&iPad) {
//        hud.transform=CGAffineTransformMakeRotation(-M_PI/2);
//    }
//    hud.userInteractionEnabled=NO;
//    hud.mode = MBProgressHUDModeText;
//    if (title.length > 0) {
//        hud.detailsLabelText = title;
//        hud.detailsLabelFont = [UIFont systemFontOfSize:15];
//    }
//    hud.delegate = self;
//    [hud show:YES];
//    [hud hide:YES afterDelay:2.5];
//}

//- (void)hideHUD
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    hudCount -= 1;
//    if (hudCount<0)
//    {
//        hudCount = 0;
//    }
//    if (hudView && hudCount == 0) {
//        [hudView hide:YES];
//        [self removeFromHUDSuperview];
//    }
//}

@end
