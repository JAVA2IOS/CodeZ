//
//  UIViewController+HQNavigationDelegate.m
//  BankBigHouseKeeper-Iphone
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 primb. All rights reserved.
//

#import "UIViewController+HQNavigationDelegate.h"
@implementation HQNavigationDelegate

//转场动画淡入淡出
- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                           animationControllerForOperation:(UINavigationControllerOperation)operation
                                                        fromViewController:(UIViewController *)fromVC
                                                          toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:
//            return toVC.hqTransition;
            break;
        case UINavigationControllerOperationPop:
//            return fromVC.hqTransition;
            break;
        default:
            return nil;
            break;
    }
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return nil;
}

@end

static const void *popAndpushKey = &popAndpushKey;

@implementation UIViewController (HQNavigationDelegate)
//-(void) setHqTransition:(id<UIViewControllerAnimatedTransitioning>)hqTransition {
//    objc_setAssociatedObject(self, popAndpushKey, hqTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//-(id<UIViewControllerAnimatedTransitioning>) hqTransition {
//    return objc_getAssociatedObject(self, popAndpushKey);
//}
@end
