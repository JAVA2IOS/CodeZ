//
//  CodeZAPNsConfigureCenter.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/26.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "CodeZAPNsConfigureCenter.h"

@implementation CodeZAPNsConfigureCenter

+ (instancetype)sharedAPNsCenter {
    static CodeZAPNsConfigureCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[CodeZAPNsConfigureCenter alloc] init];
    });
    [center p_configureAPNs];
    return center;
}

/**
 配置APNs文件
 */
- (void)p_configureAPNs {
    if(iOS_ver >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        // 配置角标、声音、弹出框
        UNAuthorizationOptions type = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted) {
                NSLog(@"注册成功");
            }else {
                NSLog(@"注册失败");
            }
        }];
        // 注册获取device Token
    }else if (iOS_ver >= 8) {
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}


#pragma mark - ios 10以上处理方法

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    switch ([UIApplication sharedApplication].applicationState) {
            case UIApplicationStateActive:
            // 程序位于前台处理
            break;
            case UIApplicationStateBackground:
            // 程序位于后台处理
            break;
            case UIApplicationStateInactive:
            // 程序处于关闭状态
            break;
        default:
            break;
    }
    // 选择提醒用户类型,响应方式(声音、角标、弹出框）
    completionHandler(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // 获取到推送的数据
}
@end
