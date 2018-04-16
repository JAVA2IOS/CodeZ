//
//  MVCModel.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/3/28.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^handlerBlock)(int number, NSString *str);

@interface MVCModel : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) handlerBlock copyBlock;
@property (nonatomic, strong) handlerBlock strongBlock;
@end
