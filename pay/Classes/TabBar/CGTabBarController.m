//
//  CGTabBarController.m
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGTabBarController.h"
#import "CGHomeViewController.h"
#import "CGMeRootViewController.h"
#import "CGBaseViewController.h"

#import "CGLoginViewController.h"

@interface CGTabBarController ()<UITabBarControllerDelegate>
{
    NSInteger   currentTabIndex;
}

@property (nonatomic, strong) UIView *tabbarBackgroundView;

@end

@implementation CGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTabbar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if(_url !=nil) {
        //change to forward view
//        CGHomeViewController *choice = [[CGHomeViewController alloc] init];
//        choice.chioceType = ContactChoiceTypeFile;
//        choice.isMultiSelect = YES;
//        choice.filePath = _url;
        //        [self presentViewController:choice animated:YES completion:NULL];
//        [self.selectedViewController pushViewController:choice animated:YES];
//    }
    
}

#pragma mark - add tabbar
- (void)addTabbar {
    
    //移出tabbar投影
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];

    NSArray *tabBarTitle = @[@"首页", @"我的"];
//    self.viewControllers = @[[[self class] baseNavigationController:@"CGLoginViewController"],
    self.viewControllers = @[[[self class] baseNavigationController:@"CGHomeViewController"],
//                             [[self class] baseNavigationControllerWithoutTabar:@"XMCloudChatListViewController"],
//                             [[self class] baseNavigationControllerWithoutTabar:@"XMAddressBookRootController"],
//                             [[self class] baseNavigationControllerWithoutTabar:@"XMSocialHomePageViewController"],
                             [[self class] baseNavigationController:@"CGMeRootViewController"]];



    //自定义tabbar
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT);
    UIView *tabbarBackgroundView = [[UIView alloc] initWithFrame:frame];
//    tabbarBackgroundView.backgroundColor = [UIColor colorWithHexString:@"0d0d0d"];
    tabbarBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:tabbarBackgroundView];
    self.tabbarBackgroundView = tabbarBackgroundView;

    NSArray *icons = @[@"首页未选中",
                       @"我的未选中"];

    NSArray *iconSelecteds = @[@"首页选中",
                               @"我的选中"];

    CGFloat width = CGRectGetWidth(self.view.frame);

    CGFloat preButtonWidth = width / 2.0f;
    CGFloat preButtonHeight = 44;
    CGFloat preButtonY = 5;

    UIButton *button;
    for (int i = 0; i < [icons count]; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [button setTitle:[tabBarTitle objectAtIndex:i] forState:UIControlStateNormal];
//        [button setTitle:[tabBarTitle objectAtIndex:i] forState:UIControlStateSelected];
//        [button setTitleColor:RGBCOLOR(117, 117, 117) forState:UIControlStateNormal];
//        [button setTitleColor:RGBCOLOR(6, 45, 134) forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:iconSelecteds[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonSelectedIndex:) forControlEvents:UIControlEventTouchUpInside];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.adjustsImageWhenHighlighted = NO;
        if (i == 0) {
            button.selected = YES;
        }

        button.frame = CGRectMake(preButtonWidth * i, preButtonY, preButtonWidth, preButtonHeight);
        button.tag = i;
        [tabbarBackgroundView addSubview:button];
    }
}

#pragma mark -
+ (UIViewController *)baseNavigationController:(NSString *)ViewControllerName {
    
    Class class = NSClassFromString(ViewControllerName);
    
    UIViewController *viewController = [[class alloc] init];
    
    UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:viewController];
//    na.navigationBar.barTintColor = RGB(3, 44, 134, 1);
    return na;
}
//+ (UIViewController *)baseNavigationControllerWithoutTabar:(NSString *)ViewControllerName {
//
//    Class class = NSClassFromString(ViewControllerName);
//
//    UIViewController *viewController = [[class alloc] init];
//
//    XYNavigationController *na = [[XYNavigationController alloc] initWithRootViewController:viewController];
//
//
//    return na;
//}

#pragma mark - tabbar action
- (void)buttonSelectedIndex:(UIButton *)sender {
    
    
    
    if (sender.tag == currentTabIndex) {
        UIViewController *viewController = self.selectedViewController;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)viewController;
            UIViewController *visibleViewController = nav.visibleViewController;
            if ([visibleViewController isKindOfClass:[CGBaseViewController class]]) {
                [(CGBaseViewController *)visibleViewController popToRootViewControllerAnimated:YES];
            } else {
                [nav popToRootViewControllerAnimated:YES];
            }
            
        }
        return;
    }
    
    [self setSelectedIndex:sender.tag];
    for (UIButton *button in [_tabbarBackgroundView subviews]) {
        button.selected = NO;
        if (button.tag == sender.tag) {
            button.selected = YES;
        }
    }
    
    currentTabIndex = sender.tag;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    //    if(viewController.tabBarItem.tag == 3 /*|| viewController.tabBarItem.tag == 2*/)
    //    {
    //        [self.view makeToast:@"功能在开发中，敬请期待～" duration:1.0 position:CSToastPositionCenter];
    //        return NO;
    //
    //    }
    //    else
    //    {
    return YES;
    //    }
    
}

@end
