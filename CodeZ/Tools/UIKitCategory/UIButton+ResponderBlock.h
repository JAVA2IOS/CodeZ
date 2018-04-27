//
//  UIButton+ResponderBlock.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/27.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ResponderBlock)

@property (nonatomic , copy) NSString *czTitle;

- (void)cz_buttonResponderBlock:(void(^)(id responder))block;

@end
