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

@property (nonatomic, copy) NSString *eventId; // 标识事件 className + actionName
@property (nonatomic, copy) NSString *desc;    // 描述
@property (nonatomic, assign, setter=setEventExposure:) BOOL isExposure; // 是否是曝光事件
@property (nonatomic, strong, setter=setExtralParamerters:) NSDictionary *parameters; // 额外参数

- (instancetype)initWithEvent:(NSString *)eventId;

- (instancetype)initWithExposureEvent:(NSString *)eventId;
@end

@interface RRAnalytics : NSObject

+ (void)um_event:(nonnull NSString *)eventId;

+ (void)um_event:(nonnull NSString *)eventId label:(NSString *)label;

+ (void)um_event:(nonnull NSString *)eventId parameters:(NSDictionary *)paramters;

+ (void)um_beginEvent:(nonnull NSString *)eventId;

+ (void)um_beginEvent:(nonnull NSString *)eventId label:(NSString *)lable;

+ (void)um_endEvent:(nonnull NSString *)eventId;

+ (void)um_endEvent:(nonnull NSString *)eventId label:(NSString *)label;

@end

NS_ASSUME_NONNULL_END
