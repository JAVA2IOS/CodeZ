//
//  CZNotificationManager.h
//  CodeZ
//
//  Created by Primb_yqx on 17/9/22.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CZNotificationHandler)(id parameters);

@interface CZNotificationManager : NSObject

+ (instancetype)sharedNotification;

- (void)czAddNotification:(NSString *)key;

- (void)czPostNotification:(NSString *)key parameters:(id)parameters;

- (void)removeNotification:(NSString *)key;

@end
