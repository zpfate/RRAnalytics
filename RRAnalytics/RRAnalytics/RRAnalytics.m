//
//  RRAnalytics.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/15.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "RRAnalytics.h"

@implementation RRAnalyticsInfo

- (instancetype)initWithEvent:(NSString *)eventId  {
    
    if (self = [super init]) {
        _eventId = eventId;
        _isExposure = NO;
    }
    return self;
}

- (instancetype)initWithExposureEvent:(NSString *)eventId  {
    
    if (self = [super init]) {
        _eventId = eventId;
        _isExposure = YES;
    }
    return self;
}

@end


@implementation RRAnalytics

+ (void)um_event:(nonnull NSString *)eventId {
    [MobClick event:eventId];
}

+ (void)um_event:(nonnull NSString *)eventId label:(NSString *)label {
    [MobClick event:eventId label:label];
}

+ (void)um_event:(nonnull NSString *)eventId parameters:(NSDictionary *)paramters {
    [MobClick event:eventId attributes:paramters];
}

+ (void)um_beginEvent:(nonnull NSString *)eventId {
    [MobClick beginEvent:eventId];
}

+ (void)um_beginEvent:(nonnull NSString *)eventId label:(NSString *)lable {
    [MobClick beginEvent:eventId label:lable];
}

+ (void)um_endEvent:(nonnull NSString *)eventId {
    [MobClick endEvent:eventId];
}

+ (void)um_endEvent:(nonnull NSString *)eventId label:(NSString *)label {
    [MobClick endEvent:eventId label:label];
}



@end
