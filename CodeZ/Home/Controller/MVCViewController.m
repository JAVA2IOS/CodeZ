//
//  MVCViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/3/28.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVCViewController.h"
#import "MVCModel.h"
#import "MVCView.h"
#import "OneModel.h"
#import "NSObject+CZKVO.h"

@interface MVCViewController () {
    MVCModel *model;
    MVCView *view;
}

@end

@implementation MVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    OneModel *one = [[OneModel alloc] init];
//    [one doRealThings];
//    model = [[MVCModel alloc] init];
//    [model cz_addObserver:self forKey:@"title" withBlock:^(id observerObject, NSString *observerKey, id oldValue, id newValue) {
//
//    }];
//    model.title = @"现在";
//    view = [[MVCView alloc] initWithFrame:CGRectMake(0, 40, 500, 500)];
//    [self.view addSubview:view];
//    [model addObserver:self
//            forKeyPath:@"title"
//               options:NSKeyValueObservingOptionNew
//               context:nil];
//    model.title = @"hello";
    
    // 冒泡排序
    
    /*
     NSMutableArray *numberArray = [[NSMutableArray alloc] initWithArray:@[@13, @54, @84, @12, @34, @89, @34]];
     // 相邻两个数进行比较，大的往后
     for (int i = 0; i < numberArray.count; i ++) {
     // 下面循环完毕后，可以得到一次最大的数
     for (int j = 0; j < numberArray.count - i - 1; j ++) {
     int firstNumber = [numberArray[j] intValue];
     int secondNumber = [numberArray[j + 1] intValue];
     if (firstNumber >= secondNumber) {
     int tmpNumber = firstNumber;
     firstNumber = secondNumber;
     secondNumber = tmpNumber;
     numberArray[j] = [NSNumber numberWithInt:firstNumber];
     numberArray[j + 1] = [NSNumber numberWithInt:secondNumber];
     }
     NSLog(@"%@",numberArray);
     }
     }
     */
    
    // 选择排序
    /*
     for (int i = 0; i < numberArray.count; i ++) {
     // 下面循环完毕后，可以得到一次最小的数,第一次循环就已经开始比较了
     for (int j = i + 1; j < numberArray.count; j ++) {
     int firstNumber = [numberArray[i] intValue];
     int secondNumber = [numberArray[j] intValue];
     if (firstNumber >= secondNumber) {
     int tmpNumber = firstNumber;
     firstNumber = secondNumber;
     secondNumber = tmpNumber;
     numberArray[i] = [NSNumber numberWithInt:firstNumber];
     numberArray[j] = [NSNumber numberWithInt:secondNumber];
     }
     NSLog(@"%@",numberArray);
     }
     }
     */
    /*
     void (^progressBlock)(int number, NSString *str) = ^(int number, NSString *str){
     number += 1;
     str = [str stringByAppendingString:@"  number :"];
     NSLog(@"%@%d", str, number);
     };
     model  = [[MVCModel alloc] init];
     model.copyBlock = progressBlock;
     model.strongBlock = progressBlock;
     __block int number = 4;
     __block NSString *str = @"hello";
     model.copyBlock(number, str);
     NSLog(@"copy after %@", str);
     
     model.strongBlock(number, str);
     
     NSLog(@"strong after %@", str);
     */
    
    __block int j = 0;
    
    spaceBlock empBlock = ^{
        j += 1;
        NSLog(@"this is block");
    };
    
    self.retainBlock = empBlock;
    self.retainBlock();
    NSLog(@"empBlock %@", empBlock);
    NSLog(@"%@,%d", self.retainBlock, j);
    self.strongBlock = empBlock;
     self.strongBlock();
    NSLog(@"%@,%ld", self.strongBlock, [empBlock retainCount]);
    empBlock = nil;
    NSLog(@"after nil  %@,%ld", self.strongBlock, [empBlock retainCount]);
    NSLog(@"after nil  %@,%d", self.retainBlock, j);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"title"]) {
//        [view updateText:change[NSKeyValueChangeNewKey]];
//    }
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
