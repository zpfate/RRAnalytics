//
//  RRAnalyticsHook.h
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRAnalyticsHook : NSObject

+ (void)hookClass:(Class)cls originSelctor:(SEL)originSelector targetSelector:(SEL)swizzlingSelector;


@end

NS_ASSUME_NONNULL_END
