//
//  NSObject+CZKVO.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/9.
//  Copyright © 2018年 HQExample. All rights reserved.
//  自定义实现KVO底层实现原理

#import <Foundation/Foundation.h>

@interface NSObject (CZKVO)

+ (void)cz_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(void(^)(id observerObject, NSString *observerKey, id oldValue, id newValue))observerBlock;
+ (void)cz_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
