//
//  CodeZBaseController.m
//  CodeZ
//
//  Created by Primb_yqx on 16/12/15.
//  Copyright © 2016年 HQExample. All rights reserved.
//

#import "CodeZBaseController.h"

@interface CodeZBaseController ()
@end

@implementation CodeZBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)backToViewController {
    self.navigationItem.leftBarButtonItem =[self withNormalImage:@"back" target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)withNormalImage:(NSString *)image target:(id)target action:(SEL)action{
    UIImage *normalImage = [UIImage imageNamed:image];
//    CGImageRef cgRef = normalImage.CGImage;
//    CGImageRef partRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(80, 900, 100, 100));
//    UIImage *partImg = [UIImage imageWithCGImage:partRef];
//    normalImage = partImg;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
