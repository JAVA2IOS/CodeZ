//
//  MVVMViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVCModel.h"
#import "tableViewDataSource.h"
#import "MVVMTableCell.h"
#import "MVVMListTableCellModel.h"

@interface MVVMViewController () {
    __block tableViewDataSource *source;
}

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MVVMListTableCellModel *listVm = [[MVVMListTableCellModel alloc] init];
    source = [[tableViewDataSource alloc] init];
    [listVm getJsonData:^(id json) {
        source.listVM = json;
    }];
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SELFVIEWWIDTH, SELFVIEWHEIGHT - 64)];
    mainTableView.delegate = source;
    mainTableView.dataSource = source;
    mainTableView.tableFooterView = [UIView new];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:mainTableView];
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
