//
//  DynamicHeightTableViewCell.h
//  CodeZ
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapHandleRect)(BOOL, int);

/**
 动态改变高度tableCell
 */
@interface DynamicHeightTableViewCell : UITableViewCell

@property (nonatomic, assign, getter=isTouched) BOOL touched;

@property (nonatomic, assign) float cellHeight;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *autherName;

@property (nonatomic, copy) NSString *detailContents;

- (void)deployView;

- (void)closeView;

- (void)deployOrContract:(tapHandleRect)handleBlock;

@end
