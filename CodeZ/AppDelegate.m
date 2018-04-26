//
//  AppDelegate.m
//  CodeZ
//
//  Created by Primb_yqx on 16/12/15.
//  Copyright © 2016年 HQExample. All rights reserved.
//

#import "AppDelegate.h"
#import "CodeZAPNsConfigureCenter.h"
#import "CodeZTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ios 10以后角标的处理，需要配置推送才能使用
    [CodeZAPNsConfigureCenter sharedAPNsCenter];
    CodeZTabBarController *codeZTab = [[CodeZTabBarController alloc] init];
    self.window.rootViewController = codeZTab;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 获取到deviceToken，将deviceToken发送到后台处理
    NSString *deviceId = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    NSLog(@"deviceToken:%@",deviceId);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // 推送注册失败响应方法
    NSLog(@"get Device Token Failed! %@", error.userInfo[NSLocalizedDescriptionKey]);
}

#pragma mark ios 10 以下处理推送响应方法

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    if (iOS_ver <= 10) {
        switch (application.applicationState) {
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
        completionHandler(UIBackgroundFetchResultNewData);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // ios8以后需要注册推送通知，才能使用角标application must register for user notifications
    application.applicationIconBadgeNumber = 10;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
