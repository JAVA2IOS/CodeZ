//
//  WebOCViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 17/4/10.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "WebOCViewController.h"

@interface WebOCViewController () <UIWebViewDelegate>

@end

@implementation WebOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backToViewController];
    self.title = @"Web内显示h5";
    [self wo_getWebJs];
}

- (void)wo_getWebJs {
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [web loadRequest:urlRequest];
    [self.view addSubview:web];
    web.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
