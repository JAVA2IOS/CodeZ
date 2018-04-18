//
//  MVVMTableCell.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVVMTableCell.h"
#import "MVCModel.h"
/*
 ViewModel处理model的数据获取，将数据以block返回
 */

@implementation MVVMTableCell

- (void)getModelData:(void (^)(id))succcess {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i ++) {
        @autoreleasepool {
            MVCModel *model = [[MVCModel alloc] init];
            model.title = [NSString stringWithFormat:@"model title : %d", i];
            [dataArray addObject:model];
        }
    }
    
    if (succcess) {
        succcess(dataArray);
    }
}
@end
