//
//  LYSAssistGPView.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/27.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSAssistGPView.h"
#import "LYSLineLayer.h"
#import "LYSCircleLayer.h"
@implementation LYSAssistGPView
{
    NSMutableArray *_pointAry;
    LYSLineLayer *_lineLayer;
}
- (void)customDefaultValue{
    
    self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 内边距
    self.outerCicrcleBetweenMargin = 10.0;//间隔
    self.outerCircleRadius = (self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.outerCicrcleBetweenMargin * 2) / 6.0;//圆半径
    self.outerCircleLineWidth = 1.0;//圆边框宽
    self.innerCircleRadius = 3.0;//小圆半径
    
    self.lineWidth = 2.0;//线宽
    
    self.outerCircleColor = [UIColor clearColor];//圆颜色
    self.outerCircleHighlightColor = [UIColor clearColor];//圆高亮颜色
    
    self.outerCircleLineColor = [UIColor grayColor];//圆框颜色
    self.outerCircleLineHighlightColor = [UIColor redColor];//圆框高亮色
    
    self.innerCircleColor = [UIColor clearColor];//小圆颜色
    self.innerCircleHighlightColor = [UIColor redColor];//小圆高亮色
    
    self.lineColor = [UIColor redColor];//小圆高亮色
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置默认值
        [self customDefaultValue];
        
    }
    return self;
}
- (void)refresh{
    // 设置子视图
    [self customSubViews];
}
// 设置子视图
- (void)customSubViews{
    _pointAry = [NSMutableArray array];
    LYSCircleLayer *lyPoint;
    
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            lyPoint = [LYSCircleLayer layer];
            
            lyPoint.outerCircleHighlightColor = self.outerCircleHighlightColor;
            lyPoint.outerCircleColor = self.outerCircleColor;
            lyPoint.outerCircleLineColor = self.outerCircleLineColor;
            lyPoint.outerCircleLineHighlightColor = self.outerCircleLineHighlightColor;
            lyPoint.outerCircleLineWidth = self.outerCircleLineWidth;
            
            lyPoint.innerCircleColor = self.innerCircleColor;
            lyPoint.innerCircleHighlightColor = self.innerCircleHighlightColor;
            lyPoint.innerCircleRadius = self.innerCircleRadius;
            
            lyPoint.highlighted = NO;
            [_pointAry addObject:lyPoint];
            [self.layer addSublayer:lyPoint];
            [lyPoint setNeedsDisplay];
        }
    }
    
    _lineLayer = [LYSLineLayer layer];
    _lineLayer.lineWidth = self.lineWidth;
    _lineLayer.lineColor = self.lineColor;
    [self.layer addSublayer:_lineLayer];
    
    // 布局
    [self setLayerFrames];
}
// 布局
- (void)setLayerFrames
{
    LYSCircleLayer *lyPoint;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            CGFloat x = self.edgeInsets.left + j * (self.outerCircleRadius * 2 + self.outerCicrcleBetweenMargin);
            CGFloat y = self.edgeInsets.top + i * (self.outerCircleRadius * 2 + self.outerCicrcleBetweenMargin);
            lyPoint = [_pointAry objectAtIndex:i*3+j];
            lyPoint.frame = CGRectMake(x, y, self.outerCircleRadius * 2, self.outerCircleRadius * 2);
            [lyPoint setNeedsDisplay];
        }
    }
    
    _lineLayer.frame = self.bounds;
    [_lineLayer setNeedsDisplay];
}
// 更新值
- (void)lyUpdatePassword:(NSArray *)passwordId{
    if (passwordId.count) {
        NSMutableArray *pointCenterAry = [NSMutableArray array];
        for (int i = 0; i < passwordId.count; i++) {
            LYSCircleLayer *lyPoint = [_pointAry objectAtIndex:[passwordId[i] integerValue]];
            lyPoint.highlighted = YES;
            [lyPoint setNeedsDisplay];
            CGPoint lyPointCenter = CGPointMake(lyPoint.frame.origin.x + lyPoint.frame.size.width / 2.0, lyPoint.frame.origin.y + lyPoint.frame.size.height / 2.0);
            [pointCenterAry addObject:[NSValue valueWithCGPoint:lyPointCenter]];
        }
        _lineLayer.points = pointCenterAry;
        _lineLayer.nowPoint = [[pointCenterAry lastObject] CGPointValue];
        [_lineLayer setNeedsDisplay];
    }else{
        for (LYSCircleLayer *lyPoint in _pointAry) {
            lyPoint.highlighted = NO;
            [lyPoint setNeedsDisplay];
        }
        _lineLayer.points = @[];
        _lineLayer.nowPoint = CGPointZero;
        [_lineLayer setNeedsDisplay];
    }
}

@end
