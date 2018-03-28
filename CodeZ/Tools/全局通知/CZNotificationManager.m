//
//  CZNotificationManager.m
//  CodeZ
//
//  Created by Primb_yqx on 17/9/22.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CZNotificationManager.h"
#define CZNotificationCenter [NSNotificationCenter defaultCenter]
@interface CZNotificationObject : NSObject
@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, weak) id notificationParameters;
@end;


@interface CZNotificationManager() {
    NSMutableArray *notificationIdentifiesKeyData;
    NSString *currentNotificationName;
}
@end;

static NSString *kKey_CZNotificationName = @"notificationKey";

@implementation CZNotificationManager

+ (instancetype)sharedNotification {
    static CZNotificationManager *noti = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noti = [[self alloc] init];
    });
    
    return noti;
}

- (instancetype)init {
    self = [super init];
    notificationIdentifiesKeyData = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)dealloc {
}

- (void)czAddNotification:(NSString *)key {
//    [CZNotificationCenter addObserver:self selector:@selector(notificationHandler:) name:key object:nil];
//    CZNotificationObject *notifiObj = [[CZNotificationObject alloc] init];
//    notifiObj.notificationName = key;
//    [notificationIdentifiesKeyData addObject:notifiObj];
}

- (void)removeNotification:(NSString *)key {
//    [notificationIdentifiesKeyData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CZNotificationObject *notifiObj = (CZNotificationObject *)obj;
//        // 判断是否存在，存在则移除当前数据
//        if ([notifiObj.notificationName isEqualToString:key]) {
//            [notificationIdentifiesKeyData removeObject:notifiObj];
//            *stop = YES;
//        }
//    }];
}

- (void)czPostNotification:(NSString *)key parameters:(id)parameters {
    [CZNotificationCenter postNotificationName:key object:parameters];
}

- (void)notificationHandler:(NSNotification *)noti {
    
}

@end
