//
//  MVVMTableCell.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "ViewModel.h"

@interface MVVMTableCell : ViewModel
- (void)getModelData:(void(^)(id data))succcess;
@end
