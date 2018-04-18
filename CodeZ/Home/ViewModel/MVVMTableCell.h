//
//  MVVMTableCell.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "ViewModel.h"
#import "MVCModel.h"

@interface MVVMTableCell : ViewModel
@property (nonatomic, readonly, retain) MVCModel *model;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWith:(MVCModel *)model;
@end
