//
//  RRAnalyticsManager.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/14.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
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
        [RRAnalyticsHook hookClass:self selector:appearSelector swizzlingSelector:swizzling_appearSelector];
        
        SEL disappearSelector = @selector(viewWillDisappear:);
        SEL swizzling_disappearSelector = @selector(swizzling_viewWillDisappear:);
        [RRAnalyticsHook hookClass:[self class] selector:disappearSelector swizzlingSelector:swizzling_disappearSelector];
    });
}

- (void)swizzling_viewWilAppear:(BOOL)animated {
    
    // 插入代码
    
    // 调用原方法
    [self swizzling_viewWilAppear:animated];
    NSLog(@"事件统计: %@ appear", NSStringFromClass([self class]));
}

- (void)swizzling_viewWillDisappear:(BOOL)animated {
    
    [self swizzling_viewWillDisappear:animated];
    NSLog(@"事件统计: %@ disappear", NSStringFromClass([self class]));
}

@end

@implementation UIControl (RRAnalytics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL sendAction = @selector(sendAction:to:forEvent:);
        SEL swizzling_sendAction = @selector(swizzling_sendAction:to:forEvent:);
        [RRAnalyticsHook hookClass:[self class] selector:sendAction swizzlingSelector:swizzling_sendAction];
    });
}

- (void)swizzling_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    [self swizzling_sendAction:action to:target forEvent:event];
    NSLog(@"事件统计: 按钮 -- class:%@, action:%@", NSStringFromClass([target class]), NSStringFromSelector(action));
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
        [RRAnalyticsHook hookClass:[self class] selector:initAction swizzlingSelector:swizzlingInitAction];
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
        
        [RRAnalyticsHook hookClass:[target class] selector:action swizzlingSelector:swizzlingSelector];
    }
    
    self.className = NSStringFromClass([target class]);
    self.actionName = actionStr;
    return gesture;
}

- (void)swizzling_action:(UIGestureRecognizer *)ges {
    [RRAnalyticsManager umeng_event:@"test2" label:@"test2" ];

    NSLog(@"事件统计: 手势 -- class:%@, action:%@", ges.className, ges.actionName);
    // 调用原方法
    SEL swizzling_selector = NSSelectorFromString([NSString stringWithFormat:@"swizzling_%@", ges.actionName]);
    if ([self respondsToSelector:swizzling_selector]) {
        IMP imp = [self methodForSelector:swizzling_selector];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self, swizzling_selector, ges);
    }
}

@end

@interface UITableView (RRAnalytics)

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *actionName;

@end

@implementation UITableView (RRAnalytics)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL delegateSetter = @selector(setDelegate:);
        SEL swizzlingDelegateSetter = @selector(swizzling_setDelegate:);
        [RRAnalyticsHook hookClass:self selector:delegateSetter swizzlingSelector:swizzlingDelegateSetter];
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

- (void)swizzling_setDelegate:(id<UITableViewDelegate>)delegate {
    
    [self swizzling_setDelegate:delegate];
    
    SEL select = @selector(tableView:didSelectRowAtIndexPath:);
    if ([delegate respondsToSelector:select]) {
        
        // 在delegate中创建swizzling_tableView...方法
        SEL swizzling_Select = @selector(swizzling_tableView:didSelectRowAtIndexPath:);
        Method swizzling_method = class_getInstanceMethod([self class], swizzling_Select);
        Method method = class_getInstanceMethod([delegate class], select);
        if (class_addMethod([delegate class], swizzling_Select, method_getImplementation(swizzling_method), method_getTypeEncoding(swizzling_method))) {
            // 已经添加直接交换实现
            method_exchangeImplementations(method, class_getInstanceMethod([delegate class], swizzling_Select));
        }
        
        self.className = NSStringFromClass([delegate class]);
        self.actionName = @"didSelectTableView";
    }
}

- (void)swizzling_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"事件统计: tableView -- class:%@", self.className);
    [RRAnalyticsManager umeng_event:@"test1" label:@"test1" ];

    [self swizzling_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end

@interface UICollectionView (RRAnalytics)

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *actionName;

@end

@implementation UICollectionView (RRAnalytics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL delegateSetter = @selector(setDelegate:);
        SEL swizzlingDelegateSetter = @selector(swizzling_setDelegate:);
        [RRAnalyticsHook hookClass:self selector:delegateSetter swizzlingSelector:swizzlingDelegateSetter];
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

- (void)swizzling_setDelegate:(id<UICollectionViewDelegate>)delegate {
    [RRAnalyticsManager umeng_event:@"test3" label:@"test3" ];

    [self swizzling_setDelegate:delegate];
    
    SEL select = @selector(collectionView:didSelectItemAtIndexPath:);

      if ([delegate respondsToSelector:select]) {
        
        // 在delegate中创建swizzling_collectionView:didSelect...方法
        SEL swizzling_Select = @selector(swizzling_collectionView:didSelectItemAtIndex:);
        Method swizzling_method = class_getInstanceMethod([self class], swizzling_Select);
        Method method = class_getInstanceMethod([delegate class], select);
        if (class_addMethod([delegate class], swizzling_Select, method_getImplementation(swizzling_method), method_getTypeEncoding(swizzling_method))) {
            method_exchangeImplementations(method, class_getInstanceMethod([delegate class], swizzling_Select));
        }
    
        self.className = NSStringFromClass([delegate class]);
        self.actionName = @"didSelectCollectionView";
    }
}

- (void)swizzling_collectionView:(UICollectionView *)collectionView didSelectItemAtIndex:(NSIndexPath *)indexPath {
    
    NSLog(@"事件统计: collectionView -- class:%@", self.className);
    [self swizzling_collectionView:collectionView didSelectItemAtIndex:indexPath];
}

@end

