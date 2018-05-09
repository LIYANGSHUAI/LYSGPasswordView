//
//  GPViewController.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 2018/5/9.
//  Copyright © 2018年 LYS. All rights reserved.
//

#import "GPViewController.h"
#import "LYSGPasswordView.h"

@interface GPViewController ()<LYSGPasswordViewDelegate>

@property (nonatomic,strong)LYSGPasswordView *gpView_small;
@property (nonatomic,strong)LYSGPasswordView *gpView;

@end

@implementation GPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _gpView_small = [[LYSGPasswordView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100)/2.0, 80, 100, 100) style:[LYSGPasswordStyle smallGpStyle]];
    [self.view addSubview:_gpView_small];
    
    _gpView = [[LYSGPasswordView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width) style:[LYSGPasswordStyle defaultStyle]];
    _gpView.delegate = self;
    _gpView.smallGpView = _gpView_small;
    [self.view addSubview:_gpView];
    
}
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
