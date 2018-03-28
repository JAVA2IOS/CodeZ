//
//  CZGestureRecognizerManager.m
//  CodeZ
//
//  Created by Primb_yqx on 17/4/13.
//  Copyright © 2017年 HQExample. All rights reserved.
//

typedef void(^handlerBlock)(id, UIGestureRecognizer*);

#import "CZGestureRecognizerManager.h"

@interface CZGestureRecognizerManager() {
    handlerBlock handleBlock;
}
@end

@implementation CZGestureRecognizerManager
+ (void)addGestureRecognizer:(GestureRecognizerType)type onModel:(id)sender gestureHandler:(void (^)(id, UIGestureRecognizer *))block {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [sender addGestureRecognizer:tap];
}

+ (void)addGestureRecognizer:(GestureRecognizerType)type onModel:(id)sender action:(SEL)sel {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:sender action:sel];
    [sender addGestureRecognizer:tap];
}

@end
