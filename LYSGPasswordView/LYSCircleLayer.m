//
//  LYSCircleLayer.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/26.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSCircleLayer.h"

@implementation LYSCircleLayer
- (void)drawInContext:(CGContextRef)ctx
{
    CGRect pointFrame = self.bounds;
    
    UIBezierPath *outerPointPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.outerCircleLineWidth, self.outerCircleLineWidth, pointFrame.size.width - 2 * self.outerCircleLineWidth, pointFrame.size.height - 2 * self.outerCircleLineWidth) cornerRadius:pointFrame.size.height / 2.0];
    
    UIBezierPath *innerPointPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(pointFrame.size.width /2.0 - self.innerCircleRadius, pointFrame.size.height / 2.0 - self.innerCircleRadius, 2 * self.innerCircleRadius, 2 * self.innerCircleRadius) cornerRadius:self.innerCircleRadius];
    
    if (self.highlighted)
    {
        CGContextSetFillColorWithColor(ctx, self.outerCircleHighlightColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.outerCircleLineHighlightColor.CGColor);
        CGContextSetLineWidth(ctx, self.outerCircleLineWidth);
        CGContextAddPath(ctx, outerPointPath.CGPath);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        
        CGContextSetFillColorWithColor(ctx, self.innerCircleHighlightColor.CGColor);
        CGContextAddPath(ctx, innerPointPath.CGPath);
        CGContextDrawPath(ctx, kCGPathFill);
    }
    else{
        CGContextSetFillColorWithColor(ctx, self.outerCircleColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.outerCircleLineColor.CGColor);
        CGContextSetLineWidth(ctx, self.outerCircleLineWidth);
        CGContextAddPath(ctx, outerPointPath.CGPath);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        
        CGContextSetFillColorWithColor(ctx, self.innerCircleColor.CGColor);
        CGContextAddPath(ctx, innerPointPath.CGPath);
        CGContextDrawPath(ctx, kCGPathFill);
    }
}
@end
