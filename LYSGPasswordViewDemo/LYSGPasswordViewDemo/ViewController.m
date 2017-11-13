//
//  ViewController.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/26.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "ViewController.h"
#import "LYSGPasswordView.h"
#import "LYSAssistGPView.h"
@interface ViewController ()<LYSGPasswordViewDelegate>
@property (nonatomic,strong)LYSAssistGPView *assistGpView;
@property (nonatomic,strong)LYSGPasswordView *gpView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _assistGpView = [[LYSAssistGPView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0 - 50, 50, 100, 100)];
    [_assistGpView refresh];
    [self.view addSubview:_assistGpView];
    
    _gpView = [[LYSGPasswordView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width)];
    _gpView.delegate = self;
    _gpView.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [_gpView refresh];
    [self.view addSubview:_gpView];
    
}
- (void)lyPasswordView:(LYSGPasswordView *)passwordView didSelectNum:(NSArray *)numAry{
    [_assistGpView lyUpdatePassword:numAry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
