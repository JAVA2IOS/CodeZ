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
    SEL selectedSEL = nil;
    BOOL isExist = NO;
    for (int i = 0; i < count; i ++) {
        SEL sel = method_getName(methods[i]);
        // 判断是否实现了setter
        if ([NSStringFromSelector(sel) isEqualToString:setterKey(key)]) {
            selectedSEL = sel;
            isExist = YES;
            break;
        }
    }
    // 判断是否存在该方法
    if (isExist) {
        // 创建派生类
        NSString *newClassName = [@"CZKVONotifying_" stringByAppendingString:NSStringFromClass([self class])];
        Class NotifyClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
        // 注册类
        objc_registerClassPair(NotifyClass);
        // 重写setter方法
        // 新增方法 1 cls 类 2 SEL 方法编号 3 IMP 方法实现(指针) 4 方法类型 type method_getTypeEncoding
        // 方法类型标识符  v代表返回类型void @ 代表OC对象 : 代表方法SEL 具体可查看文档
        // 问题 ： 无法传参数值 ****
        class_addMethod(NotifyClass, (SEL)selectedSEL, (IMP)kvo_setterForKey, "v@:@");
        // 修改self的类型，isa指针从当前类的类型转换为派生类
        object_setClass(self, NotifyClass);
        // 将block跟self方法关联
        objc_setAssociatedObject(self, selectedSEL, observerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }else {
        NSLog(@"没有实现setter方法");
    }
}

static void kvo_setterForKey(id self, SEL _cmd, id value) {
    NSString *selStr = NSStringFromSelector(_cmd);
    NSString *remainString = [selStr substringFromIndex:3];
    // 第一个字母小写
    NSString *lowerCaseString = [[remainString substringToIndex:1] lowercaseString];
    // 拼接第一个大写字母到最后：结尾
    NSString *newString = [lowerCaseString stringByAppendingString:[remainString substringFromIndex:1]];
    // 去掉:
    NSString *propertyName = [newString substringToIndex:newString.length - 1];
    id oldValue = [self valueForKey:propertyName];
    [self willChangeValueForKey:propertyName];
    [self setValue:value forKey:propertyName];
    [self didChangeValueForKey:propertyName];
    void(^oberserBlock)(id, NSString *, id, id) = objc_getAssociatedObject(self, _cmd);
    if (oberserBlock) {
        oberserBlock(self, selStr, oldValue, value);
    }
}




static NSString * getterForSetter(NSString *setterName) {
    if (setterName.length > 0) {
        NSString *remainString = [setterName substringFromIndex:3];
        return [NSString stringWithFormat:@"get%@", remainString];
    }
    return nil;
}

// 将首字母大写setter方法
static NSString * setterKey(NSString *key) {
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
