//
//  MVCView.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/3/28.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MVCView.h"
@interface MVCView()
@property (nonatomic, retain) UITextView *textView;
@end

@implementation MVCView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2)];
        [self addSubview:_textView];
        _textView.textColor = [UIColor redColor];
        _textView.font = [UIFont systemFontOfSize:10];
    }
    
    return self;
}

- (void)updateText:(NSString *)text {
    _textView.text = text;
}
@end
