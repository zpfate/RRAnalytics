//
//  UIViewController+RRAnalytics.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "UIViewController+RRAnalytics.h"
#import <UMAnalytics/MobClick.h>
#import "RRAnalyticsHook.h"
@implementation UIViewController (RRAnalytics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originAppearSelector = @selector(viewWillAppear:);
        SEL swizzlingAppearSelector = @selector(swizzling_viewWilAppear:);
        [RRAnalyticsHook hookClass:self originSelctor:originAppearSelector targetSelector:swizzlingAppearSelector];
        
        SEL originDisappearSelector = @selector(viewWillDisappear:);
        SEL swizzlingDisappearSelector = @selector(swizzling_viewWillDisappear:);
        [RRAnalyticsHook hookClass:self originSelctor:originDisappearSelector targetSelector:swizzlingDisappearSelector];
        
    });
}

- (void)swizzling_viewWilAppear:(BOOL)animated {
    
    // 插入代码
    
    
    // 调用原方法
    [self swizzling_viewWilAppear:animated];
    
}

//
- (void)swizzling_viewWillDisappear:(BOOL)animated {
    
    
    [self swizzling_viewWillDisappear:animated];
    
}



@end
