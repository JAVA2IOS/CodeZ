//
//  CZGestureRecognizerManager.h
//  CodeZ
//
//  Created by Primb_yqx on 17/4/13.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Tap,
    Rotate,
    Pan,
} GestureRecognizerType;

@interface CZGestureRecognizerManager : NSObject

+ (void)addGestureRecognizer:(GestureRecognizerType)type onModel:(id)sender gestureHandler:(void(^)(id sender,UIGestureRecognizer* gestureRecognizer))block;

+ (void)addGestureRecognizer:(GestureRecognizerType)type onModel:(id)sender action:(SEL)sel;

@end
