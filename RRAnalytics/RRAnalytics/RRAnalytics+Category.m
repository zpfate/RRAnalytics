//
//  RRAnalytics+Category.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/14.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "RRAnalytics+Category.h"
#import <UMAnalytics/MobClick.h>
#import "RRAnalyticsHook.h"
#import <objc/runtime.h>

@implementation UIViewController (RRAnalytics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL appearSelector = @selector(viewWillAppear:);
        SEL swizzling_appearSelector = @selector(swizzling_viewWilAppear:);
        [RRAnalyticsHook hookClass:self originSelctor:appearSelector targetSelector:swizzling_appearSelector];
        
        SEL disappearSelector = @selector(viewWillDisappear:);
        SEL swizzling_disappearSelector = @selector(swizzling_viewWillDisappear:);
        [RRAnalyticsHook hookClass:[self class] originSelctor:disappearSelector targetSelector:swizzling_disappearSelector];
    });
}

- (void)swizzling_viewWilAppear:(BOOL)animated {
    
    // 插入代码
    
    // 调用原方法
    [self swizzling_viewWilAppear:animated];
    NSLog(@"VC出现:%@", NSStringFromClass([self class]));
}

//
- (void)swizzling_viewWillDisappear:(BOOL)animated {
    
    [self swizzling_viewWillDisappear:animated];
    NSLog(@"VC消失:%@", NSStringFromClass([self class]));
}

@end

@implementation UIControl (RRAnalytics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL sendAction = @selector(sendAction:to:forEvent:);
        SEL swizzling_sendAction = @selector(swizzling_sendAction:to:forEvent:);
        [RRAnalyticsHook hookClass:[self class] originSelctor:sendAction targetSelector:swizzling_sendAction];
    });
}

- (void)swizzling_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    [self swizzling_sendAction:action to:target forEvent:event];
    NSLog(@"当前Class:%@, 当前Action:%@", NSStringFromClass([target class]), NSStringFromSelector(action));
}

@end

@interface UIGestureRecognizer (RRAnalytics)

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *actionName;

@end

@implementation UIGestureRecognizer (RRAnalytics)

+ (void)load {
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL initAction = @selector(initWithTarget:action:);
        SEL swizzlingInitAction = @selector(swizzling_initWithTarget:action:);
        [RRAnalyticsHook hookClass:[self class] originSelctor:initAction targetSelector:swizzlingInitAction];
    });
}

- (NSString *)className {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClassName:(NSString *)className {
    objc_setAssociatedObject(self, @selector(className), className, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)actionName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setActionName:(NSString *)actionName {
    objc_setAssociatedObject(self, @selector(actionName), actionName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (instancetype)swizzling_initWithTarget:(id)target action:(SEL)action {
    
    UIGestureRecognizer *gesture = [self swizzling_initWithTarget:target action:action];
    if ([RRAnalyticsHook isClassOfSystem:target]) {
        return gesture;
    }
    
    // 再hook action
    NSString *actionStr = NSStringFromSelector(action);
    
    // 新建一个swizzling_selector方法
    NSString *swizzling_selectorStr = [NSString stringWithFormat:@"swizzling_%@",actionStr];
    SEL swizzlingSelector = NSSelectorFromString(swizzling_selectorStr);
    
    // 获取swizzling_action
    SEL swizzling_action = @selector(swizzling_action:);
    Method swizzling_actionMethod = class_getInstanceMethod([self class], swizzling_action);
    
    // 给target添加swizzling_selector方法, 实现为swizzling_action
    if (class_addMethod([target class], swizzlingSelector, method_getImplementation(swizzling_actionMethod), method_getTypeEncoding(swizzling_actionMethod))) {
        
        [RRAnalyticsHook hookClass:[target class] originSelctor:action targetSelector:swizzlingSelector];
    }
    
    self.className = NSStringFromClass([target class]);
    self.actionName = actionStr;
    return gesture;
}

- (void)swizzling_action:(UIGestureRecognizer *)ges {
    
    NSLog(@"当前Class:%@, 当前Action:%@", ges.className, ges.actionName);
    
    // 调用原方法
    SEL swizzling_selector = NSSelectorFromString([NSString stringWithFormat:@"swizzling_%@", ges.actionName]);
    if ([self respondsToSelector:swizzling_selector]) {
        IMP imp = [self methodForSelector:swizzling_selector];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, swizzling_selector, ges);
    }
    NSLog(@"%@", NSStringFromClass([self class]));
}

@end

@interface UITableView (RRAnalytics)

@property (nonatomic, copy) NSString *className;

@end

@implementation UITableView (RRAnalytics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL delegateSetter = @selector(setDelegate:);
        SEL swizzlingDelegateSetter = @selector(swizzling_setDelegate:);
        [RRAnalyticsHook hookClass:self originSelctor:delegateSetter targetSelector:swizzlingDelegateSetter];
    });
}

- (void)swizzling_setDelegate:(id<UITableViewDelegate>)delegate {
    
    [self swizzling_setDelegate:delegate];
    
    if ([delegate conformsToProtocol:@protocol(UITableViewDelegate)]) {
        
        SEL select = @selector(tableView:didSelectRowAtIndexPath:);
        SEL swizzlingSelect = @selector(swizzling_tableView:didSelectRowAtIndexPath:);
        [RRAnalyticsHook hookClass:[delegate class] originSelctor:select targetSelector:swizzlingSelect];
    }
}

- (void)swizzling_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self swizzling_tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSLog(@"tableView点击: %@", NSStringFromClass([tableView.delegate class]));
}

@end

@implementation UICollectionView (RRAnalytics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL delegateSetter = @selector(setDelegate:);
        SEL swizzlingDelegateSetter = @selector(swizzling_setDelegate:);
        [RRAnalyticsHook hookClass:self originSelctor:delegateSetter targetSelector:swizzlingDelegateSetter];
    });
}

- (void)swizzling_setDelegate:(id<UICollectionViewDelegate>)delegate {
    
    [self swizzling_setDelegate:delegate];
    if ([delegate conformsToProtocol:@protocol(UICollectionViewDelegate)]) {
        SEL select = @selector(collectionView:didSelectItemAtIndexPath:);
        SEL swizzlingSelect = @selector(swizzling_collectionView:didSelectItemAtIndex:);
        [RRAnalyticsHook hookClass:[delegate class] originSelctor:select targetSelector:swizzlingSelect];
        
    }
}

- (void)swizzling_collectionView:(UICollectionView *)collectionView didSelectItemAtIndex:(NSIndexPath *)indexPath {
    
    [self swizzling_collectionView:collectionView didSelectItemAtIndex:indexPath];
    NSLog(@"collectionView点击: %@", NSStringFromClass([collectionView.delegate class]));
}

@end

