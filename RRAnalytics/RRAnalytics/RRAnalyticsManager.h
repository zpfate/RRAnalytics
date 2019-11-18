//
//  RRAnalyticsManager.h
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRAnalyticsManager : NSObject

+ (instancetype)shared;

- (void)analyticsStart;


- (void)clickEvent:(NSString *)eventId;
- (void)clickEvent:(NSString *)eventId desc:(NSString *)desc;

- (void)clickEvent:(NSString *)eventId paramters:(NSDictionary *)paramters;

- (void)beginPageView:(NSString *)eventId;
- (void)endPageView:(NSString *)eventId;


@end

NS_ASSUME_NONNULL_END
