//
//  UIButton+ResponderBlock.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/27.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "UIButton+ResponderBlock.h"

static const char CZButtonResponder;
static const char CodeZTitle;

@implementation UIButton (ResponderBlock)

- (void)cz_buttonResponderBlock:(void (^)(id))block {
    if (block) {
        // 将self跟block关联起来, 第二个参数为静态变量,作为value(block)的key值，通过Key去找value
        objc_setAssociatedObject(self, &CZButtonResponder, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    [self addTarget:self action:@selector(p_buttonResponder:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_buttonResponder:(id)responder {
    void (^responderBlock)(id responder) = objc_getAssociatedObject(self, &CZButtonResponder);
    if (responderBlock) {
        responderBlock(responder);
    }
}

// 关联属性，需要实现setter/getter方法
- (void)setCzTitle:(NSString *)czTitle {
    objc_setAssociatedObject(self, &CodeZTitle, czTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)czTitle {
    NSString *valueString = objc_getAssociatedObject(self, &CodeZTitle);
    return valueString;
}

@end
