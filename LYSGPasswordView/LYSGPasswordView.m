
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

#define LazyLoadMutableArray(A) \
- (NSMutableArray *)A{\
    if (!_##A) {\
        _##A = [NSMutableArray array];\
    }\
    return _##A;\
}

#define PINGFANG(A) ((A) * (A))

@interface LYSGPasswordView ()

@property (nonatomic,strong)LYSLineLayer *lineLayer;
@property (nonatomic,strong)NSMutableArray *pointAry;
@property (nonatomic,strong)NSMutableArray *linePointAry;
@property (nonatomic,assign)CGPoint nowTouchPoint;
@property (nonatomic,strong)LYSGPasswordStyle *style;

@end

@implementation LYSGPasswordView

LazyLoadMutableArray(pointAry);
LazyLoadMutableArray(linePointAry);
LazyLoadMutableArray(pointIDArr);

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    _nowTouchPoint = [[touches anyObject] locationInView:self];
    [self changeStyle];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    _nowTouchPoint = [[touches anyObject] locationInView:self];
    
    if (!CGRectContainsPoint(_lineLayer.bounds, _nowTouchPoint))
    {
        [self touchesEnded:touches withEvent:event];
        return;
    }
    
    if (self.style.crossDomainSelectEnable){[self changeStyle];}else
    {
        CGPoint point = [[self.linePointAry lastObject] CGPointValue];
        CGFloat margin = (self.style.outerCircleRadius * 3 + self.style.outerCicrcleBetweenMargin);
        if (sqrt(PINGFANG(point.x - _nowTouchPoint.x) + PINGFANG(point.y - _nowTouchPoint.y)) <= sqrt(PINGFANG(margin)))
        {
            [self changeStyle];
        }
    }
    
    _lineLayer.points = self.linePointAry;
    _lineLayer.nowPoint = _nowTouchPoint;
    [_lineLayer setNeedsDisplay];
}

- (void)changeStyle{
    for (int i = 0; i < 9; i++){
        LYSCircleLayer *lyPoint = [self.pointAry objectAtIndex:i];
        if (CGRectContainsPoint(lyPoint.frame, _nowTouchPoint)){
            if (lyPoint.highlighted == NO)
            {
                lyPoint.highlighted = YES;
                [lyPoint setNeedsDisplay];
                
                [self.pointIDArr addObject:[NSNumber numberWithInt:i]];
                [self.linePointAry addObject:[NSValue valueWithCGPoint:lyPoint.position]];
                if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
                    [self.delegate lyPasswordView:self didSelectNum:self.pointIDArr];
                }
                break;
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSString *password = [self getPassword:_pointIDArr];
    //密码输入完毕回调
    if (password.length >= self.style.maxPasswordNum)
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

    for (int i = 0; i < 9; i++)
    {
        LYSCircleLayer *lyPoint = [self.pointAry objectAtIndex:i];
        if (lyPoint.highlighted == YES)
        {
            lyPoint.highlighted = NO;
            [lyPoint setNeedsDisplay];
        }
    }
    
    [self.pointIDArr removeAllObjects];
    [self.linePointAry removeAllObjects];
    
    self.lineLayer.points = self.linePointAry;
    self.lineLayer.nowPoint = CGPointZero;
    [self.lineLayer setNeedsDisplay];
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

- (void)updatePassword:(NSArray *)passwordAry{
    
    [self.pointIDArr removeAllObjects];
    [self.linePointAry removeAllObjects];
    
    self.lineLayer.points = self.linePointAry;
    self.lineLayer.nowPoint = CGPointZero;
    [self.lineLayer setNeedsDisplay];
    
    for (int i = 0; i < passwordAry.count; i++)
    {
        LYSCircleLayer *lyPoint = [self.pointAry objectAtIndex:[passwordAry[i] integerValue]];
        if (lyPoint.highlighted == YES)
        {
            lyPoint.highlighted = NO;
            [lyPoint setNeedsDisplay];
            
            [self.pointIDArr addObject:[NSNumber numberWithInt:i]];
            [self.linePointAry addObject:[NSValue valueWithCGPoint:lyPoint.position]];
        }
    }
    
    _lineLayer.points = self.linePointAry;
    _lineLayer.nowPoint = [[self.linePointAry lastObject] CGPointValue];
    [_lineLayer setNeedsDisplay];
}

@end
