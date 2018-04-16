//
//  UserInfo+CoreDataProperties.m
//  
//
//  Created by Primb_yqx on 2018/4/16.
//
//

#import "UserInfo+CoreDataProperties.h"

@implementation UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
}

@dynamic username;
@dynamic password;

@end
