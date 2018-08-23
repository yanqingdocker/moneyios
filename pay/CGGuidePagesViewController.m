//
//  CGGuidePagesViewController.m
//  pay
//
//  Created by v2 on 2018/8/16.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGGuidePagesViewController.h"
#import "CGLoginViewController.h"
#define VERSION_INFO_CURRENT @"currentversion"
@interface CGGuidePagesViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation CGGuidePagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)guidePageControllerWithImages:(NSArray *)images
{
    UIScrollView *gui = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gui.delegate = self;
    gui.pagingEnabled = YES;
    // 隐藏滑动条
    gui.showsHorizontalScrollIndicator = NO;
    gui.showsVerticalScrollIndicator = NO;
    // 取消反弹
    gui.bounces = NO;
    for (NSInteger i = 0; i < images.count; i ++) {
        [gui addSubview:({
            self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnEnter.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.btnEnter setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];;
            self.btnEnter;
        })];
        
        [self.btnEnter addSubview:({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setTitle:@"跳过" forState:UIControlStateNormal];
            if (i == images.count - 1) {
                btn.backgroundColor = [UIColor lightGrayColor];
                [btn setTitle:@"点击进入" forState:UIControlStateNormal];
            }
            btn.frame = CGRectMake(SCREEN_WIDTH * i, SCREEN_HEIGHT - 50, 100, 30);
            btn.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 60);
            btn.layer.cornerRadius = 4;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
            btn;
        })];
    }
    gui.contentSize = CGSizeMake(SCREEN_WIDTH * images.count, 0);
    [self.view addSubview:gui];
    
    // pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 30)];
    self.pageControl.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 95);
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = images.count;
}

- (void)clickEnter
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickEnter)]) {
        [self.delegate clickEnter];
    }
    
//    CGLoginViewController *cgLoginViewController = [[CGLoginViewController alloc]init];
//    [ self presentViewController:cgLoginViewController animated: YES completion:nil];

}

+ (BOOL)isShow
{
    // 读取版本信息
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *localVersion = [user objectForKey:VERSION_INFO_CURRENT];
//    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
//        [CGGuidePagesViewController saveCurrentVersion];
        return YES;
//    }else
//    {
//        return NO;
//    }
}
// 保存版本信息
+ (void)saveCurrentVersion
{
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:VERSION_INFO_CURRENT];
    [user synchronize];
}

#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
}


@end
