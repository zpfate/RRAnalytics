//
//
//  RRAnalyticsManager.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import "RRAnalyticsHook.h"

#import <objc/runtime.h>
@implementation RRAnalyticsHook

+ (BOOL)isClassOfSystem:(id)cls {
    
    NSBundle *bundle = [NSBundle bundleForClass:[cls class]];
    if (bundle == NSBundle.mainBundle) {
        return NO;
    }
    return YES;

}
+ (void)hookClass:(Class)cls selector:(SEL)selector swizzlingSelector:(SEL)swizzlingSelector {
    
    Method method = class_getInstanceMethod(cls, selector);
    Method swizzlingMethod = class_getInstanceMethod(cls, swizzlingSelector);
    
    // 返回yes表示被替换的方法没有被实现,先通过class_addMethod实现, 如果已经实现则直接交换IMP
    if (class_addMethod(cls, swizzlingSelector, method_getImplementation(method), method_getTypeEncoding(method))) {
        // 交换方法
        class_replaceMethod(cls, swizzlingSelector, method_getImplementation(method), method_getTypeEncoding(method));
    } else {
        method_exchangeImplementations(method, swizzlingMethod);
    }
}

@end
