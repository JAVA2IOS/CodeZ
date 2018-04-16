//
//  MVCViewController.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/3/28.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "CodeZBaseController.h"

typedef void(^spaceBlock)();

@interface MVCViewController : CodeZBaseController

@property (nonatomic, retain) spaceBlock retainBlock;
@property (nonatomic, strong) spaceBlock strongBlock;


@end
