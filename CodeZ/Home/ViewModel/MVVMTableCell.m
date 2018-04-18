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
@interface MVVMTableCell()
@property (nonatomic, readwrite, retain) MVCModel *model;
@end

@implementation MVVMTableCell

- (instancetype)initWith:(MVCModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        self.title = _model.title;
    }
    return self;
}

- (MVCModel *)model:(MVCModel *)model {
    if (!_model) {
        _model = [[MVCModel alloc] init];
        _model = model;
    }
    return _model;
}

@end
