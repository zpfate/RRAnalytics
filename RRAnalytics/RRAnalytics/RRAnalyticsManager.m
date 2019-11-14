//
//  RRAnalyticsManager.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import "RRAnalyticsManager.h"
#import <UMAnalytics/MobClick.h>

@interface RRAnalyticsManager ()

@property (nonatomic, assign) NSString *current;

@property (nonatomic, assign) NSString *parent;

@end


@implementation RRAnalyticsManager

+ (instancetype)shared {
    static RRAnalyticsManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[RRAnalyticsManager alloc] init];
    });
    return shared;
}

+ (void)umeng_event:(nonnull NSString *)eventId {
    [MobClick event:eventId];
}

+ (void)umeng_event:(nonnull NSString *)eventId label:(NSString *)label {
    [MobClick event:eventId label:label];
}

+ (void)umeng_event:(nonnull NSString *)eventId parameters:(NSDictionary *)paramters {
    [MobClick event:eventId attributes:paramters];
}

+ (void)umeng_beginEvent:(nonnull NSString *)eventId {
    [MobClick beginEvent:eventId];
}

+ (void)umeng_beginEvent:(nonnull NSString *)eventId label:(NSString *)lable {
    [MobClick beginEvent:eventId label:lable];
}

+ (void)umeng_endEvent:(nonnull NSString *)eventId {
    [MobClick endEvent:eventId];
}

+ (void)umeng_endEvent:(nonnull NSString *)eventId label:(NSString *)label {
    [MobClick endEvent:eventId label:label];
}






@end
