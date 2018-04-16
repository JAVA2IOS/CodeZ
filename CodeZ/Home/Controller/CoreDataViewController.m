//
//  CoreDataViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/16.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "CoreDataViewController.h"
#import "UserInfo+CoreDataProperties.h"
#import "CodeZDataManager.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CodeZDataManager sharedManagedObjectContext] dataInsertWithEntityName:@"UserInfo"
                                                                       data:@{@"username":@"nametwo", @"password":@"321"}
                                                                    success:^{
                                                                        NSLog(@"成功");
                                                                    } failure:^(NSError *error) {
                                                                        NSLog(@"失败");
                                                                    }];
    NSPredicate *preedicate = [NSPredicate predicateWithFormat:@"username = %@", @"nametwo"];
    /*
     [[CodeZDataManager sharedManagedObjectContext] dataDeleteWithEntityName:@"UserInfo"
     predicate:preedicate
     success:^{
     NSLog(@"删除成功");
     } failure:^(NSError *error) {
     NSLog(@"删除失败");
     }];
     */
    [[CodeZDataManager sharedManagedObjectContext] dataSearchWithEntityName:@"UserInfo"
                                                                  predicate:nil
                                                                    success:^(NSArray *data, int dataCount) {
                                                                        NSLog(@"%@, %d", data, dataCount);
                                                                    } failure:^(NSError *error) {
                                                                        NSLog(@"查询失败");
                                                                    }];
    /*
     // 创建模型对象
     // 模型路径
     NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"CodeZData" withExtension:@"momd"];
     // 根据模型文件创建模型对象
     NSManagedObjectModel *userModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
     
     // 持久化存储器，相当于连接数据库的连接器，设置数据存储的位置以及名字等
     NSPersistentStoreCoordinator *coorDinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:userModel];
     // 创建数据库文件
     NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     NSString *sqltePath = [filePath stringByAppendingString:@"CodeZ.sqlite"];
     NSURL *sqlUrl = [NSURL fileURLWithPath:sqltePath];
     
     NSError *createError = nil;
     
     // 增加sqlite数据库
     [coorDinator addPersistentStoreWithType:NSSQLiteStoreType
     configuration:nil
     URL:sqlUrl
     options:nil
     error:&createError];
     if (createError) {
     NSLog(@"创建数据库出错");
     }else {
     NSLog(@"创建数据库正确");
     }
     
     // coreData上下文对象管理,这是一个并发队列,ios 9以后使用以下方法初始化，负责数据的实际操作(增删查改)
     NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
     // 上下文关联持久化存储
     ctx.persistentStoreCoordinator = coorDinator;
     
     // 创建一个实体模型(例如userinfo)
     NSManagedObject *userInfoEntity = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo"
     inManagedObjectContext:ctx];
     
     //以下方法为增删查改方法
     [userInfoEntity setValue:@"nameOne" forKey:@"username"];
     [userInfoEntity setValue:@"123" forKey:@"password"];
     
     // 请求语句
     NSError *error = nil;
     // 执行操作语句，返回YES/NO
     [ctx save:&error];
     if (error) {
     NSLog(@"插入失败");
     }else {
     NSLog(@"插入成功");
     }
     */
    
    
    
    
    /*
     // 查询语句
     NSFetchRequest *userRequest = [UserInfo fetchRequest];
     // 设置查询条件，可添加过滤条件
     NSEntityDescription *description = [NSEntityDescription entityForName:@"UserInfo"
     inManagedObjectContext:ctx];
     // 执行请求
     NSError *excueError = nil;
     NSAsynchronousFetchResult *result = [[NSAsynchronousFetchResult alloc] init];
     result = [ctx executeRequest:userRequest error:&excueError];
     if (excueError) {
     NSLog(@"查询失败");
     }else {
     NSLog(@"数据：%d, %@", result.finalResult.count, result.finalResult);
     }
     NSPrivateQueueConcurrencyType 在子线程实例化当前对象
     NSMainQueueConcurrencyType 在主线程实例化对象(推荐)
     
     
     // NSManagedObject 被管理的数据记录,类似表中的数据
     // NSEntityDescription 实体结构，类似于数据库中的表
     // NSFetchRequest 数据请求，类似于sql语句
     // 创建对象管理模型
     NSManagedObjectModel *dataModel = [[NSManagedObjectModel alloc] init];
     
     
     
     
     
     
     NSManagedObject *userObject = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo"
     inManagedObjectContext:ctx];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
