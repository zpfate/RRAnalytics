//
//  RRAnalytics.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/15.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "RRAnalytics.h"

@implementation RRAnalytics


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
