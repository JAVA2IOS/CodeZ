//
//  OneModel.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/9.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "OneModel.h"
#import "TwoModel.h"

@implementation OneModel

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // 为当前类添加一个方法,参数占位符V@:等等
//    class_addMethod(self, sel, (IMP)doThings, "");
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    // 进行了消息转发
    TwoModel *twoModel = [[TwoModel alloc] init];
    return twoModel;
}

/*
 OC对象会默认传入两个参数 id self SEL _cmd  (跟消息发送有关， 第一个为对象，第二个为方法名)
 */

void doThings(){
    NSLog(@"发送消息");
}

@end
