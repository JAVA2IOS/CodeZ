//
//  HQNavigationBar.h
//  CodeZ
//
//  Created by Primb_yqx on 17/3/1.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQNavigationBarItem.h"

@protocol HQNavigationBarDelegate <NSObject>

@optional
- (void)HQNavigationBart:(HQNavigationBarItem *)barItem Data:(id)obj index:(NSInteger)idx selected:(BOOL)selected;

@end

typedef HQNavigationBarItem*(^HQNavigationConfigureBarItemBlock)(id,CGRect);

@interface HQNavigationBar : UIView
/**
 起始位置
 */
@property (nonatomic, assign) NSInteger startIndex;
/**
 数据
 */
@property (nonatomic, retain) NSMutableArray *itemDatas;
@property (nonatomic) id<HQNavigationBarDelegate> delegate;

/**
 配置选项视图集合

 @param configureBlock 视图配置代码块
 */
- (void)configureBarItem:(HQNavigationConfigureBarItemBlock)configureBlock;

@end
