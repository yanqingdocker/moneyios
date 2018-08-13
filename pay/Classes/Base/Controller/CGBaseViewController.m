//
//  CGBaseViewController.m
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBaseViewController.h"

@interface CGBaseViewController ()
{
    
}
@property (nonatomic, strong) UIView *topBar;

@end

@implementation CGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initUI];
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    //导航栏
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"0d0d0d"]];
    
    //状态栏背景颜色
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = RGBCOLOR(44, 55, 66);
//    }
//
//    UINavigationBar * bar = self.navigationController.navigationBar;
//    bar.barTintColor = [UIColor colorWithHexString:@"0d0d0d"];
 
    //导航栏字体大小+颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //背景色
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
}

#pragma mark - UI
- (void)initNav {

}

- (void)initUI {
    
}

-(void)setIsHiddenTabBar:(BOOL)isHiddenTabBar
{
    _isHiddenTabBar = isHiddenTabBar;
    self.hidesBottomBarWhenPushed = isHiddenTabBar;
}

#pragma mark - setter
//- (void)setNavigationTitle:(NSString *)navigationTitle {
//    if ([navigationTitle isKindOfClass:[NSString class]] && navigationTitle.length) {
//        _navigationTitle = navigationTitle;
//        self.titleLable.text = navigationTitle;
//        self.titleLable.numberOfLines = 0;
//    }
//}
- (void)setBackButton:(BOOL)isShown
{
    if (isShown)
    {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 15, 15);
//        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
//        UIImage *img = [UIImage imageNamed:@"cancel-left"];
//        [img drawInRect:CGRectMake(0, 0, 15, 15)];
//        [backBtn setBackgroundColor: [UIColor redColor]];
        [backBtn setImage:[UIImage imageNamed:@"cancel-left"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        [backBtn.widthAnchor constraintEqualToConstant:20].active = YES;
        [backBtn.heightAnchor constraintEqualToConstant:20].active = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    } else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - getter
- (UIView *)topBar {
    if (!_topBar) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"0d0d0d"];
        
//        [self.navigationController.navigationBar setBackgroundImage:[UIColor createImageWithColor:[UIColor colorWithHexString:@"0d0d0d"]] forBarMetrics:UIBarMetricsDefault];

        _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _topBar.backgroundColor = [UIColor colorWithHexString:@"0d0d0d"];
        
        UIView *gbview = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
        gbview.backgroundColor = RGBCOLOR(44, 55, 66);
        [self.navigationController.navigationBar addSubview:gbview];

        [self.view addSubview:_topBar];
    }
    return _topBar;
}




//- (void)setUpLeftNavigationItemWithAction:(SEL)action
//{
//    //返回按钮
//    EwUIButton *backBtn = [[EwUIButton alloc] initWithFrame:CGRectMake(0, (STATUSBAR_HEIGHT+CGRectGetHeight(self.topBar.frame)-44)/2, 60, 44)];
//    [backBtn setImage:[UIImage imageNamed:@"backImage.png"] forState:UIControlStateNormal];
//    //[backBtn setImage:[UIImage imageNamed:@"back_pic.png"] forState:UIControlStateSelected];
//    [backBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [self.topBar addSubview:backBtn];
//
//}
- (void)popToRootViewControllerAnimated:(BOOL)animated {
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)pushViewControllerHiddenTabBar:(CGBaseViewController *)viewController animated:(BOOL)animated {
    viewController.isHiddenTabBar = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

@end
