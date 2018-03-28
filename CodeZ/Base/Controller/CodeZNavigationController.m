//
//  CodeZNavigationController.m
//  CodeZ
//
//  Created by Primb_yqx on 16/12/15.
//  Copyright © 2016年 HQExample. All rights reserved.
//

#import "CodeZNavigationController.h"

@implementation CodeZVCAnimatedTransitioning
-(id) initWithType:(UIViewKeyframeAnimationOptions) option {
    self = [super init];
    _operationType = option;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [toVC.view layoutIfNeeded];
    
    BOOL optionsContainShowHideTransitionViews = (_operationType & UIViewAnimationOptionShowHideTransitionViews) != 0;
    if (!optionsContainShowHideTransitionViews) {
        [[transitionContext containerView] addSubview:toVC.view];
    }
    
    [UIView transitionFromView:fromVC.view
                        toView:toVC.view
                      duration:5.0
                       options:_operationType | UIViewAnimationOptionShowHideTransitionViews
                    completion:^(BOOL finished) {
                        [fromVC.view removeFromSuperview];
                        [transitionContext completeTransition:YES];
                    }];
}
@end

@interface CodeZNavigationController () <UINavigationControllerDelegate> {
    
}

@end

@implementation CodeZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回指定转场动画
- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                           animationControllerForOperation:(UINavigationControllerOperation)operation
                                                        fromViewController:(UIViewController *)fromVC
                                                          toViewController:(UIViewController *)toVC
{
    CodeZVCAnimatedTransitioning * codezTransitioning = [[CodeZVCAnimatedTransitioning alloc] init];
    codezTransitioning.operationType = UIViewAnimationOptionTransitionCrossDissolve;
    return codezTransitioning;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return nil;
}

@end
