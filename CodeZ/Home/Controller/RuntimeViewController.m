//
//  RuntimeViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/27.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "RuntimeViewController.h"
#import "UIButton+ResponderBlock.h"
#import "NSObject+CZKVO.h"
#import "RuntimeModel.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [button setTitle:@"你好" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xC1CDCD) forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorFromRGB(0x528b8b)];
    [self.view addSubview:button];
    button.tag = 2001;
    button.czTitle = @"objc Association Property";
    [button cz_buttonResponderBlock:^(id responder) {
        UIButton *btn = (UIButton *)responder;
        NSLog(@"你好，响应%ld, %@", btn.tag, btn.czTitle);
    }];
    
    RuntimeModel *runtimeModel = [[RuntimeModel alloc] init];
    [runtimeModel cz_addObserver:self forKey:@"runtimeNumber" withBlock:^(id observerObject, NSString *observerKey, id oldValue, id newValue) {
        NSLog(@"%@,%@", oldValue, newValue);
    }];
    // 直接复制有错误，报野指针，即无法传参数
    runtimeModel.runtimeNumber = 3;
    // 以下方法可用，可传参数
    if ([runtimeModel respondsToSelector:@selector(setRuntimeNumber:)]) {
//        [runtimeModel performSelector:@selector(setRuntimeNumber:) withObject:@3];
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
