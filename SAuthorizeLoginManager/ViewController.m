//
//  ViewController.m
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "ViewController.h"
#import "SAuthorizeLoginManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"show view" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 200, 120, 100);
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)show {
    
    [SAuthorizeLoginManager loginWithChanelType:SAuthorizeLoginChannelType_QQ completion:^(NSDictionary *dic, SAuthorizeLoginType reusltType) {
        NSLog(@" qq - %@ resutl - %ld",dic,reusltType);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
