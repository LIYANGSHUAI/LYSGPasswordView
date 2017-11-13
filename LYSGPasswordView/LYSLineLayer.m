//
//  LYSLineLayer.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/27.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSLineLayer.h"

@implementation LYSLineLayer
- (void)drawInContext:(CGContextRef)ctx
{
    if(_points.count<=0){return;}
    CGPoint pointCenter = [[_points objectAtIndex:0] CGPointValue];
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(ctx, self.lineColor.CGColor);
    CGContextMoveToPoint(ctx, pointCenter.x, pointCenter.y);
    
    for (int i = 1; i < [_points count]; i++)
    {
        pointCenter = [[_points objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(ctx, pointCenter.x, pointCenter.y);
    }
    
    pointCenter = self.nowPoint;
    CGContextAddLineToPoint(ctx, pointCenter.x, pointCenter.y);
    CGContextDrawPath(ctx, kCGPathStroke);
}
@end
