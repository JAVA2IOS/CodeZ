//
//  MVVMListTableCellModel.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "ViewModel.h"
#import "MVVMTableCell.h"

@interface MVVMListTableCellModel : ViewModel
@property (nonatomic, retain) NSArray *dataArray;
- (void)getJsonData:(void(^)(id json))success;

- (void)updateViewModelByIndex:(int)idx;
@end
