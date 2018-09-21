//
//  CGAilpayRechargeViewController.m
//  pay
//
//  Created by 胡彦清 on 2018/9/18.
//  Copyright © 2018年 v2. All rights reserved.
//

#import "CGAilpayRechargeViewController.h"
#import <WebKit/WebKit.h>

@interface CGAilpayRechargeViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *wkWebView;
@end

@implementation CGAilpayRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initNav{
    self.navigationItem.title = @"支付宝充值";
    [self setBackButton:YES];
}

- (void)initUI{
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
//    //注册js方法
//    config.userContentController = [[WKUserContentController alloc]init];
//    //webViewAppShare这个需保持跟服务器端的一致，服务器端通过这个name发消息，客户端这边回调接收消息，从而做相关的处理
//    [config.userContentController addScriptMessageHandler:self name:@"cibApp"];
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];//configuration:config
    [_wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    _wkWebView.allowsBackForwardNavigationGestures =YES;
    [_wkWebView setNavigationDelegate:self];
    [_wkWebView setUIDelegate:self];
    [_wkWebView setMultipleTouchEnabled:YES];
    [_wkWebView setAutoresizesSubviews:YES];
    _wkWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
//    self.allowZoom = YES;
//    [_wkWebView.scrollView setZoomScale:0.8 animated:NO];
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.31.12:443/api/orderPay"]]];

    
    
    [self.view addSubview:_wkWebView];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    self.allowZoom = NO;
}
//http://business.goldcoinpay.com/api/createPaymentOrder
@end
