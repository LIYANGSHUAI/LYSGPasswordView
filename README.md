# LYSGPasswordView
Analog gesture cryptography

![image](https://github.com/LIYANGSHUAI/LYSGPasswordView/blob/master/gif.gif)

```objc
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
```
