//
//  CodeZDataManager.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/16.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "CodeZDataManager.h"
#import <CoreData/CoreData.h>

static NSString * const kCoreDataName = @"CodeZData";

@interface CodeZDataManager()
@property (nonatomic, readwrite, retain) NSManagedObjectContext *managedCtx;
@end

@implementation CodeZDataManager

+ (instancetype)sharedManagedObjectContext {
    static CodeZDataManager *codeZ = nil;
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        codeZ = [[CodeZDataManager alloc] init];
        [codeZ p_createOpenCoreData];
    });
    
    return codeZ;
}

- (void)p_createOpenCoreData {
    // 创建模型对象
    // 模型路径
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:kCoreDataName withExtension:@"momd"];
    // 根据模型文件创建模型对象
    NSManagedObjectModel *userModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    
    // 持久化存储器，相当于连接数据库的连接器，设置数据存储的位置以及名字等
    NSPersistentStoreCoordinator *coorDinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:userModel];
    // 创建数据库文件
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqltePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"%@.sqlite", kCoreDataName]];
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqltePath];
    
    NSError *createError = nil;
    
    // 增加sqlite数据库
    [coorDinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:sqlUrl
                                    options:nil
                                      error:&createError];
    if (createError) {
        NSAssert(!createError, @"create sqlite file failed!");
    }
    
    // 上下文关联持久化存储
    self.managedCtx.persistentStoreCoordinator = coorDinator;
}

- (void)dataInsertWithEntityName:(NSString *)entityName
                            data:(NSDictionary *)valueData
                         success:(excuteSuccessBlock)success
                         failure:(excuteFailureBlock)failure
{
    // 创建一个实体模型(例如userinfo)
    NSManagedObject *userInfoEntity = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                                    inManagedObjectContext:self.managedCtx];
    
    // 设置需要插入的数据
    [[valueData allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [userInfoEntity setValue:[valueData objectForKey:obj] forKey:obj];
    }];
    
    // 请求语句
    NSError *error = nil;
    // 执行操作语句，返回YES/NO
    BOOL succcessd = [self.managedCtx save:&error];
    if (succcessd) {
        if (success) {
            success();
        }
    }else {
        if (failure) {
            failure(error);
        }
    }
}

- (void)dataDeleteWithEntityName:(NSString *)entityName
                       predicate:(NSPredicate *)predicate
                         success:(excuteSuccessBlock)success
                         failure:(excuteFailureBlock)failure
{
    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    deleRequest.predicate = predicate;
    
    NSAsynchronousFetchResult *result = [self.managedCtx executeRequest:deleRequest error:nil];
    
    [result.finalResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
        [self.managedCtx deleteObject:obj];
    }];
    
    // 请求语句
    NSError *error = nil;
    // 执行操作语句，返回YES/NO
    BOOL succcessd = [self.managedCtx save:&error];
    if (succcessd) {
        if (success) {
            success();
        }
    }else {
        if (failure) {
            failure(error);
        }
    }
}

- (void)dataSearchWithEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate success:(searchSuccessBlock)success failure:(searchFailureBlock)failure
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (predicate) {
        fetchRequest.predicate = predicate;
    }
    NSError *error = nil;
    NSAsynchronousFetchResult *result = [self.managedCtx executeRequest:fetchRequest error:&error];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [result.finalResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSManagedObject *userObject = (NSManagedObject *)obj;
//        NSLog(@"userObject %@, entity:%@", userObject, [userObject valueForKey:@"propertyName"]);
        [dataArray addObject:userObject.entity.userInfo];
    }];
    if (!error) {
        if (success) {
            success(dataArray, (int)dataArray.count);
        }
    }else {
        if (failure) {
            failure(error);
        }
    }
}



#pragma mark 懒加载获取NSManagedObjectContext
- (NSManagedObjectContext *)managedCtx {
    if (!_managedCtx) {
        // coreData上下文对象管理,这是一个并发队列,ios 9以后使用以下方法初始化，负责数据的实际操作(增删查改)
        _managedCtx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    }
    return _managedCtx;
}

@end
