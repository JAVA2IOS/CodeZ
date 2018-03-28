//
//  CodeZTransitionAnimation.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/13.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CodeZTransitionAnimation.h"
@interface CodeZTransitionAnimation() <CAAnimationDelegate> {
    id <UIViewControllerContextTransitioning> TransitionContext;
    UIViewController *toVC;
    UIViewController *fromVC;
}
@end

@implementation CodeZTransitionAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    TransitionContext = transitionContext;
    toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [toVC.view layoutIfNeeded];
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.navigationController.navigationBar.alpha = 0;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(toVC.view.frame.size.width / 2, toVC.view.frame.size.height / 2) radius:0.01 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    maskLayer.path = maskPath.CGPath;
    maskLayer.fillColor = UIColorFromRGB(0xffffff).CGColor;
    maskLayer.strokeColor = UIColorFromRGB(0xffffff).CGColor;
    [toVC.view.layer setMask:maskLayer];
    
    float radius = sqrtf(powf(toVC.view.frame.size.width, 2) + powf(toVC.view.frame.size.height, 2)) / 2;
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(10, 10) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(path))];
    maskAnimation.fromValue = (__bridge id _Nullable)(maskPath.CGPath);
    maskAnimation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithArcCenter:CGPointMake(toVC.view.frame.size.width / 2, toVC.view.frame.size.height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath);
    maskAnimation.duration = 0.3f;
    maskAnimation.fillMode = kCAFillModeForwards;
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.delegate = self;
    
    [maskLayer addAnimation:maskAnimation forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim {
    [UIView animateWithDuration:0.1f
                          delay:0.3f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.navigationController.navigationBar.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    toVC = [TransitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    fromVC = [TransitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [fromVC.view removeFromSuperview];
    [TransitionContext completeTransition:YES];
}
@end
