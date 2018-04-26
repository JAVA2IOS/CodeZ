//
//  CodeZAPNsConfigureCenter.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/26.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface CodeZAPNsConfigureCenter : NSObject<UNUserNotificationCenterDelegate>

+ (instancetype)sharedAPNsCenter;

@end
