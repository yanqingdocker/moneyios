//
//  CGBaseViewController.m
//  pay
//
//  Created by v2 on 2018/7/31.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGBaseViewController.h"
#import "MBProgressHUD+Extension.h"

@interface CGBaseViewController ()<UIGestureRecognizerDelegate>
{
    
}
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIGestureRecognizer *interactivePopGestureRecognizer;
@end

@implementation CGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initUI];
    
    
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
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
    
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
//
//
//    [self.view addGestureRecognizer:singleTap];
}

// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}

//-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
//{
//    
//    [self.view endEditing:YES];
//    
//}
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
//        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"0d0d0d"];
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        self.navigationController.navigationBar.translucent = NO;

//        _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//        _topBar.backgroundColor = [UIColor colorWithHexString:@"0d0d0d"];
//        _topBar.backgroundColor = [UIColor blackColor];
        
        UIView *gbview = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
//        gbview.backgroundColor = RGBCOLOR(44, 55, 66);
//        gbview.backgroundColor = RGBCOLOR(38, 38, 38);
        gbview.backgroundColor = [UIColor blackColor];
        [self.navigationController.navigationBar addSubview:gbview];

        [self.view addSubview:_topBar];
    }
    return _topBar;
}

//- (void)showSuccess:(NSString *)text {
//    //TODO
//    if (text)[self.view makeToast:text duration:2.0 position:CSToastPositionCenter];
//}


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

- (void)startTimer:(UIButton *)btn {
    btn.enabled = NO;
    __block NSInteger timeOut = 60; /// 重新获取验证码时长
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (timeOut > 0) {
            /// 开始计时
            dispatch_async(dispatch_get_main_queue(), ^{
                /// 设置倒计时样式
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [btn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)timeOut] forState:UIControlStateNormal];
                [UIView commitAnimations];
            });
            timeOut --;
        } else {
            /// 销毁计时器
            [self cancelTimer];
            dispatch_async(dispatch_get_main_queue(), ^{
                btn.enabled = YES;
            });
            
        }
    });
    dispatch_source_set_cancel_handler(self.timer, ^{
        /// 设置重新获取样式
        dispatch_async(dispatch_get_main_queue(), ^{
            /// 设置倒计时样式
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        });
    });
    dispatch_resume(self.timer);
}

- (void)cancelTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}

//银行卡中间隐藏,四位一空格
-(NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum
{
    NSMutableString *mutableStr;
    if (bankNum.length) {
        mutableStr = [NSMutableString stringWithString:bankNum];
        for (int i = 0 ; i < mutableStr.length; i ++) {
            if (i>3&&i<mutableStr.length - 4) {
                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        NSString *text = mutableStr;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        return newString;
    }
    return bankNum;
    
}

#pragma mark - 界面居中布局
- (void)viewToCenterXWithView:(UIView *)view {
    CGPoint point = view.center;
    point.x = CGRectGetWidth(self.view.bounds)*.5f;
    view.center = point;
}

#pragma mark - 图片质量及尺寸压缩
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength image:(UIImage *)image{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

@end
