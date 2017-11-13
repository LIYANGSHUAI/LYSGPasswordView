//
//  LYSLineLayer.h
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/27.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LYSLineLayer : CALayer
@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)UIColor *lineColor;

@property (nonatomic,strong)NSArray *points; // 点数组
@property (nonatomic)CGPoint nowPoint;         // 当前点
@end
