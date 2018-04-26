//
//  CZRotationMenu.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/10.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "CZRotationMenu.h"

#define TAG_ITEM 300

/**
 滑动方向枚举

 - SlidingDirectionClockWise: 顺时针方向
 - SlidingDirectionAntiClockWise: 逆时针方向
 */
typedef NS_ENUM(NSInteger, SlidingDirection){
    SlidingDirectionClockWise = 0,
    SlidingDirectionAntiClockWise
};

@interface CZRotationMenu() {
    float initRotateAngle;  //初始旋转角度
    menuSelected selectedBlock;
    NSTimeInterval startTime;   //起始时间
    NSTimeInterval processTime; //滑动消耗时间
    SlidingDirection slideDir;  //滑动方向
    float movedAngle;   //滑动的角度
    float initVelocity; //初速度
    float accelerationVelocity; //加速度
    float currentVelocity;  //当前速度
    NSTimer *rotationTimer;   //旋转动画定时器
}
@end

@implementation CZRotationMenu
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _buttonStyle = CZButtonStyleDefault;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self cz_addButtonLists];
}


#pragma mark - views
/**
 添加按钮视图
 */
- (void)cz_addButtonLists {
    float btnW = MIN(SELFWIDTH, SELFHEIGHT) / 5;    //按钮尺寸
    float radius = btnW * 2;    //中点半径
    float perAngle = M_PI * 2 / MAX([_titles count], [_images count]);  //平均角度
    float initAngle = - M_PI_2; //初始角度
    
    initRotateAngle = 0;    //初始旋转角度
    for (int i = 0; i < MAX([_titles count], [_images count]); i ++) {
        float btnCenterX = radius * cosf(initAngle + perAngle * i) + SELFWIDTH / 2;
        float btnCenterY = radius * sinf(initAngle + perAngle * i) + SELFHEIGHT / 2;
        
        UIView *item_view = [[UIView alloc] init];
        CGRect viewFrame = CGRectMake(0, 0, btnW, btnW / 2 * 3);
        
        switch (_buttonStyle) {
            case CZButtonStyleDefault:
                break;
                
            case CZButtonStyleOnlyImage:
                viewFrame = CGRectMake(0, 0, btnW, btnW);
                break;
                
            case CZButtonStyleOnlyText:
                viewFrame = CGRectMake(0, 0, btnW, btnW);
                break;
                
            default:
                break;
        }
        
        item_view = [self cz_updateItemView:viewFrame
                                      title:_titles[i]
                                      bgImg:_images[i]
                                      style:_buttonStyle];
        
        [self addSubview:item_view];
        item_view.center = CGPointMake(btnCenterX, btnCenterY);
        item_view.layer.shadowColor = UIColorFromRGB(0x999999).CGColor;
        item_view.layer.shadowOpacity = 0.5;
        item_view.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        item_view.tag = TAG_ITEM + i;
    }
}


/**
 添加信息视图

 @param frame 视图尺寸
 @param title 视图标题
 @param img 视图背景图片
 @return 视图
 */
- (UIView *)cz_updateItemView:(CGRect) frame title:(NSString *)title bgImg:(NSString *)img style:(CZButtonStyle)style {
    UIView *bg = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bg.frame.size.width, bg.frame.size.width)];
    imgView.image = [UIImage imageNamed:img];
    [bg addSubview:imgView];
    
    UILabel *text_label = [[UILabel alloc] initWithFrame:CGRectMake(0, bg.frame.size.width, bg.frame.size.width, bg.frame.size.height - bg.frame.size.width)];
    text_label.textAlignment = NSTextAlignmentCenter;
    text_label.font = [UIFont systemFontOfSize:12];
    text_label.textColor = UIColorFromRGB(0x999999);
    text_label.text = title;
    [bg addSubview:text_label];
    
    switch (style) {
        case CZButtonStyleDefault:
            break;
            
        case CZButtonStyleOnlyImage:
            [text_label removeFromSuperview];
            break;
            
        case CZButtonStyleOnlyText:
            [imgView removeFromSuperview];
            text_label.frame = bg.bounds;
            break;
            
        default:
            break;
    }
    
    [bg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)]];
    
    return bg;
}


#pragma mark - methods
/**
 按钮触发事件

 @param tap 点击手势
 */
- (void)itemTap:(UITapGestureRecognizer *)tap {
    int index = (int)(tap.view.tag - TAG_ITEM);
    [self endedAnimation];
    if ([self respondsToSelector:@selector(menuResponsedMethod:)]) {
        selectedBlock(index);
    }
}

/**
 设置block回调方法

 @param menuSelected 回调方法
 */
- (void)menuResponsedMethod:(menuSelected)menuSelected {
    selectedBlock = menuSelected;
}

/**
 关闭菜单方法
 */
- (void)closeAnimatedMenu {
    [self endedAnimation];
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 0;
                         CGAffineTransform t1 = CGAffineTransformMakeScale(0.1, 0.1);
                         CGAffineTransform t2 = CGAffineTransformMakeRotation(initRotateAngle);
                         self.transform = CGAffineTransformConcat(t1, t2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

/**
 打开菜单方法
 */
- (void)openAnimatedMenu {
    CGAffineTransform t1 = CGAffineTransformMakeScale(0.1, 0.1);
    CGAffineTransform t2 = CGAffineTransformMakeRotation(initRotateAngle);
    self.transform = CGAffineTransformConcat(t1, t2);
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGAffineTransform t1 = CGAffineTransformMakeScale(1, 1);
                         CGAffineTransform t2 = CGAffineTransformMakeRotation(initRotateAngle);
                         self.transform = CGAffineTransformConcat(t1, t2);
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


#pragma mark - setters
- (void)setImages:(NSArray *)images {
    _images = images;
    [self setNeedsDisplay];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self setNeedsDisplay];
}

- (void)setButtonStyle:(CZButtonStyle)buttonStyle {
    _buttonStyle = buttonStyle;
    [self setNeedsDisplay];
}


#pragma mark - 动画效果

/**
 开始计时，并且设置参数

 @param direction 滑动方向
 */
- (void)startMoveElementsValWithRotationDirection:(SlidingDirection)direction {
    startTime = [NSDate timeIntervalSinceReferenceDate];
    movedAngle = 0;
    slideDir = direction;
    initVelocity = 0;
    accelerationVelocity = 0;
    processTime = 0;
}

/**
 更新旋转参数
 */
- (void)updateRotationProperties {
    processTime = [NSDate timeIntervalSinceReferenceDate] - startTime;
    if (processTime != 0) {
        initVelocity = movedAngle * 2 / processTime;
        accelerationVelocity = movedAngle * 2 / powf(processTime * 10, 2);
        initVelocity = accelerationVelocity > 2 ? initVelocity : 0;
        initVelocity = initVelocity > 20 ? 20 : initVelocity;
        accelerationVelocity = accelerationVelocity > 15 ? 15 : accelerationVelocity;
//        NSLog(@"time:%f, initV:%f, accelV:%f, angle:%f", processTime, initVelocity, accelerationVelocity,movedAngle);
        startTime = [NSDate timeIntervalSinceReferenceDate];
        movedAngle = 0;
    }
}

/**
 开始动画
 */
- (void)startAnimation {
    if (rotationTimer == nil) {
        startTime = 0;
        static float timeInterval = 1.0/60.0;
        rotationTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateTimerFired:) userInfo:nil repeats:YES];
    }
}

/**
 结束动画
 */
- (void)endedAnimation {
    [rotationTimer invalidate];
    rotationTimer = nil;
    startTime = 0;
    initRotateAngle = initRotateAngle - (int)(initRotateAngle / (M_PI * 2)) * M_PI * 2;
    self.transform = CGAffineTransformMakeRotation(initRotateAngle);
}

/**
 调整文本水平方向
 */
- (void)adjustItemHorizaontalContent {
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView *v = (UIView *)obj;
            v.transform = CGAffineTransformMakeRotation(- initRotateAngle);
        }
    }
}

/**
 更新旋转视图

 @param timer 定时器
 */
- (void)updateTimerFired:(NSTimer *)timer {
    //当前时间
    startTime += timer.timeInterval;
    //当前速度
    currentVelocity = initVelocity - accelerationVelocity * startTime;
    //相比前一次时间滚动距离
    float rotationDistance = initVelocity * startTime - accelerationVelocity * powf(startTime, 2) / 2 - initVelocity * (startTime - timer.timeInterval) + accelerationVelocity * powf(startTime - timer.timeInterval, 2) / 2;
    initRotateAngle += slideDir == SlidingDirectionClockWise ? rotationDistance : - rotationDistance;
    self.transform = CGAffineTransformMakeRotation(initRotateAngle);
    //调整按钮
    [self adjustItemHorizaontalContent];
    
    //当速度为0时，停止滚动,置空定时器
    if (currentVelocity <= 0) {
        [self endedAnimation];
    }
}


#pragma mark - touch事件
/*
 1.接触开始后，初始化参数
 2.滑动期间更新计算滑动的方向、滑动的时间以及距离以及速度和加速度
 3.接触停止后，开始动画
 参数：startTime开始时间 processTime滑动花费时间 movedAngle滑动距离 slideDir旋转方向 initialVelocity初速度
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self startMoveElementsValWithRotationDirection:SlidingDirectionClockWise];
    [self endedAnimation];
    startTime = [NSDate timeIntervalSinceReferenceDate];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint nowP = [touch locationInView:self];
    CGPoint oldP = [touch previousLocationInView:self];
    CGPoint centerP = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    float limitRadius = MIN(SELFWIDTH, SELFHEIGHT) / 10;    //限制手势禁用半径范围
    float changedAngle = atanf((nowP.y - centerP.y) / (nowP.x - centerP.x)) - atanf((oldP.y - centerP.y) / (oldP.x - centerP.x));
    float touchLength = sqrtf(powf(nowP.y - centerP.y, 2) + powf(nowP.x - centerP.x, 2));
    if (limitRadius > touchLength) {
        [self startMoveElementsValWithRotationDirection:slideDir];
        return;
    }
    
    initRotateAngle += changedAngle;
    
    //判断此时滑动的方向,方向如果改变则重新设置参数
    SlidingDirection nowDir = changedAngle >= 0 ? SlidingDirectionClockWise : SlidingDirectionAntiClockWise;
    slideDir == nowDir ? : [self startMoveElementsValWithRotationDirection:nowDir];
    //计算滑动角度
    movedAngle += fabsf(changedAngle);
    movedAngle = movedAngle - (int)(movedAngle / (M_PI * 2)) * M_PI * 2;
    //计算前一时间到本次时间滑动的距离、加速度、初速度
    [self updateRotationProperties];
    
    initRotateAngle = initRotateAngle - (int)(initRotateAngle / (M_PI * 2)) * M_PI * 2;
    self.transform = CGAffineTransformMakeRotation(initRotateAngle);
    
    //调整按钮
    [self adjustItemHorizaontalContent];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self startAnimation];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self startMoveElementsValWithRotationDirection:slideDir];
    [self endedAnimation];
}
@end
