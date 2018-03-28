//
//  CZRotateView.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/9.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CZRotateView.h"
@interface CZRotateView() {
    UILabel *topLabel;
    UILabel *middleLabel;
    UILabel *bottomLabel;
    BOOL isOpen;    //是否展开
    touchedHandler touchedBlock;
    float verticalGap;  //垂直间距
}
@end

@implementation CZRotateView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self cz_rotateView];
    return self;
}

/**
 初始化视图
 */
- (void)cz_rotateView {
    topLabel = [[UILabel alloc] init];
    middleLabel = [[UILabel alloc] init];
    bottomLabel = [[UILabel alloc] init];
    
    isOpen = NO;
    verticalGap = 8;
    float rectX = 10;
    float rectH = 5;
    float rectW = SELFWIDTH - rectX * 2;
    
    topLabel.frame = CGRectMake(0, 0, rectW, rectH);
    topLabel.backgroundColor = UIColorFromRGB(0x999999);
    topLabel.layer.masksToBounds = YES;
    topLabel.layer.cornerRadius = rectH / 2;
//    topLabel.layer.shouldRasterize = YES;   //抗锯齿效果
    topLabel.layer.allowsEdgeAntialiasing = YES;
    middleLabel.frame = CGRectMake(0, 0, rectW, rectH);
    middleLabel.backgroundColor = UIColorFromRGB(0x999999);
    middleLabel.layer.masksToBounds = YES;
    middleLabel.layer.allowsEdgeAntialiasing = YES;
    //    middleLabel.layer.shouldRasterize = YES;
    middleLabel.layer.cornerRadius = rectH / 2;
    bottomLabel.frame = CGRectMake(0, 0, rectW, rectH);
    bottomLabel.backgroundColor = UIColorFromRGB(0x999999);
    bottomLabel.layer.masksToBounds = YES;
    bottomLabel.layer.cornerRadius = rectH / 2;
    bottomLabel.layer.shouldRasterize = YES;
//    bottomLabel.layer.allowsEdgeAntialiasing = YES;
    
    topLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 - verticalGap);
    bottomLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + verticalGap);
    middleLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    [self addSubview:topLabel];
    [self addSubview:middleLabel];
    [self addSubview:bottomLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cz_handler:)];
    [self addGestureRecognizer:tap];
}

/**
 手势方法

 @param tap 响应手势
 */
- (void)cz_handler:(UITapGestureRecognizer *)tap {
    if (isOpen) {
        [self cz_closeMenu:tap];
    }else{
        [self cz_openMenu:tap];
    }
    isOpen = !isOpen;
    if ([self respondsToSelector:@selector(touchedEndedMethod:)]) {
        touchedBlock(isOpen);
    }
}

/**
 恢复菜单

 @param tap 响应手势
 */
- (void)cz_closeMenu:(UITapGestureRecognizer *)tap {
    tap.enabled = NO;
    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         topLabel.transform = CGAffineTransformMakeRotation(0);
                         bottomLabel.transform = CGAffineTransformMakeRotation(0);
                         middleLabel.transform = CGAffineTransformMakeScale(1, 1);
                         
                         topLabel.center = CGPointMake(topLabel.center.x, topLabel.center.y - verticalGap);
                         bottomLabel.center = CGPointMake(bottomLabel.center.x, bottomLabel.center.y + verticalGap);
                     }
                     completion:^(BOOL finished) {
                         //响应方法之时禁用手势，结束后手势生效
                         tap.enabled = YES;
                     }];
}

/**
 打开菜单

 @param tap 响应手势
 */
- (void)cz_openMenu:(UITapGestureRecognizer *)tap {
    tap.enabled = NO;
    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         topLabel.transform = CGAffineTransformMakeRotation(M_PI / 4);
                         bottomLabel.transform = CGAffineTransformMakeRotation(-M_PI / 4);
                         middleLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);

                         topLabel.center = CGPointMake(topLabel.center.x, self.bounds.size.height / 2);
                         bottomLabel.center = CGPointMake(bottomLabel.center.x, self.bounds.size.height / 2);
                     }
                     completion:^(BOOL finished) {
                         tap.enabled = YES;
                     }];
}

/**
 设置block变量

 @param block 响应方法
 */
- (void)touchedEndedMethod:(touchedHandler)block {
    touchedBlock = block;
}
@end
