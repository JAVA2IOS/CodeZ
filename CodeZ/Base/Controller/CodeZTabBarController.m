//
//  CodeZTabBarController.m
//  CodeZ
//
//  Created by Primb_yqx on 16/12/15.
//  Copyright © 2016年 HQExample. All rights reserved.
//

#import "CodeZTabBarController.h"
#import "CodeZNavigationController.h"
#import "HomeController.h"
#import "SettingController.h"

@interface CodeZTabBarController ()
@property NSArray * controllerNames;
@property NSArray * titles;
@end

@implementation CodeZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _controllerNames = @[@"HomeController",@"SettingController"];
    _titles = @[@"首页",@"设置"];
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    for (int i = 0; i < [_controllerNames count]; i ++) {
        NSString * controllerStr = [_controllerNames objectAtIndex:i];
        NSString * title = [_titles objectAtIndex:i];
        UIViewController * baseController = [[NSClassFromString(controllerStr) alloc] init];
        [self addChildViewController:baseController withTItle:title];
    }
}

- (void)addChildViewController:(UIViewController *)childController
                     withTItle:(NSString *) title
{
    childController.title = title;
    CodeZNavigationController * codeZNav = [[CodeZNavigationController alloc]
                                            initWithRootViewController:childController];
    [self addChildViewController:codeZNav];
}
@end
