//
//  LYPasswordView.h
//  LYWorkUIBagDemo
//
//  Created by HENAN on 17/5/10.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LYSGPasswordStyle.h"

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
- (id)initWithFrame:(CGRect)frame style:(LYSGPasswordStyle *)style;

@property (nonatomic,assign) id<LYSGPasswordViewDelegate> delegate;

@property (nonatomic,strong)NSMutableArray *pointIDArr;            //当前已输的密码

- (void)updatePassword:(NSArray *)passwordAry;
@end

