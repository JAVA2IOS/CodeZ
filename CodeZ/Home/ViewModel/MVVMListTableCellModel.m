//
//  MVVMListTableCellModel.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVVMListTableCellModel.h"
#import "MVVMTableCell.h"
#import "MVCModel.h"

@implementation MVVMListTableCellModel
- (void)getJsonData:(void (^)(id))success {
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i ++) {
        @autoreleasepool {
            MVCModel *model = [[MVCModel alloc] init];
            model.title = [NSString stringWithFormat:@"title index %d", i];
            MVVMTableCell *cellVM = [[MVVMTableCell alloc] initWith:model];
            [mutArray addObject:cellVM];
        }
    }
    
    MVVMListTableCellModel *listVM = [[MVVMListTableCellModel alloc] init];
    listVM.dataArray = mutArray;
    
    if (success) {
        success(listVM);
    }
}

- (void)updateViewModelByIndex:(int)idx {
    NSMutableArray *nowDataArray = [self.dataArray mutableCopy];
    MVVMTableCell *cellVM = (MVVMTableCell *)nowDataArray[idx];
    cellVM.title = @"";
}

@end
