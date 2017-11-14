//
//  LYSGPasswordStyle.h
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSGPasswordStyle : NSObject

@property (nonatomic,assign)CGFloat outerCircleRadius;             // 外圆半径
@property (nonatomic,assign)CGFloat outerCircleLineWidth;          // 外圆线宽
@property (nonatomic,strong)UIColor *outerCircleLineColor;         // 外圆线颜色
@property (nonatomic,strong)UIColor *outerCircleLineHighlightColor;// 外圆线高亮颜色
@property (nonatomic,strong)UIColor *outerCircleColor;             // 外圆填充颜色
@property (nonatomic,strong)UIColor *outerCircleHighlightColor;    // 外圆高亮填充颜色

@property (nonatomic,assign)CGFloat innerCircleRadius;             // 内圆半径
@property (nonatomic,strong)UIColor *innerCircleColor;             // 内圆填充颜色
@property (nonatomic,strong)UIColor *innerCircleHighlightColor;    // 内圆填充高亮颜色

@property (nonatomic,assign)CGFloat outerCicrcleBetweenMargin;     // 外圆间距

@property (nonatomic,assign)CGFloat lineWidth;                     // 连线宽
@property (nonatomic,strong)UIColor *lineColor;                    // 连线颜色

@property (nonatomic,assign)NSInteger maxPasswordNum;              // 密码最低个数

@property (nonatomic,assign)BOOL crossDomainSelectEnable;          // 是否允许跨圆选择

// 手势密码默认样式
+ (instancetype)defaultStyle;
// 小手势密码展示样式
+ (instancetype)assisStyle;
@end
