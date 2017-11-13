//
//  LYPasswordView.h
//  LYWorkUIBagDemo
//
//  Created by HENAN on 17/5/10.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//密码状态
typedef NS_ENUM(NSInteger,LYPasswordState) {
    LYPasswordStateTooShort,
};

@class LYSGPasswordView;
@protocol LYSGPasswordViewDelegate <NSObject>
@optional
#pragma mark - 输入完回掉
- (void)lyPasswordView:(LYSGPasswordView *)passwordView withPassword:(NSString*)password;
#pragma mark - 错误回调 -
- (void)lyPasswordView:(LYSGPasswordView *)passwordView enError:(LYPasswordState)state;
#pragma mark - 选中数字时触发 -
- (void)lyPasswordView:(LYSGPasswordView *)passwordView didSelectNum:(NSArray *)numAry;
@end


@interface LYSGPasswordView : UIView

@property (nonatomic,assign)NSInteger maxPasswordNum;

@property (nonatomic,assign)UIEdgeInsets edgeInsets;               // 外边距

@property (nonatomic,assign)CGFloat outerCircleRadius;             // 外圆半径

@property (nonatomic,assign)CGFloat outerCicrcleBetweenMargin;     // 外圆间距

@property (nonatomic,assign)CGFloat outerCircleLineWidth;          // 外圆线宽
@property (nonatomic,strong)UIColor *outerCircleLineColor;         // 外圆线颜色
@property (nonatomic,strong)UIColor *outerCircleLineHighlightColor;// 外圆线高亮颜色
@property (nonatomic,strong)UIColor *outerCircleColor;             // 外圆填充颜色
@property (nonatomic,strong)UIColor *outerCircleHighlightColor;    // 外圆高亮填充颜色

@property (nonatomic,assign)CGFloat innerCircleRadius;             // 内圆半径
@property (nonatomic,strong)UIColor *innerCircleColor;             // 内圆填充颜色
@property (nonatomic,strong)UIColor *innerCircleHighlightColor;    // 内圆填充高亮颜色

@property (nonatomic,assign)CGFloat lineWidth;                     // 连线宽
@property (nonatomic,strong)UIColor *lineColor;                    // 连线颜色

@property (nonatomic,assign) id<LYSGPasswordViewDelegate> delegate;
@property (nonatomic,strong)NSMutableArray *pointIDArr;            //当前已输的密码

@property (nonatomic,assign)BOOL crossDomainSelectEnable;          // 是否允许跨圆选择

- (void)refresh;   
@end
