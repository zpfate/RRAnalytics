//
//  RRAnalyticsHook.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Twisted Fate. All rights reserved.
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
+ (void)hookClass:(Class)cls originSelctor:(SEL)originSelector targetSelector:(SEL)swizzlingSelector {
    
    Method orginMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzlingMethod = class_getInstanceMethod(cls, swizzlingSelector);
    
    // 返回yes表示被替换的方法没有被实现,先通过class_addMethod实现, 如果已经实现则直接交换IMP
    if (class_addMethod(cls, swizzlingSelector, method_getImplementation(orginMethod), method_getTypeEncoding(orginMethod))) {
        // 交换方法
        class_replaceMethod(cls, swizzlingSelector, method_getImplementation(orginMethod), method_getTypeEncoding(orginMethod));
        
    } else {
        method_exchangeImplementations(orginMethod, swizzlingMethod);
    }
}

@end
