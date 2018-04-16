//
//  CodeZDataManager.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/16.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^excuteSuccessBlock)();
typedef void(^excuteFailureBlock)(NSError *error);
typedef void(^searchSuccessBlock)(NSArray *data, int dataCount);
typedef void(^searchFailureBlock)(NSError *error);

@interface CodeZDataManager : NSObject
/**
 关联上下文对象
 */
@property (nonatomic, readonly, retain) NSManagedObjectContext *managedCtx;

+ (instancetype)sharedManagedObjectContext;

/**
 执行操作(新增)

 @param entityName 实例名称
 @param valueData 需要更新的数据
 @param success 成功回调
 @param failure 失败回调
 */
- (void)dataInsertWithEntityName:(NSString *)entityName
                            data:(NSDictionary *)valueData
                         success:(excuteSuccessBlock)success
                         failure:(excuteFailureBlock)failure;

/**
 删除数据

 @param entityName 实例名称
 @param predicate 筛选条件
 @param success 成功回调
 @param failure 失败回调
 */
- (void)dataDeleteWithEntityName:(NSString *)entityName
                       predicate:(NSPredicate *)predicate
                         success:(excuteSuccessBlock)success
                         failure:(excuteFailureBlock)failure;

/**
 查询操作

 @param entityName 实例名
 @param predicate 筛选条件
 @param searchSuccessBlock 成功回调
 @param failure 失败回调
 */
- (void)dataSearchWithEntityName:(NSString *)entityName
                       predicate:(NSPredicate *)predicate
                         success:(searchSuccessBlock)success
                         failure:(searchFailureBlock)failure;
@end
