//
//  RRAnalytics.h
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/15.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface RRAnalyticsInfo : NSObject

@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSMutableDictionary *parameters;

@end

@interface RRAnalytics : NSObject

+ (void)umeng_event:(nonnull NSString *)eventId;

+ (void)umeng_event:(nonnull NSString *)eventId label:(NSString *)label;

@end

NS_ASSUME_NONNULL_END
