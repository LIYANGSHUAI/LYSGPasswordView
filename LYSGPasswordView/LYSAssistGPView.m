//
//  LYSAssistGPView.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSAssistGPView.h"
#import "LYSCircleLayer.h"
#import "LYSLineLayer.h"

#define LazyLoadMutableArray(A) \
- (NSMutableArray *)A{\
if (!_##A) {\
_##A = [NSMutableArray array];\
}\
return _##A;\
}

#define PINGFANG(A) ((A) * (A))

@interface LYSAssistGPView ()

@property (nonatomic,strong)LYSLineLayer *lineLayer;
@property (nonatomic,strong)NSMutableArray *pointAry;
@property (nonatomic,strong)NSMutableArray *linePointAry;
@property (nonatomic,strong)LYSGPasswordStyle *style;

@end

@implementation LYSAssistGPView

LazyLoadMutableArray(pointAry);
LazyLoadMutableArray(linePointAry);

- (id)initWithFrame:(CGRect)frame style:(LYSGPasswordStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        
        LYSCircleLayer *lyPoint;
        
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                lyPoint = [LYSCircleLayer layer];
                
                lyPoint.outerCircleHighlightColor = self.style.outerCircleHighlightColor;
                lyPoint.outerCircleColor = self.style.outerCircleColor;
                lyPoint.outerCircleLineColor = self.style.outerCircleLineColor;
                lyPoint.outerCircleLineHighlightColor = self.style.outerCircleLineHighlightColor;
                lyPoint.outerCircleLineWidth = self.style.outerCircleLineWidth;
                
                lyPoint.innerCircleColor = self.style.innerCircleColor;
                lyPoint.innerCircleHighlightColor = self.style.innerCircleHighlightColor;
                lyPoint.innerCircleRadius = self.style.innerCircleRadius;
                
                lyPoint.highlighted = NO;
                [lyPoint setNeedsDisplay];
                
                lyPoint.bounds = CGRectMake(0, 0, self.style.outerCircleRadius * 2, self.style.outerCircleRadius * 2);
                
                CGFloat margin = (self.style.outerCircleRadius * 2 + self.style.outerCicrcleBetweenMargin);
                NSArray *jAry = @[@((self.frame.size.width * 0.5) - margin),@(self.frame.size.width * 0.5),@((self.frame.size.width * 0.5) + margin)];
                NSArray *iAry = @[@((self.frame.size.height * 0.5) - margin),@(self.frame.size.height * 0.5),@((self.frame.size.height * 0.5) + margin)];
                
                lyPoint.position = CGPointMake([jAry[j] floatValue], [iAry[i] floatValue]);
                
                [self.pointAry addObject:lyPoint];
                [self.layer addSublayer:lyPoint];
                
            }
        }
        
        _lineLayer = [LYSLineLayer layer];
        _lineLayer.lineWidth = self.style.lineWidth;
        _lineLayer.lineColor = self.style.lineColor;
        [_lineLayer setNeedsDisplay];
        
        _lineLayer.frame = self.bounds;
        [self.layer addSublayer:_lineLayer];
        
    }
    return self;
}

- (void)ly_updatePassword:(NSArray *)passwordAry
{
    [self.linePointAry removeAllObjects];
    if (passwordAry.count)
    {
        for (int i = 0; i < passwordAry.count; i++)
        {
            LYSCircleLayer *lyPoint = [_pointAry objectAtIndex:[passwordAry[i] integerValue]];
            lyPoint.highlighted = YES;
            [lyPoint setNeedsDisplay];
            [self.linePointAry addObject:[NSValue valueWithCGPoint:lyPoint.position]];
        }
        _lineLayer.points = self.linePointAry;
        _lineLayer.nowPoint = [[self.linePointAry lastObject] CGPointValue];
        [_lineLayer setNeedsDisplay];
    }else
    {
        for (LYSCircleLayer *lyPoint in _pointAry)
        {
            lyPoint.highlighted = NO;
            [lyPoint setNeedsDisplay];
        }
        _lineLayer.points = @[];
        _lineLayer.nowPoint = CGPointZero;
        [_lineLayer setNeedsDisplay];
    }
}

@end

