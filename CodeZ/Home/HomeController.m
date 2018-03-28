//
//  HomeController.m
//  CodeZ
//
//  Created by Primb_yqx on 16/12/15.
//  Copyright © 2016年 HQExample. All rights reserved.
//

#import "HomeController.h"
#import "RotateViewController.h"
#import "CustomTableViewController.h"
#import "CZUIAnimateViewController.h"
#import "WebOCViewController.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray * controllerNames;
    NSArray * controllerTitles;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    controllerNames = @[@"RotateViewController",@"CustomTableViewController",@"CZUIAnimateViewController",@"WebOCViewController",@"MVCViewController"];
    controllerTitles = @[@"旋转视图",@"自定义tableView",@"UI动画特效",@"原生UIWebView加载h5", @"mvc模式测试"];
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CodeZBaseController * vc = [[NSClassFromString([controllerNames objectAtIndex:indexPath.row]) alloc] init];
    vc.title = [controllerTitles objectAtIndex:indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [controllerNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    NSString * cellId = @"cellId";
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = [controllerTitles objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //设置cell右边箭头类型
    return cell;
}

@end
