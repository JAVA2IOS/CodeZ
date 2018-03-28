//
//  HQNavigationBarItem.m
//  CodeZ
//
//  Created by Primb_yqx on 17/3/1.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "HQNavigationBarItem.h"

@implementation HQNavigationBarItem

#pragma mark - override fun
- (void)drawRect:(CGRect)rect {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self reloadBarItemView];
    [self navbi_configureGesstureRecognizer];
}

- (void)reloadBarItemView {
    [self navbi_configureTextView];
}

#pragma mark - UI
- (void)navbi_configureTextView {
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = _bundleData.displayText;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = _selected ? [UIColor redColor] : UIColorFromRGB(0x999999);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    label.userInteractionEnabled = NO;
}


#pragma mark - add UITapGestureRecognizer method
- (void)navbi_configureGesstureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navbi_tapHandler)];
    [self addGestureRecognizer:tap];
}

- (void)navbi_tapHandler {
    if ([self.delegate respondsToSelector:@selector(HQNavigationBarItem:bundleData:selected:)]) {
        [self.delegate HQNavigationBarItem:self bundleData:_bundleData selected:_selected];
    }
}

#pragma mark - setters
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)setBundleData:(CodeZBundleData *)bundleData {
    _bundleData = bundleData;
    [self setNeedsDisplay];
}
@end
