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
#import "commonProtocol.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource> {
    NSDictionary *controlelrs;
}

@end

@implementation HomeController

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x0977ed);//顶部navigationbar的背景颜色
 UIColor * titleColor = [UIColor whiteColor];
 NSDictionary * titleAttributeDic = [NSDictionary dictionaryWithObject:titleColor forKey:NSForegroundColorAttributeName];
 self.navigationController.navigationBar.titleTextAttributes = titleAttributeDic;
 self.view.backgroundColor = [UIColor whiteColor];
 self.automaticallyAdjustsScrollViewInsets = NO;
 }
 - (UIStatusBarStyle)preferredStatusBarStyle {
 return UIStatusBarStyleLightContent;
 }
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    controlelrs = @{@"RotateViewController" : @"旋转视图",
                    @"CustomTableViewController" : @"自定义tableView",
                    @"CZUIAnimateViewController" : @"UI动画特效",
                    @"CoreDataViewController" : @"原生UIWebView加载h5",
                    @"MVVMViewController" : @"mvc模式测试",
                    @"ScoketViewController" : @"Scoket编程",
                    @"MapViewController" : @"MapKit使用",
                    @"RuntimeViewController" : @"Runtime"
                    };
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    // swift 版本验证
    if(@available(iOS 11.0, *)) {
        // 配置iOS适配问题，可能导致留白问题
        [table setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0); // 内边距
    }
    // 判断是否在并发队列，不能用来判断是否在主线程
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue()))) {
        
    }
    /*
     // collection
     UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
     
     UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
     [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionId"];
     collect.delegate = self;
     collect.dataSource = self;
     */
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CodeZBaseController * vc = [[NSClassFromString([[controlelrs allKeys] objectAtIndex:indexPath.row]) alloc] init];
    vc.title = controlelrs[[controlelrs allKeys][indexPath.row]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[controlelrs allKeys] count];
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
    cell.textLabel.text = controlelrs[[controlelrs allKeys][indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //设置cell右边箭头类型
//    cell.accessoryType = UITableViewCellAccessoryCheckmark; // 打钩
//    cell.accessoryType = UITableViewCellAccessoryDetailButton;  // 详细，一个按钮
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;    // 详细按钮 + 箭头
    return cell;
}

@end
