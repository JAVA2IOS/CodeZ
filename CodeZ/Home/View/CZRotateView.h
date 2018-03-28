//
//  CZRotateView.h
//  CodeZ
//
//  Created by Primb_yqx on 17/1/9.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touchedHandler)(BOOL);

/**
 旋转动效
 */
@interface CZRotateView : UIView

/**
 点击响应方法

 @param block 响应回调方法
 */
- (void) touchedEndedMethod:(touchedHandler)block;

@end
