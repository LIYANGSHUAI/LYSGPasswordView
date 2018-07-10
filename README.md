# LYSGPasswordView
Analog gesture cryptography

![image](https://github.com/LIYANGSHUAI/LYSGPasswordView/blob/master/gif.gif)

使用方法:

1.可以直接下载Demmo,拖入文件使用

2.cocopods安装

终端执行

pod 'LYSGPasswordView', '~> 0.0.5'

```objc
LYSGPasswordView *gpView = [[LYSGPasswordView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width) style:[LYSGPasswordStyle defaultStyle]];
gpView.delegate = self;
[self.view addSubview:gpView];
```

```objc
LYSGPasswordView *gpView_small = [[LYSGPasswordView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100)/2.0, 80, 100, 100) style:[LYSGPasswordStyle smallGpStyle]];
[self.view addSubview:gpView_small];

LYSGPasswordView *gpView = [[LYSGPasswordView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width) style:[LYSGPasswordStyle defaultStyle]];
gpView.delegate = self;
gpView.smallGpView = gpView_small;
[self.view addSubview:gpView];
```

```objc
- (void)lyPasswordView:(LYSGPasswordView *)passwordView didSelectNum:(NSArray *)numAry{
NSLog(@"%@",numAry);
}
- (void)lyPasswordView:(LYSGPasswordView *)passwordView enError:(LYPasswordState)state {
NSLog(@"%ld",(long)state);

}
- (void)lyPasswordView:(LYSGPasswordView *)passwordView withPassword:(NSString *)password {
NSLog(@"%@",password);

}
- (void)lyPasswordViewDidStart:(LYSGPasswordView *)passwordView {
NSLog(@"开始");
}
- (void)lyPasswordViewDidEnd:(LYSGPasswordView *)passwordView {
NSLog(@"结束");
}
```
