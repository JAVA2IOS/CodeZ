//
//  HQAnimatedTransitioning.h
//  BankBigHouseKeeper-Iphone
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 primb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HQAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
@property UIViewAnimationOptions operationType;
@property int transitionTime;
-(id) initWithType:(UIViewAnimationOptions) option;
-(id) initWithType:(UIViewAnimationOptions) option andTransitionTime:(int) time;
@end
