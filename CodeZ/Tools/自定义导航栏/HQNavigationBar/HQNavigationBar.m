//
//  HQNavigationBar.m
//  CodeZ
//
//  Created by Primb_yqx on 17/3/1.
//  Copyright © 2017年 HQExample. All rights reserved.
//

#import "HQNavigationBar.h"

@interface HQNavigationBar() <HQNavigationBarItemDelegate> {
    HQNavigationConfigureBarItemBlock configure;
    UIScrollView *mainScro;
}
@end

@implementation HQNavigationBar
#pragma mark - override fun
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self navb_addMainScrollView];
}


#pragma mark - UI
- (void)navb_addMainScrollView {
    mainScro = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:mainScro];
    mainScro.showsHorizontalScrollIndicator = NO;
    mainScro.bounces = NO;
    [self navb_configureBarItem];
}

- (void)navb_configureBarItem {
    __block float horizontalGap = 5;
    __block float bartItemOrginWidth = (mainScro.frame.size.width - horizontalGap * 3) / 4;
    __block float bartSizeWidth = 0;
    
    [_itemDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CodeZBundleData *bundle = [[CodeZBundleData alloc] init];
        float barItemWidth = [self navb_getStringWidthWithString:bundle.displayText
                                                         andFont:[UIFont systemFontOfSize:14]
                                                       andOffset:10];
        float rectX = bartSizeWidth;
        CGRect rect = CGRectMake(rectX, 0, MAX(barItemWidth, bartItemOrginWidth), mainScro.frame.size.height);
        HQNavigationBarItem *barItem = [[HQNavigationBarItem alloc] initWithFrame:rect];
        barItem.backgroundColor = [UIColor clearColor];
        if (configure) {
            barItem = configure(obj,rect);
        }
        barItem.selected = _startIndex == idx ? YES : NO;
        barItem.bundleData = obj;
        barItem.delegate = self;
        barItem.tag = idx;
        [mainScro addSubview:barItem];
        bartSizeWidth += MAX(barItemWidth, bartItemOrginWidth) + horizontalGap;
        
        mainScro.contentSize = CGSizeMake(bartSizeWidth - horizontalGap, mainScro.frame.size.height);
    }];
}



#pragma mark - custom methods
- (void)configureBarItem:(HQNavigationConfigureBarItemBlock)configureBlock {
    configure = configureBlock;
}

- (float)navb_getStringWidthWithString:(NSString *) string andFont:(UIFont*)font andOffset:(float) offset{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    //计算字符像素长度
    CGSize stringSize = [string boundingRectWithSize:CGSizeMake(1207, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return stringSize.width + offset;
}

/**
 刷新选项数据
 */
- (void)navb_refreshNavigationBarItem {
    [mainScro.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[HQNavigationBarItem class]]) {
            HQNavigationBarItem *barItem = (HQNavigationBarItem *)obj;
            barItem.selected = NO;
        }
    }];
}

/**
 调整导航栏滚动内容位置

 @param barItem 选中项
 */
- (void)navb_adjustNavigationBarItem:(HQNavigationBarItem *)barItem {
    if (mainScro.frame.size.width > mainScro.contentSize.width) {
        return;
    }
    if ([barItem isKindOfClass:[HQNavigationBarItem class]] && barItem.tag == 0) {
        [mainScro setContentOffset:CGPointMake(0, mainScro.contentOffset.y) animated:YES];
        return;
    }
    if ([barItem isKindOfClass:[HQNavigationBarItem class]] && barItem.tag == ([_itemDatas count] - 1)) {
        [mainScro setContentOffset:CGPointMake(mainScro.contentSize.width - mainScro.frame.size.width, mainScro.contentOffset.y) animated:YES];
        return;
    }
    
    float horizontalSpacing = 5;
    //执行下列方法之前已经排除按钮为首、末位按钮
    for (id obj in mainScro.subviews) {
        if ([obj isKindOfClass:[HQNavigationBarItem class]]) {
            HQNavigationBarItem *navBarItem = (HQNavigationBarItem *)obj;
            //判断前一个按钮是否在可视范围
            if (navBarItem.tag == (barItem.tag - 1)) {
                if ((navBarItem.frame.origin.x) < mainScro.contentOffset.x) {
                    [mainScro setContentOffset:CGPointMake(navBarItem.frame.origin.x - horizontalSpacing, mainScro.contentOffset.y) animated:YES];
                }
            }
            //判断后一个按钮是否在可视范围
            if (navBarItem.tag == (barItem.tag + 1)) {
                if ((navBarItem.frame.origin.x + navBarItem.frame.size.width - mainScro.contentOffset.x) > mainScro.frame.size.width) {
                    [mainScro setContentOffset:CGPointMake(navBarItem.frame.origin.x + navBarItem.frame.size.width + horizontalSpacing - mainScro.frame.size.width, mainScro.contentOffset.y) animated:YES];
                }
            }
        }
    }
}


#pragma mark - HQNavigationBarItemDelegate method
- (void)HQNavigationBarItem:(HQNavigationBarItem *)barItem bundleData:(CodeZBundleData *)obj selected:(BOOL)selected {
    [self navb_refreshNavigationBarItem];
    barItem.selected = YES;
    [self navb_adjustNavigationBarItem:barItem];
    
    if ([self.delegate respondsToSelector:@selector(HQNavigationBart:Data:index:selected:)]) {
        [self.delegate HQNavigationBart:barItem Data:obj index:barItem.tag selected:selected];
    }
}


#pragma mark - setters
- (void)setItemDatas:(NSMutableArray *)itemDatas {
    _itemDatas = itemDatas;
    [self setNeedsDisplay];
}

- (void)setStartIndex:(NSInteger)startIndex {
    _startIndex = startIndex;
    [self setNeedsDisplay];
}
@end
