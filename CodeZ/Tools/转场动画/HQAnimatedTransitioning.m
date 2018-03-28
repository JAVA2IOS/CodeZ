//
//  HQAnimatedTransitioning.m
//  BankBigHouseKeeper-Iphone
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "HQAnimatedTransitioning.h"

@implementation HQAnimatedTransitioning
-(id) initWithType:(UIViewAnimationOptions) option {
    _transitionTime = 0.3;
    return [self initWithType:_operationType andTransitionTime:_transitionTime];
}

-(id) initWithType:(UIViewAnimationOptions) option andTransitionTime:(int) time {
    self = [super init];
    _operationType = option;
    _transitionTime = time;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return _transitionTime;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        [toVC.view layoutIfNeeded];
    
        BOOL optionsContainShowHideTransitionViews = (UIViewAnimationOptionTransitionCrossDissolve & UIViewAnimationOptionShowHideTransitionViews) != 0;
        if (!optionsContainShowHideTransitionViews) {
            [[transitionContext containerView] addSubview:toVC.view];
        }
    
        [UIView transitionFromView:fromVC.view
                            toView:toVC.view
                          duration:_transitionTime
                           options:_operationType | UIViewAnimationOptionShowHideTransitionViews
                        completion:^(BOOL finished) {
                            if (!optionsContainShowHideTransitionViews) {
                                [fromVC.view removeFromSuperview];
                            }
                            [transitionContext completeTransition:YES];
                        }];
}
@end
