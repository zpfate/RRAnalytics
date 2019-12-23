//
//  RRAnalyticsManager.h
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/18.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RRAnalyticsShared [RRAnalyticsManager shared]

NS_ASSUME_NONNULL_BEGIN

@interface RRAnalyticsManager : NSObject

+ (instancetype)shared;

- (void)analyticsStart;

- (void)rr_clickEvent:(NSString *)eventId parameters:(NSDictionary *)paramters;

- (void)rr_beginLogViewController:(UIViewController *)vc;

- (void)rr_endLogViewController:(UIViewController *)vc;

// 友盟统计分析
+ (void)um_beiginLogPageView:(UIViewController *)vc;

+ (void)um_endLogPageView:(UIViewController *)vc;

//+ (void)um_event:(nonnull NSString *)eventId;

+ (void)um_clickEventObj:(id)obj selector:(SEL)selector label:(NSString *)label;

+ (void)um_clickEvent:(nonnull NSString *)eventId label:(NSString *)label;

+ (void)um_clickEvent:(nonnull NSString *)eventId parameters:(NSDictionary *)paramters;


// 自定义事件时长统计
+ (void)um_beginEvent:(nonnull NSString *)eventId;

+ (void)um_beginEventObj:(id)obj selector:(SEL)selector label:(NSString *)label;

+ (void)um_beginEvent:(nonnull NSString *)eventId label:(NSString *)lable;

+ (void)um_endEvent:(nonnull NSString *)eventId;

+ (void)um_endEventObj:(id)obj selector:(SEL)selector label:(NSString *)label;

+ (void)um_endEvent:(nonnull NSString *)eventId label:(NSString *)label;
@end

NS_ASSUME_NONNULL_END
