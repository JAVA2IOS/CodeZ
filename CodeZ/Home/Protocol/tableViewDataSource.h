//
//  tableViewDataSource.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMListTableCellModel.h"

@interface tableViewDataSource : NSObject<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) MVVMListTableCellModel *listVM;
@end