//
//  UIViewController+HQNavigationDelegate.h
//  BankBigHouseKeeper-Iphone
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 primb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQAnimatedTransitioning.h"
@interface HQNavigationDelegate : NSObject <UINavigationControllerDelegate>
@end

@interface UIViewController (HQNavigationDelegate)
@property (nonatomic,strong) id<UIViewControllerAnimatedTransitioning> hqTransition;
@end
