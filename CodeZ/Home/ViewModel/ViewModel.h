//
//  ViewModel.h
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/18.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

- (void)viewToViewModelResponder:(void(^)(id responderObject))responder;

- (void)viewModelToViewResponder:(void(^)(id responderObject))responder;

@end
