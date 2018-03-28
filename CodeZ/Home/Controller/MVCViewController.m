//
//  MVCViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/3/28.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVCViewController.h"
#import "MVCModel.h"
#import "MVCView.h"

@interface MVCViewController () {
    MVCModel *model;
    MVCView *view;
}

@end

@implementation MVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [[MVCModel alloc] init];
    model.title = @"现在";
    view = [[MVCView alloc] initWithFrame:CGRectMake(0, 40, 500, 500)];
    [self.view addSubview:view];
    [model addObserver:self
            forKeyPath:@"title"
               options:NSKeyValueObservingOptionNew
               context:nil];
    model.title = @"hello";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        NSLog(@"%@", change[NSKeyValueChangeNewKey]);
        [view updateText:change[NSKeyValueChangeNewKey]];
    }
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
