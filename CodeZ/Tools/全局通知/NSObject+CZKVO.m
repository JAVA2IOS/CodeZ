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

- (void)cz_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(void (^)(id, NSString *, id, id))observerBlock {
    // 检查对象类是否有setter方法，如果没有抛出异常
    unsigned int count = 0;
    Method *methods = class_copyMethodList([self class], &count);
    BOOL isExist = NO;
    for (int i = 0; i < count; i ++) {
        SEL sel = method_getName(methods[i]);
        // 判断是否实现了setter
        if ([NSStringFromSelector(sel) isEqualToString:[self setterKey:key]]) {
            isExist = YES;
            break;
        }
    }
    // 判断是否存在该方法
    if (isExist) {
        // 创建派生类
        NSString *newClassName = [@"CZKVO_" stringByAppendingString:NSStringFromClass([self class])];
        NSString *nowClassName = NSStringFromClass([self class]);
        // 判断是否存在当前类
        if (![nowClassName isEqual:newClassName]) {
            Class NotifyClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
            // 注册类
            objc_registerClassPair(NotifyClass);
            // 修改self的类型，从当前类的类型转换为派生类
            object_setClass(self, NotifyClass);
        }
        // 重写setter方法
        // 新增方法 1 cls 类 2 SEL 方法编号 3 IMP 方法实现(指针) 4 方法类型 type method_getTypeEncoding
        // 方法类型标识符  v代表返回类型void @ 代表OC对象 : 代表方法SEL 具体可查看文档
        class_addMethod([self class], @selector(setterKey:), (IMP)kvo_setterForKey, "v@:");
    }else {
        NSLog(@"没有实现setter方法");
    }
}

void kvo_setterForKey(id self, SEL _cmd, NSString *newValue) {
    NSString *selStr = NSStringFromSelector(_cmd);
    NSString *getterName = [self getterForSetter:selStr];
    id oldValue = [self valueForKey:getterName];
    [self willChangeValueForKey:oldValue];
    [self setValue:newValue forKey:selStr];
    objc_msgSend(self, _cmd);
    [self didChangeValueForKey:newValue];
}

- (NSString *)getterForSetter:(NSString *)setterName {
    if (setterName.length > 0) {
        NSString *remainString = [setterName substringFromIndex:3];
        return [NSString stringWithFormat:@"get%@", remainString];
    }
    return nil;
}

// 将首字母大写setter方法
- (NSString *)setterKey:(NSString *)key {
    if (key.length > 0) {
        // 第一个大写
        NSString *firstString = [[key  substringToIndex:1] uppercaseString];
        // 保留后方字符串
        NSString *remainString = [key substringFromIndex:1];
        
        return [NSString stringWithFormat:@"set%@%@:", firstString, remainString];
    }
    return nil;
}

@end
