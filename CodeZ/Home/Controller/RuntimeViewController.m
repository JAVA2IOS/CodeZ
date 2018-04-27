//
//  RuntimeViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/27.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "RuntimeViewController.h"
#import "UIButton+ResponderBlock.h"

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
