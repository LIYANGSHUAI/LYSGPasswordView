//
//  LYSAssistGPView.h
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSGPasswordStyle.h"

@interface LYSAssistGPView : UIView

- (id)initWithFrame:(CGRect)frame style:(LYSGPasswordStyle *)style;

- (void)ly_updatePassword:(NSArray *)passwordAry;

@end
