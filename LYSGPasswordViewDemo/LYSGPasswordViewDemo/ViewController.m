//
//  ViewController.m
//  LYSGPasswordViewDemo
//
//  Created by HENAN on 17/7/26.
//  Copyright © 2017年 LYS. All rights reserved.
//

#import "ViewController.h"
#import "GPViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    GPViewController *gpVC = [[GPViewController alloc] init];
    gpVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    gpVC.view.backgroundColor = [UIColor colorWithRed:5/255.0 green:20/255.0 blue:36/255.0 alpha:0.9];
    [self presentViewController:gpVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
