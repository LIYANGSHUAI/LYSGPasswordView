//
//  LYPasswordView.h
//  LYWorkUIBagDemo
//
//  Created by HENAN on 17/5/10.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class LYSGPasswordStyle, LYSCircleStyle;

//密码状态
typedef NS_ENUM(NSInteger,LYPasswordState) {
    LYPasswordStateTooShort,
};

@class LYSGPasswordView;
@protocol LYSGPasswordViewDelegate <NSObject>
@optional
// 输入完回掉
- (void)lyPasswordView:(LYSGPasswordView *)passwordView withPassword:(NSString*)password;
// 错误回调
- (void)lyPasswordView:(LYSGPasswordView *)passwordView enError:(LYPasswordState)state;
// 选中数字时触发
- (void)lyPasswordView:(LYSGPasswordView *)passwordView didSelectNum:(NSArray *)numAry;

// 开始选择
- (void)lyPasswordViewDidStart:(LYSGPasswordView *)passwordView;
// 结束选择
- (void)lyPasswordViewDidEnd:(LYSGPasswordView *)passwordView;
@end

@interface LYSGPasswordView : UIView
// 创建
- (id)initWithFrame:(CGRect)frame style:(LYSGPasswordStyle *)style;
// 代理
@property (nonatomic,assign) id<LYSGPasswordViewDelegate> delegate;
// 最终选择密码
@property (nonatomic,strong,readonly)NSMutableArray *pointIDArr;            //当前已输的密码

// 如果要设置小密码展示框,可以直接创建一个LYSGPasswordView视图,设置好样式设置这个属性即可
@property (nonatomic,strong)LYSGPasswordView *smallGpView;
// 主动刷新页面密码
- (void)updatePassword:(NSArray *)passwordAry;
@end

@interface LYSGPasswordStyle : NSObject

@property (nonatomic,assign)BOOL touchEnable;                           // 是否允许选择,默认是YES

// 外圆
@property (nonatomic,strong)LYSCircleStyle *outerCircleStyle;
// 内圆
@property (nonatomic,strong)LYSCircleStyle *interCircleStyle;
// 中心点
@property (nonatomic,strong)LYSCircleStyle *centerCircleStyle;

// 连线颜色
@property (nonatomic,strong)UIColor *lineColor;
// 连线宽度
@property (nonatomic,assign)CGFloat lineWidth;

// 外圆间距
@property (nonatomic,assign)CGFloat circleSpaceBetween;
// 视图内边距
@property (nonatomic,assign)UIEdgeInsets edges;

@property (nonatomic,assign)NSInteger maxPasswordNum;              // 密码最低个数
@property (nonatomic,assign)BOOL crossDomainSelectEnable;          // 是否允许跨圆选择,默认是NO,不允许

// 手势密码默认样式
+ (instancetype)defaultStyle;

// 小密码框默认样式
+ (instancetype)smallGpStyle;

@end

// 连接线
@interface LYSLineLayer : CALayer

@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)UIColor *lineColor;

@property (nonatomic,strong)NSArray *points;          // 点数组
@property (nonatomic,assign)CGPoint nowPoint;         // 当前点

@end

// 圆样式
@interface LYSCircleStyle : NSObject

@property (nonatomic,assign)CGFloat radius;
@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)UIColor *lineColor;
@property (nonatomic,strong)UIColor *lineHighlightColor;
@property (nonatomic,strong)UIColor *fillColor;
@property (nonatomic,strong)UIColor *fillHighlightColor;

@end

// 圆
@interface LYSCircleLayer : CALayer

@property (nonatomic,strong)LYSCircleStyle *outerCircleStyle;
@property (nonatomic,strong)LYSCircleStyle *interCircleStyle;
@property (nonatomic,strong)LYSCircleStyle *centerCircleStyle;

@property (nonatomic,assign) BOOL highlighted;

@end
