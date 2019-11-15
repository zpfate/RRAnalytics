//
//  ButtonViewController.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/14.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "ButtonViewController.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *buttonName = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonName.backgroundColor = [UIColor greenColor];
    buttonName.frame = CGRectMake(100, 100, 100, 60);
    [buttonName setTitle:@"buttonName" forState:UIControlStateNormal];
    [buttonName addTarget:self action:@selector(buttonName:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonName];
    
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.backgroundColor = [UIColor yellowColor];
    newBtn.frame = CGRectMake(100, 200, 100, 60);
    [newBtn setTitle:@"buttonName" forState:UIControlStateNormal];
    [newBtn addTarget:self action:@selector(newBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBtn];
}

- (void)buttonName:(UIButton *)sender {
    
    NSLog(@"click button ------------ buttonName");
}


- (void)newBtn:(UIButton *)sender {
    
    NSLog(@"click button ------------ newBtn");
}

@end
