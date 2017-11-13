//
//  LYSCircleLayer.h
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/26.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LYSCircleLayer : CALayer
@property (nonatomic,assign)CGFloat outerCircleLineWidth;
@property (nonatomic,strong)UIColor *outerCircleLineColor;
@property (nonatomic,strong)UIColor *outerCircleLineHighlightColor;
@property (nonatomic,strong)UIColor *outerCircleColor;
@property (nonatomic,strong)UIColor *outerCircleHighlightColor;

@property (nonatomic,assign)CGFloat innerCircleRadius;
@property (nonatomic,strong)UIColor *innerCircleColor;
@property (nonatomic,strong)UIColor *innerCircleHighlightColor;

@property (nonatomic) BOOL highlighted;
@end
