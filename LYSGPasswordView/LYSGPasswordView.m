
//
//  LYSGPasswordView.m
//  LYSGPasswordView
//
//  Created by HENAN on 17/5/10.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "LYSGPasswordView.h"

#define PINGFANG(A) ((A) * (A))

@interface LYSGPasswordView ()

@property (nonatomic,strong)LYSGPasswordStyle *style;

@property (nonatomic,strong)LYSLineLayer *lineLayer;
@property (nonatomic,assign)CGPoint nowTouchPoint;

@property (nonatomic,strong)NSMutableArray *pointAry;
@property (nonatomic,strong)NSMutableArray *linePointAry;
@property (nonatomic,strong,readwrite)NSMutableArray *pointIDArr;

@property (nonatomic,assign)CGFloat allSpace_x;
@property (nonatomic,assign)CGFloat allSpace_y;

@property (nonatomic,assign)CGFloat item_w;
@property (nonatomic,assign)CGFloat item_h;

@end

@implementation LYSGPasswordView

- (id)initWithFrame:(CGRect)frame style:(LYSGPasswordStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.pointAry = [NSMutableArray array];
        self.linePointAry = [NSMutableArray array];
        self.pointIDArr = [NSMutableArray array];
        [self logicDefaultValue];
        [self customSubViews];
    }
    return self;
}

// 计算初始数据
- (void)logicDefaultValue
{
    _allSpace_x = self.style.circleSpaceBetween * 2 + self.style.edges.left + self.style.edges.right;
    _allSpace_y = self.style.circleSpaceBetween * 2 + self.style.edges.top + self.style.edges.bottom;
    _item_w = (CGRectGetWidth(self.frame) - _allSpace_x) / 3.0;
    _item_h = (CGRectGetHeight(self.frame) - _allSpace_y) / 3.0;
    self.userInteractionEnabled = self.style.touchEnable;
}

// 布局子视图
- (void)customSubViews
{
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            LYSCircleLayer *lyPoint = [LYSCircleLayer layer];
            lyPoint.outerCircleStyle = self.style.outerCircleStyle;
            lyPoint.interCircleStyle = self.style.interCircleStyle;
            lyPoint.centerCircleStyle = self.style.centerCircleStyle;
            lyPoint.highlighted = NO;
            lyPoint.bounds = CGRectMake(0, 0, _item_w, _item_h);
            CGFloat x = self.style.edges.left + _item_w * 0.5 + (_item_w + self.style.circleSpaceBetween) * j;
            CGFloat y = self.style.edges.top + _item_h * 0.5 + (_item_h + self.style.circleSpaceBetween) * i;
            lyPoint.position = CGPointMake(x, y);
            [lyPoint setNeedsDisplay];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    _nowTouchPoint = [[touches anyObject] locationInView:self];
    [self updateStyle];
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
    if (self.style.crossDomainSelectEnable){[self updateStyle];}else
    {
        CGPoint point = [[self.linePointAry lastObject] CGPointValue];
        CGFloat margin = sqrt(PINGFANG(_item_w + self.style.circleSpaceBetween) + PINGFANG(_item_h + self.style.circleSpaceBetween));
        if (sqrt(PINGFANG(point.x - _nowTouchPoint.x) + PINGFANG(point.y - _nowTouchPoint.y)) <= sqrt(PINGFANG(margin)))
        {
            [self updateStyle];
        }
    }
    _lineLayer.points = self.linePointAry;
    _lineLayer.nowPoint = _nowTouchPoint;
    [_lineLayer setNeedsDisplay];
}

- (void)updateStyle
{
    for (int i = 0; i < 9; i++){
        LYSCircleLayer *lyPoint = [self.pointAry objectAtIndex:i];
        if (CGRectContainsPoint(lyPoint.frame, _nowTouchPoint)){
            if ([self.pointIDArr count] == 0 && [self.linePointAry count] == 0) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordViewDidStart:)]) {
                    [self.delegate lyPasswordViewDidStart:self];
                }
            }
            if (lyPoint.highlighted == NO)
            {
                lyPoint.highlighted = YES;
                [lyPoint setNeedsDisplay];
                
                [self.pointIDArr addObject:[NSNumber numberWithInt:i]];
                [self.linePointAry addObject:[NSValue valueWithCGPoint:lyPoint.position]];
                if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
                    [self.delegate lyPasswordView:self didSelectNum:self.pointIDArr];
                    if (self.smallGpView) {
                        [self.smallGpView updatePassword:self.pointIDArr];
                    }
                }
                break;
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSString *password = [self getPassword:self.pointIDArr];
    //密码输入完毕回调
    if (password.length >= self.style.maxPasswordNum)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:withPassword:)]) {
            [self.delegate lyPasswordView:self withPassword:password];
        }
    }else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:enError:)]) {
            [self.delegate lyPasswordView:self enError:LYPasswordStateTooShort];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordView:didSelectNum:)]) {
        [self.delegate lyPasswordView:self didSelectNum:@[]];
        if (self.smallGpView) {
            [self.smallGpView updatePassword:@[]];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyPasswordViewDidEnd:)]) {
        [self.delegate lyPasswordViewDidEnd:self];
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

- (void)updatePassword:(NSArray *)passwordAry
{
    [self.pointIDArr removeAllObjects];
    [self.linePointAry removeAllObjects];
    
    self.lineLayer.points = self.linePointAry;
    self.lineLayer.nowPoint = CGPointZero;
    [self.lineLayer setNeedsDisplay];
    
    for (int i = 0; i < 9; i++)
    {
        LYSCircleLayer *lyPoint = [self.pointAry objectAtIndex:i];
        if (lyPoint.highlighted == YES)
        {
            lyPoint.highlighted = NO;
            [lyPoint setNeedsDisplay];
        }
    }
    
    for (int i = 0; i < passwordAry.count; i++)
    {
        LYSCircleLayer *lyPoint = [self.pointAry objectAtIndex:[passwordAry[i] integerValue]];
        if (lyPoint.highlighted == NO)
        {
            lyPoint.highlighted = YES;
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

@implementation LYSGPasswordStyle

+ (instancetype)defaultStyle
{
    
    LYSGPasswordStyle *style = [[LYSGPasswordStyle alloc] init];
    
    LYSCircleStyle *outerCircleStyle = [[LYSCircleStyle alloc] init];
    LYSCircleStyle *interCircleStyle = [[LYSCircleStyle alloc] init];
    LYSCircleStyle *centerCircleStyle = [[LYSCircleStyle alloc] init];
    
    style.outerCircleStyle = outerCircleStyle;
    style.interCircleStyle = interCircleStyle;
    style.centerCircleStyle = centerCircleStyle;
    
    style.outerCircleStyle.radius = 40;
    style.outerCircleStyle.lineWidth = 1.0;
    style.outerCircleStyle.lineColor = [UIColor grayColor];
    style.outerCircleStyle.lineHighlightColor = [UIColor whiteColor];
    style.outerCircleStyle.fillColor = [UIColor clearColor];
    style.outerCircleStyle.fillHighlightColor = [UIColor clearColor];
    
    style.interCircleStyle.radius = 20;
    style.interCircleStyle.lineWidth = 0;
    style.interCircleStyle.lineColor = [UIColor grayColor];
    style.interCircleStyle.lineHighlightColor = [UIColor whiteColor];
    style.interCircleStyle.fillColor = [UIColor clearColor];
    style.interCircleStyle.fillHighlightColor = [UIColor clearColor];
    
    style.centerCircleStyle.radius = 8;
    style.centerCircleStyle.lineWidth = 0;
    style.centerCircleStyle.lineColor = [UIColor clearColor];
    style.centerCircleStyle.lineHighlightColor = [UIColor clearColor];
    style.centerCircleStyle.fillColor = [UIColor clearColor];
    style.centerCircleStyle.fillHighlightColor = [UIColor whiteColor];
    
    style.touchEnable = YES;
    style.maxPasswordNum = 4;//最短密码
    style.lineColor = [UIColor whiteColor];//连线颜色
    style.lineWidth = 4.0;//线宽
    style.crossDomainSelectEnable = NO;
    style.edges = UIEdgeInsetsMake(20, 20, 20, 20);
    style.circleSpaceBetween = 20;
    
    return style;
}

+ (instancetype)smallGpStyle
{
    
    LYSGPasswordStyle *style = [[LYSGPasswordStyle alloc] init];
    
    LYSCircleStyle *outerCircleStyle = [[LYSCircleStyle alloc] init];
    LYSCircleStyle *interCircleStyle = [[LYSCircleStyle alloc] init];
    LYSCircleStyle *centerCircleStyle = [[LYSCircleStyle alloc] init];
    
    style.outerCircleStyle = outerCircleStyle;
    style.interCircleStyle = interCircleStyle;
    style.centerCircleStyle = centerCircleStyle;
    
    style.outerCircleStyle.radius = 0;
    style.outerCircleStyle.lineWidth = 1.0;
    style.outerCircleStyle.lineColor = [UIColor grayColor];
    style.outerCircleStyle.lineHighlightColor = [UIColor whiteColor];
    style.outerCircleStyle.fillColor = [UIColor clearColor];
    style.outerCircleStyle.fillHighlightColor = [UIColor clearColor];
    
    style.interCircleStyle.radius = 0;
    style.interCircleStyle.lineWidth = 0;
    style.interCircleStyle.lineColor = [UIColor grayColor];
    style.interCircleStyle.lineHighlightColor = [UIColor whiteColor];
    style.interCircleStyle.fillColor = [UIColor clearColor];
    style.interCircleStyle.fillHighlightColor = [UIColor clearColor];
    
    style.centerCircleStyle.radius = 5;
    style.centerCircleStyle.lineWidth = 0;
    style.centerCircleStyle.lineColor = [UIColor clearColor];
    style.centerCircleStyle.lineHighlightColor = [UIColor clearColor];
    style.centerCircleStyle.fillColor = [UIColor clearColor];
    style.centerCircleStyle.fillHighlightColor = [UIColor whiteColor];
    
    style.touchEnable = NO;
    style.maxPasswordNum = 4;//最短密码
    style.lineColor = [UIColor whiteColor];//连线颜色
    style.lineWidth = 2.0;//线宽
    style.crossDomainSelectEnable = NO;
    style.edges = UIEdgeInsetsMake(0, 0, 0, 0);
    style.circleSpaceBetween = 5;
    
    return style;
}
@end

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

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define Degrees(A) ((3.14159265359 * A)/ 180)

@implementation LYSCircleStyle
@end

@implementation LYSCircleLayer

- (void)drawInContext:(CGContextRef)ctx
{
    
    CGSize size = self.bounds.size;
    // 外圆
    [self createOuterCircleWithSize:size context:ctx];
    // 内圆
    [self createInterCircleWithSize:size context:ctx];
    // 中心
    [self createCenterCircleWithSize:size context:ctx];
    
}

// 外圆
- (void)createOuterCircleWithSize:(CGSize)size context:(CGContextRef)ctx {
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);
    CGFloat outerCircleRadius = self.outerCircleStyle.radius == 0 ? (size.width - (self.outerCircleStyle.lineWidth * 2)) / 2.0 : self.outerCircleStyle.radius;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:outerCircleRadius startAngle:Degrees(0) endAngle:Degrees(360) clockwise:YES];
    if (self.highlighted) {
        CGContextSetFillColorWithColor(ctx, self.outerCircleStyle.fillHighlightColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.outerCircleStyle.lineHighlightColor.CGColor);
    } else {
        CGContextSetFillColorWithColor(ctx, self.outerCircleStyle.fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.outerCircleStyle.lineColor.CGColor);
    }
    CGContextSetLineWidth(ctx, self.outerCircleStyle.lineWidth);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

// 内圆
- (void)createInterCircleWithSize:(CGSize)size context:(CGContextRef)ctx {
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);
    CGFloat interCircleRadius = self.interCircleStyle.radius;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:interCircleRadius startAngle:Degrees(0) endAngle:Degrees(360) clockwise:YES];
    if (self.highlighted) {
        CGContextSetFillColorWithColor(ctx, self.interCircleStyle.fillHighlightColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.interCircleStyle.lineHighlightColor.CGColor);
    } else {
        CGContextSetFillColorWithColor(ctx, self.interCircleStyle.fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.interCircleStyle.lineColor.CGColor);
    }
    CGContextSetLineWidth(ctx, self.interCircleStyle.lineWidth);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

// 中心点
- (void)createCenterCircleWithSize:(CGSize)size context:(CGContextRef)ctx {
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);
    CGFloat centerCircleRadius = self.centerCircleStyle.radius;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:centerCircleRadius startAngle:Degrees(0) endAngle:Degrees(360) clockwise:YES];
    if (self.highlighted) {
        CGContextSetFillColorWithColor(ctx, self.centerCircleStyle.fillHighlightColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.centerCircleStyle.lineHighlightColor.CGColor);
    } else {
        CGContextSetFillColorWithColor(ctx, self.centerCircleStyle.fillColor.CGColor);
        CGContextSetStrokeColorWithColor(ctx, self.centerCircleStyle.lineColor.CGColor);
    }
    CGContextSetLineWidth(ctx, self.centerCircleStyle.lineWidth);
    CGContextAddPath(ctx, path.CGPath);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end

