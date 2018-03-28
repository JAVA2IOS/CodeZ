//
//  CZDetailViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/13.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CZDetailViewController.h"
#import "HQNavigationBar.h"
#import "HQNavTwoBarItem.h"
#import "CZGestureRecognizerManager.h"

@interface CZDetailViewController() <HQNavigationBarDelegate, UIWebViewDelegate>
@end

@implementation CZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backToViewController];
    self.title = @"详细视图";
    self.view.backgroundColor = UIColorFromRGB(0xfafafa);
    
    NSMutableArray *bundleDatas = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i ++) {
        CodeZBundleData *bundle = [[CodeZBundleData alloc] init];
        bundle.displayText = @"中";
        bundle.bundleData = nil;
        
        [bundleDatas addObject:bundle];
    }
    HQNavigationBar *horizontalBar = [[HQNavigationBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    horizontalBar.itemDatas = bundleDatas;
    horizontalBar.startIndex = 0;
    [horizontalBar configureBarItem:^HQNavigationBarItem *(id obj, CGRect frame) {
        HQNavTwoBarItem *barItem = [[HQNavTwoBarItem alloc] initWithFrame:frame];
        barItem.backgroundColor = [UIColor redColor];
        return barItem;
    }];
    horizontalBar.delegate = self;
    [self.view addSubview:horizontalBar];
    
}


#pragma mark - actions


#pragma mark - HQNavigationBarDelegate method
- (void)HQNavigationBart:(HQNavigationBarItem *)barItem Data:(id)obj index:(NSInteger)idx selected:(BOOL)selected {
    NSLog(@"%@",obj);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
