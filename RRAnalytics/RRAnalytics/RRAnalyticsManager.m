//
//  RRAnalyticsManager.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import "RRAnalyticsManager.h"
#import "RRAnalytics.h"
NSString *const kRRAnalyticsEventIdKey = @"kRRAnalyticsEventIdKey";
NSString *const kRRAnalyticsEventDescriptionKey = @"kRRAnalyticsEventDescriptionKey";
NSString *const kRRAnalyticsEventParametersKey = @"kRRAnalyticsEventParametersKey";
NSString *const kRRAnalyticsEventLastKey = @"kRRAnalyticsEventLastKey";

@interface RRAnalyticsManager ()

@property (nonatomic, strong) NSMutableArray *analytics_list;
@property (nonatomic, assign) NSInteger timeCount;

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

- (void)analyticsStart {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationEnterBackground:(NSNotification *)notification {

    UIApplication *application = (UIApplication *)notification.object;
    __block UIBackgroundTaskIdentifier taskId;
    [application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"在这里处理上报事件");
        
        [application endBackgroundTask:taskId];
        taskId = UIBackgroundTaskInvalid;
    }];
}

- (void)clickEvent:(NSString *)eventId {
    
    [RRAnalytics um_event:eventId];
}

- (void)clickEvent:(NSString *)eventId desc:(NSString *)desc {
    
}

- (void)clickEvent:(NSString *)eventId paramters:(NSDictionary *)paramters {
    
}

- (void)beginPageView:(NSString *)eventId {
    [RRAnalytics um_beginEvent:eventId];
}

- (void)endPageView:(NSString *)eventId {
    [RRAnalytics um_endEvent:eventId];

    
}

@end
