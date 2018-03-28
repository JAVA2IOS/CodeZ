//
//  DynamicHeightTableViewCell.m
//  CodeZ
//
//  Created by Primb_yqx on 17/1/3.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "DynamicHeightTableViewCell.h"

@interface DynamicHeightTableViewCell () {
    UILabel *titleLabel;
    UILabel *autherLabel;
    tapHandleRect tapHandle;
}
@end

@implementation DynamicHeightTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _touched = NO;
    }
    return self;
}

- (void)initLabelView {
    float titleGap = 10;
    float titleH = _cellHeight - 10 * 2;
    float titleX = 20;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleGap, self.frame.size.width / 3, titleH)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _title;
    [self.contentView addSubview:titleLabel];
    
    float autherX = titleLabel.frame.origin.x + titleLabel.frame.size.width + 20;
    float autherY = titleLabel.frame.origin.y + titleH / 3 * 2;
    float autherH = titleH / 3;
    float autherW = self.frame.size.width / 6;
    autherLabel = [[UILabel alloc] initWithFrame:CGRectMake(autherX, autherY, autherW, autherH)];
    autherLabel.font = [UIFont systemFontOfSize:12];
    autherLabel.text = _autherName;
    [self.contentView addSubview:autherLabel];
}

- (void)drawRect:(CGRect)rect {
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self initLabelView];
}


#pragma mark - setters
//- (void) setTitle:(NSString *)title {
//    _title = title;
//    [self setNeedsDisplay];
//}


#pragma mark - methods

/**
 展开视图
 */
- (void)deployView {
    self.contentView.backgroundColor = UIColorFromRGB(0x999999);
    float titleX = (self.contentView.frame.size.width - titleLabel.frame.size.width) / 2;
    NSLog(@"%f",titleLabel.frame.size.width);
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         autherLabel.frame = CGRectMake(titleX + titleLabel.frame.size.width + 20, autherLabel.frame.origin.y, autherLabel.frame.size.width, autherLabel.frame.size.height);
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.2
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         titleLabel.frame = CGRectMake(titleX, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleLabel.frame.size.height);
                     } completion:^(BOOL finished) {
                         NSLog(@"打开");
                     }];
}

/**
 收缩视图
 */
- (void)closeView {
    self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
    float titleX = 20;
    NSLog(@"%f",titleLabel.frame.origin.x);
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         titleLabel.frame = CGRectMake(titleX, titleLabel.frame.origin.y, titleLabel.frame.size.width, titleLabel.frame.size.height);
                     } completion:^(BOOL finished) {
                         NSLog(@"收缩");
                     }];
    
    [UIView animateWithDuration:0.5
                          delay:0.2
         usingSpringWithDamping:0.8
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         autherLabel.frame = CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + 20, autherLabel.frame.origin.y, autherLabel.frame.size.width, autherLabel.frame.size.height);
                     } completion:^(BOOL finished) {
                     }];
}

/**
 手势方法
 */
- (void)tapHandler {
    if ([self respondsToSelector:@selector(deployOrContract:)]) {
        if (_touched) {
            [self closeView];
        }else{
            [self deployView];
        }
        _touched = !_touched;
        tapHandle(_touched, (int)self.tag);
    }
}

- (void)deployOrContract:(tapHandleRect)handleBlock {
    tapHandle = handleBlock;
}
@end
