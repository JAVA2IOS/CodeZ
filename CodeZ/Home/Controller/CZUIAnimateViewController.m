//
//  CZUIAnimateViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/9.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CZUIAnimateViewController.h"
#import "CZRotateView.h"
#import "CZRotationMenu.h"
#import "CodeZTransitionAnimation.h"
#import "CZDetailViewController.h"

@interface CZUIAnimateViewController() <CAAnimationDelegate, UINavigationControllerDelegate> {
    CZRotateView *rotateV;
    CZRotationMenu *menu;
    CAShapeLayer *maskLayer;
    UIView *basicView;
    UIView *maskView;
    UIBezierPath *maskPath;
}
@end

@implementation CZUIAnimateViewController
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.delegate = nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self backToViewController];
    
    rotateV = [[CZRotateView alloc] initWithFrame:CGRectMake(SELFVIEWWIDTH / 2 - 25, 300, 50,50)];
    [self.view addSubview:rotateV];
    rotateV.layer.cornerRadius = rotateV.frame.size.height / 2;
    rotateV.backgroundColor = UIColorFromRGB(0xffffff);
    rotateV.layer.shadowColor = UIColorFromRGB(0x999999).CGColor;
    rotateV.layer.shadowOpacity = 0.5;
    rotateV.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    [rotateV touchedEndedMethod:^(BOOL touched) {
        if (touched) {
            [menu openAnimatedMenu];
        }else{
            [menu closeAnimatedMenu];
        }
    }];
    
    menu = [[CZRotationMenu alloc] initWithFrame:CGRectMake(150, 400, 200, 200)];
    menu.center = rotateV.center;
    [self.view insertSubview:menu belowSubview:rotateV];
    menu.backgroundColor = [UIColor clearColor];
    menu.titles = @[@"主页",@"信息",@"业务",@"工作"];
    menu.buttonStyle = CZButtonStyleDefault;    //默认
    menu.images = @[@"home_2",@"message_2",@"business_center_2",@"task_management_2"];
    menu.alpha = 0;
    __weak typeof(self) weak_self = self;
    [menu menuResponsedMethod:^(int index) {
        NSLog(@"%d",index);
//        [weak_self cz_startMaskLayerAnimation];
        CZDetailViewController *detail_v = [[CZDetailViewController alloc] init];
        [weak_self.navigationController pushViewController:detail_v animated:YES];
    }];
    
    [self cz_addMaskLayerAnimation];
}

- (void)cz_addMaskLayerAnimation {
    basicView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, SELFVIEWWIDTH - 40, 100)];
    basicView.backgroundColor = UIColorFromRGB(0xff6347);
    [self.view addSubview:basicView];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(basicView.frame.size.width / 2, basicView.frame.size.height / 2) radius:0.01 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillColor = UIColorFromRGB(0xffffff).CGColor;
    maskLayer.strokeColor = UIColorFromRGB(0xffffff).CGColor;
    [basicView.layer setMask:maskLayer];
    
}

- (void)cz_startMaskLayerAnimation {
    float radius = sqrtf(powf(basicView.frame.size.width, 2) + powf(basicView.frame.size.height, 2)) / 2;
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(10, 10) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(path))];
    maskAnimation.fromValue = (__bridge id _Nullable)(maskPath.CGPath);
    maskAnimation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithArcCenter:CGPointMake(basicView.frame.size.width / 2, basicView.frame.size.height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath);
    maskAnimation.duration = 2.0f;
    maskAnimation.fillMode = kCAFillModeForwards;
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.delegate = self;
    
    [maskLayer addAnimation:maskAnimation forKey:nil];
}


#pragma mark - delegate methods
- (void)animationDidStart:(CAAnimation *)anim {
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [maskLayer removeFromSuperlayer];
}

- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                           animationControllerForOperation:(UINavigationControllerOperation)operation
                                                        fromViewController:(UIViewController *)fromVC
                                                          toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[CodeZTransitionAnimation alloc] init];
    }else{
        return nil;
    }
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return nil;
}
@end
