//
//  LYSAssistGPView.h
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/27.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSAssistGPView : UIView
@property (nonatomic,assign)UIEdgeInsets edgeInsets;               // 外边距
@property (nonatomic,assign)CGFloat outerCicrcleBetweenMargin;     // 外圆与外圆之间的距离
@property (nonatomic,assign)CGFloat outerCircleRadius;             // 外圆半径

@property (nonatomic,assign)CGFloat outerCircleLineWidth;          // 外圆线宽
@property (nonatomic,strong)UIColor *outerCircleLineColor;         // 外圆线颜色
@property (nonatomic,strong)UIColor *outerCircleLineHighlightColor;// 外圆线高亮颜色
@property (nonatomic,strong)UIColor *outerCircleColor;             // 外圆填充颜色
@property (nonatomic,strong)UIColor *outerCircleHighlightColor;    // 外圆高亮填充颜色

@property (nonatomic,assign)CGFloat innerCircleRadius;             // 内圆半径
@property (nonatomic,strong)UIColor *innerCircleColor;             // 内圆填充颜色
@property (nonatomic,strong)UIColor *innerCircleHighlightColor;    // 内圆填充高亮颜色

@property (nonatomic,assign)CGFloat lineWidth;                     // 连线宽
@property (nonatomic,strong)UIColor *lineColor;                    // 连线颜色

// 更新值
- (void)lyUpdatePassword:(NSArray *)passwordId;

// 刷新
- (void)refresh;

@end
