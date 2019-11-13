//
//  ViewController.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    static int i = 0;
    NSLog(@"执行次数-------%d", i);
    i++;
}

@end
