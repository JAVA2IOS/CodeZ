//
//  WebOCViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 17/4/10.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "WebOCViewController.h"
#import <WebKit/WebKit.h>

@interface WebOCViewController () <WKUIDelegate, WKNavigationDelegate>

@end

@implementation WebOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backToViewController];
    self.title = @"Web内显示h5";
    [self wo_getWebJs];
}

- (void)wo_getWebJs {
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [web loadRequest:urlRequest];
    [self.view addSubview:web];
    web.UIDelegate = self;
    web.navigationDelegate = self;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 页面开始加载时调用
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    // 当内容开始返回时调用
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 页面加载完成之后调用
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    // 接收到服务器跳转请求之后调用
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 接收到响应，决定是否跳转
    NSLog(@"链接地址:%@",navigationAction.request.URL.absoluteString);
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    // 不予许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    /*
     webview开始加载时可以在此实现数据传递
     */
    NSLog(@"--------------开始加载------------");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /*
     */
    NSLog(@"--------------完成加载------------");
    NSLog(@"链接地址:%@",webView.request.URL.absoluteString);
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"网页标题:%@",title);
}

// 回调方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"-----------开始加载之前------------");
    
    return YES;
}

@end
