//
//  GestureViewController.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/14.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

static int i = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    i = 0;
    [self initGestureView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initGestureView {
    
    if (i > 3) {
        return;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100 + 100 * i, 150, 80)];
    view.backgroundColor = [UIColor redColor];
    NSString *selectorString = [NSString stringWithFormat:@"gesture%d:", i];
    SEL selector = NSSelectorFromString(selectorString);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [view addGestureRecognizer:tap];
    [self.view addSubview:view];
    
    i++;
    [self initGestureView];
}

- (void)gesture0:(UIGestureRecognizer *)ges {
    NSLog(@"gesture tap 0");
}

- (void)gesture1:(UIGestureRecognizer *)ges {
    NSLog(@"gesture tap 1");
}

- (void)gesture2:(UIGestureRecognizer *)ges {
    NSLog(@"gesture tap 2");
}

- (void)gesture3:(UIGestureRecognizer *)ges {
    NSLog(@"gesture tap 3");
}
@end
