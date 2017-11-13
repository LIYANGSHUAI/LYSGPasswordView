
//
//  LYSGPasswordView.m
//  LYSGPasswordView
//
//  Created by HENAN on 17/5/10.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSGPasswordView.h"
#import "LYSCircleLayer.h"
#import "LYSLineLayer.h"

@interface LYSGPasswordView ()

@end
@implementation LYSGPasswordView
{
    LYSLineLayer *_lineLayer;
    NSMutableArray *_pointArr;
    NSMutableArray *_linePointArr;
    CGPoint _nowTouchPoint;
}
- (CGFloat)outerCircleRadius{
    return (self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.outerCicrcleBetweenMargin * 2) / 6.0;
}
- (void)customDefaultValue{
    
    _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 内边距
    
    _outerCicrcleBetweenMargin = 30;
    
    _outerCircleLineWidth = 1.0;//圆边框宽
    _innerCircleRadius = 6.0;//小圆半径
    
    _maxPasswordNum = 4;//最短密码
    
    _outerCircleColor = [UIColor clearColor];//圆颜色
    _outerCircleHighlightColor = [UIColor clearColor];//圆高亮颜色
    
    _outerCircleLineColor = [UIColor grayColor];//圆框颜色
    _outerCircleLineHighlightColor = [UIColor redColor];//圆框高亮色
    _innerCircleColor = [UIColor clearColor];//小圆颜色
    _innerCircleHighlightColor = [UIColor redColor];//小圆高亮色
    
    _lineColor = [UIColor redColor];//连线颜色
    _lineWidth = 5.0;//线宽
    
    _crossDomainSelectEnable = YES;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置初始值
        [self customDefaultValue];
    }
    return self;
}
- (void)refresh{
    _pointArr = [NSMutableArray array];
    _linePointArr = [NSMutableArray array];
    self.pointIDArr = [NSMutableArray array];
    
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
            [_pointArr addObject:lyPoint];
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
- (void)setLayerFrames
{
    LYSCircleLayer *lyPoint;
    
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            CGFloat x = self.edgeInsets.left + j * (self.outerCircleRadius * 2 + self.outerCicrcleBetweenMargin);
            CGFloat y = self.edgeInsets.top + i * (self.outerCircleRadius * 2 + self.outerCicrcleBetweenMargin);
            lyPoint = [_pointArr objectAtIndex:i*3+j];
            lyPoint.frame = CGRectMake(x, y, self.outerCircleRadius * 2, self.outerCircleRadius * 2);
            [lyPoint setNeedsDisplay];
        }
    }
    _lineLayer.frame = self.bounds;
    [_lineLayer setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    _nowTouchPoint = [touch locationInView:self];
    LYSCircleLayer *lyPoint;
    for (int i = 0; i < 9; i++){
        lyPoint = [_pointArr objectAtIndex:i];
        if (CGRectContainsPoint(lyPoint.frame, _nowTouchPoint)){
            lyPoint.highlighted = YES;
            [lyPoint setNeedsDisplay];
            [self.pointIDArr addObject:[NSNumber numberWithInt:i]];
            CGPoint lyPointCenter = CGPointMake(lyPoint.frame.origin.x + lyPoint.frame.size.width / 2.0, lyPoint.frame.origin.y + lyPoint.frame.size.height / 2.0);
            [_linePointArr addObject:[NSValue valueWithCGPoint:lyPointCenter]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
                [self.delegate lyPasswordView:self didSelectNum:self.pointIDArr];
            }
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    _nowTouchPoint = [touch locationInView:self];
    if (!CGRectContainsPoint(self.bounds, _nowTouchPoint)) {
        [self touchesEnded:touches withEvent:event];
        return;
    }
    LYSCircleLayer *lyPoint;
    if (self.crossDomainSelectEnable) {
        CGPoint point = [[_linePointArr lastObject] CGPointValue];
        if (sqrt((point.x - _nowTouchPoint.x) * (point.x - _nowTouchPoint.x) + (point.y - _nowTouchPoint.y) * (point.y - _nowTouchPoint.y)) <= sqrt((self.outerCircleRadius * 3) * (self.outerCircleRadius * 3) * 2)) {
            for (int i = 0; i < 9; i++){
                lyPoint = [_pointArr objectAtIndex:i];
                if (CGRectContainsPoint(lyPoint.frame, _nowTouchPoint)){
                    if (lyPoint.highlighted == NO)
                    {
                        lyPoint.highlighted = YES;
                        [lyPoint setNeedsDisplay];
                        
                        [self.pointIDArr addObject:[NSNumber numberWithInt:i]];
                        CGPoint lyPointCenter = CGPointMake(lyPoint.frame.origin.x + lyPoint.frame.size.width / 2.0, lyPoint.frame.origin.y + lyPoint.frame.size.height / 2.0);
                        [_linePointArr addObject:[NSValue valueWithCGPoint:lyPointCenter]];
                        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
                            [self.delegate lyPasswordView:self didSelectNum:self.pointIDArr];
                        }
                        break;
                    }
                }
            }
        }
    }else{
        for (int i = 0; i < 9; i++){
            lyPoint = [_pointArr objectAtIndex:i];
            if (CGRectContainsPoint(lyPoint.frame, _nowTouchPoint)){
                if (lyPoint.highlighted == NO)
                {
                    lyPoint.highlighted = YES;
                    [lyPoint setNeedsDisplay];
                    
                    [self.pointIDArr addObject:[NSNumber numberWithInt:i]];
                    CGPoint lyPointCenter = CGPointMake(lyPoint.frame.origin.x + lyPoint.frame.size.width / 2.0, lyPoint.frame.origin.y + lyPoint.frame.size.height / 2.0);
                    [_linePointArr addObject:[NSValue valueWithCGPoint:lyPointCenter]];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
                        [self.delegate lyPasswordView:self didSelectNum:self.pointIDArr];
                    }
                    break;
                }
            }
        }
        
    }
    
    _lineLayer.points = _linePointArr;
    _lineLayer.nowPoint = _nowTouchPoint;
    [_lineLayer setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSString *password = [self getPassword:_pointIDArr];
    //密码输入完毕回调
    if (password.length >= self.maxPasswordNum)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:withPassword:)]) {
            [self.delegate lyPasswordView:self withPassword:password];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
            [self.delegate lyPasswordView:self didSelectNum:@[]];
        }
    }else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:enError:)]) {
            [self.delegate lyPasswordView:self enError:LYPasswordStateTooShort];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
            [self.delegate lyPasswordView:self didSelectNum:@[]];
        }
    }
    
    LYSCircleLayer *lyPoint;
    for (int i = 0; i < 9; i++){
        lyPoint = [_pointArr objectAtIndex:i];
        if (lyPoint.highlighted == YES)
        {
            lyPoint.highlighted = NO;
            [lyPoint setNeedsDisplay];
        }
    }
    [self.pointIDArr removeAllObjects];
    [_linePointArr removeAllObjects];
    _lineLayer.points = _linePointArr;
    _lineLayer.nowPoint = CGPointZero;
    [_lineLayer setNeedsDisplay];
}

- (NSString*)getPassword:(NSArray*)array
{
    NSMutableString* password = [[NSMutableString alloc] initWithCapacity:9];
    for (int i = 0; i < [array count]; i++)
    {
        NSNumber* number = [array objectAtIndex:i];
        [password appendFormat:@"%d",[number intValue]];
    }
    return password;
}
@end
