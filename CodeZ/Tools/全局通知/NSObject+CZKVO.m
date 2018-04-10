//
//  NSObject+CZKVO.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/9.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "NSObject+CZKVO.h"
#import <objc/runtime.h>

@implementation NSObject (CZKVO)

+ (void)cz_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(void (^)(id, NSString *, id, id))observerBlock {
    // 检查对象类是否有setter方法，如果没有抛出异常
    int count;
    Method *methods = class_copyMethodList([self class], &count);
    BOOL isExist = NO;
    for (int i = 0; i < &count; i ++) {
        SEL sel = method_getName(methods[i]);
        if ([NSStringFromSelector(sel) isEqualToString:@""]) {
            isExist = YES;
            break;
        }
    }
    // 判断是否存在该方法
    if (isExist) {
        // 创建派生类
        NSString *newClassName = [@"CZKVO_" stringByAppendingString:NSStringFromClass([self class])];
        Class NotifyClass = objc_allocateClassPair([observer class], newClassName.UTF8String, 0);
        // 注册类
        objc_registerClassPair(NotifyClass);
        // 修改self的类型，从当前类的类型转换为派生类
        object_setClass(self, NotifyClass);
        
        // 重写setter方法
        class_addMethod(self, @selector(set:), (IMP)class_getMethodImplementation([self class], @selector(set:)), "v@:");
    }

}

@end
