//
//  LYSGPasswordStyle.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSGPasswordStyle.h"

@implementation LYSGPasswordStyle
+ (instancetype)defaultStyle{
    
    LYSGPasswordStyle *style = [[LYSGPasswordStyle alloc] init];
    
    style.outerCircleLineWidth = 2.0;//圆边框宽
    style.outerCircleRadius = 45;
    style.outerCircleColor = [UIColor clearColor];//圆颜色
    style.outerCircleHighlightColor = [UIColor clearColor];//圆高亮颜色
    style.outerCircleLineColor = [UIColor grayColor];//圆框颜色
    style.outerCircleLineHighlightColor = [UIColor redColor];//圆框高亮色
    
    style.innerCircleRadius = 20.0;//小圆半径
    style.innerCircleColor = [UIColor clearColor];//小圆颜色
    style.innerCircleHighlightColor = [UIColor redColor];//小圆高亮色
    
    style.outerCicrcleBetweenMargin = 25;
    style.maxPasswordNum = 4;//最短密码
    style.lineColor = [UIColor redColor];//连线颜色
    style.lineWidth = 10.0;//线宽
    style.crossDomainSelectEnable = NO;
    
    return style;
    
}
+ (instancetype)assisStyle{
    
    LYSGPasswordStyle *style = [[LYSGPasswordStyle alloc] init];
    
    style.outerCircleLineWidth = 1.0;//圆边框宽
    style.outerCircleRadius = 10;
    style.outerCircleColor = [UIColor clearColor];//圆颜色
    style.outerCircleHighlightColor = [UIColor clearColor];//圆高亮颜色
    style.outerCircleLineColor = [UIColor grayColor];//圆框颜色
    style.outerCircleLineHighlightColor = [UIColor redColor];//圆框高亮色
    
    style.innerCircleRadius = 3.0;//小圆半径
    style.innerCircleColor = [UIColor clearColor];//小圆颜色
    style.innerCircleHighlightColor = [UIColor redColor];//小圆高亮色
    
    style.outerCicrcleBetweenMargin = 5;
    style.maxPasswordNum = 4;//最短密码
    style.lineColor = [UIColor redColor];//连线颜色
    style.lineWidth = 1.0;//线宽
    style.crossDomainSelectEnable = NO;
    
    return style;
    
}
@end
