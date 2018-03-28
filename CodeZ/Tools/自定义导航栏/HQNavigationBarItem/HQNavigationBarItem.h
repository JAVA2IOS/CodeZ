//
//  HQNavigationBarItem.h
//  CodeZ
//
//  Created by Primb_yqx on 17/3/1.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CodeZBundleData.h"
@class HQNavigationBarItem;

@protocol HQNavigationBarItemDelegate <NSObject>
@optional
- (void)HQNavigationBarItem:(HQNavigationBarItem *)barItem bundleData:(CodeZBundleData *)obj selected:(BOOL)selected;
@end

@interface HQNavigationBarItem : UIView
/**
 是否选中改项
 */
@property (nonatomic,getter=isSelected) BOOL selected;
/**
 绑定数据对象
 */
@property (nonatomic) CodeZBundleData *bundleData;
/**
 协议代理
 */
@property (nonatomic) id<HQNavigationBarItemDelegate> delegate;

- (void)reloadBarItemView;
@end
