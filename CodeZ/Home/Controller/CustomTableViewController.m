//
//  CustomTableViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CustomTableViewController.h"
#import "DynamicHeightTableViewCell.h"

@interface CustomTableViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray * tableDatas;
    int selectedIndex;
}

@end

@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backToViewController];
    
    tableDatas = @[@"视图一",@"视图二",@"视图三",@"视图四",@"视图五",@"视图六",@"视图七",@"视图八",@"视图九"];
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [UIView new];
    selectedIndex = -1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int lastIndex = selectedIndex;
    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
    }else{
        selectedIndex = (int) indexPath.row;
    }
    NSIndexPath *lastP = [NSIndexPath indexPathForRow:lastIndex inSection:0];
    NSIndexPath *reloadP = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [tableView reloadRowsAtIndexPaths:@[lastP, reloadP] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedIndex) {
        return 100;
    }else{
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicHeightTableViewCell * cell;
    NSString * cellId = @"cellId";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[DynamicHeightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.title = tableDatas[indexPath.row];
    cell.cellHeight = 50;
    cell.autherName = @"李白";
    if (selectedIndex == indexPath.row) {
        [cell deployView];
    }else{
        [cell closeView];
    }
    
    return cell;
}
@end
