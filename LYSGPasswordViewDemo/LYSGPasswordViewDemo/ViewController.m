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
@property (nonatomic,strong)LYSAssistGPView *assisView;
@property (nonatomic,strong)LYSGPasswordView *gpView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _assisView = [[LYSAssistGPView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.5 - 50, 60, 100, 100) style:[LYSGPasswordStyle assisStyle]];
    [self.view addSubview:_assisView];
    
    _gpView = [[LYSGPasswordView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width) style:[LYSGPasswordStyle defaultStyle]];
    _gpView.delegate = self;
    [self.view addSubview:_gpView];
    
}
- (void)lyPasswordView:(LYSGPasswordView *)passwordView didSelectNum:(NSArray *)numAry{
    [_assisView ly_updatePassword:numAry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
