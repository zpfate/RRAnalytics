//
//  RRAnalyticsManager.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRAnalyticsHook : NSObject

+ (BOOL)isClassOfSystem:(id)cls;

+ (void)hookClass:(Class)cls selector:(SEL)selector swizzlingSelector:(SEL)swizzlingSelector;


@end

NS_ASSUME_NONNULL_END
