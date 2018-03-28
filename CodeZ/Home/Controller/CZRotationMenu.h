//
//  CZRotationMenu.h
//  CodeZ
//
//  Created by Primb_yqx on 17/1/10.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮样式

 - CZButtonStyleDefault: 默认文本 + 图片
 - CZButtonStyleOnlyImage: 只显示背景图
 - CZButtonStyleOnlyText: 只显示文本
 */
typedef NS_ENUM(NSInteger, CZButtonStyle) {
    CZButtonStyleDefault = 0,
    CZButtonStyleOnlyImage,
    CZButtonStyleOnlyText
};

/**
 按钮选择block方法
 */
typedef void(^menuSelected)(int);

/**
 圆形按钮
 */
@interface CZRotationMenu : UIView

/**
 按钮文本
 */
@property (nonatomic, strong) NSArray *titles;

/**
 按钮背景图片
 */
@property (nonatomic, strong) NSArray *images;

/**
 按钮风格
 */
@property (nonatomic, assign) CZButtonStyle buttonStyle;

/**
 关闭菜单
 */
- (void)closeAnimatedMenu;

/**
 打开菜单
 */
- (void)openAnimatedMenu;

/**
 按钮点击响应事件

 @param menuSelected 响应回调方法
 */
- (void)menuResponsedMethod:(menuSelected)menuSelected;

@end
