//
//  RRAnalyticsManager.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/18.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import "RRAnalyticsManager.h"
#import <UMAnalytics/MobClick.h>
#import "RRAnalyticsUtil.h"

static NSString *const kAnalyticsDataKey = @"RR_Analytics";

@interface RRAnalyticsManager ()

@property (nonatomic, strong) NSMutableArray *analytics_list;
@property (nonatomic, copy) NSString *devicePPi;
@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, assign) NSInteger userId;

@end

@implementation RRAnalyticsManager

static NSMutableString *analytics_string = nil;

+ (instancetype)shared {
    
    static RRAnalyticsManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[RRAnalyticsManager alloc] init];
    });
    return shared;
}

- (void)analyticsStart {
    
    // 上报大数据
    [self uploadAnalyticsCompletionHandle:^(BOOL result) {
        if (result) {
    
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

// app失活
- (void)appResignActive:(NSNotification *)notification {
 
    UIApplication *application = (UIApplication *)notification.object;
    __block UIBackgroundTaskIdentifier taskIdentifier;
    taskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        // 后台任务结束
        [application endBackgroundTask:taskIdentifier];
        taskIdentifier = UIBackgroundTaskInvalid;
    }];
    
    
    
     [application endBackgroundTask:taskIdentifier];
     taskIdentifier = UIBackgroundTaskInvalid;
}

- (void)uploadAnalyticsCompletionHandle:(void(^)(BOOL result))completionHandle {
    
    
    
//    NSArray *analytics = SDUD setObject:<#(nullable id)#> forKey:<#(nonnull NSString *)#>

}

- (void)rr_beginLogViewController:(UIViewController *)vc {
    
    self.beginDate = [NSDate date];
}

- (void)rr_endLogViewController:(UIViewController *)vc {
    
//    NSTimeInterval distance = [[NSDate date] timeIntervalSinceDate:self.beginDate];
//    double latitude = [RRLocationManager sharedManager].currentLocation.coordinate.latitude;
//    double longitude = [RRLocationManager sharedManager].currentLocation.coordinate.longitude;
//    NSTimeInterval timeInterval = [self.beginDate timeIntervalSince1970] * 1000;
//    NSDictionary *parameters = @{
//        @"visitTime" : [NSString stringWithFormat:@"%f", timeInterval],     // 访问时间戳
//        @"staySecond" : [NSString stringWithFormat:@"%f", distance],        // 停留时长
//        @"latitude" : [NSString stringWithFormat:@"%f", latitude],          // 经度
//        @"longitude" : [NSString stringWithFormat:@"%f", longitude],        // 纬度
//        @"uuid" : [RoadRescueUtil UUIDString],                                // 手机唯一标识
//        @"userId" : [NSString stringWithFormat:@"%zd", self.userId],        // 用户ID
//        @"title" : vc.title ?: NSStringFromClass(vc.class),               // 页面标题
//        @"osSystem" : @"iOS",                                                   // 操作系统
//        @"ppi" : self.devicePPi ?: @"0",                                       // 分辨率
//        @"appName" : [RoadRescueUtil appName],                                // app名称
//        @"pageType" : @"page",                                              // 日志记录的类型(页面page 或 button按钮)
////        @"extInfo" : @"",
////        @"buttonName": @""
//    };
//    if (self.beginDate) {
//        [self.analytics_list addObject:parameters];
//    }
//    // 置为空,依此判断有执行进入页面方法
//    self.beginDate = nil;
}

- (void)rr_clickEvent:(NSString *)eventId parameters:(NSDictionary *)paramters {

    
    
    
    [self.analytics_list addObject:paramters];
}

#pragma mark -- Umeng Analytics

+ (void)um_beiginLogPageView:(UIViewController *)vc {
    
    [MobClick beginLogPageView:NSStringFromClass([vc class])];
}

+ (void)um_endLogPageView:(UIViewController *)vc {
    
    [MobClick endLogPageView:NSStringFromClass([vc class])];
}

+ (void)um_event:(nonnull NSString *)eventId {
    
    [MobClick event:eventId];
}

+ (void)um_clickEventObj:(id)obj selector:(SEL)selector label:(NSString *)label {
    
    NSString *eventId = [self event:obj selector:selector];
    [self um_clickEvent:eventId label:label];
}

+ (void)um_clickEvent:(nonnull NSString *)eventId label:(NSString *)label {
    
    // log
    NSString *string = [NSString stringWithFormat:@"%@  %@  0\n",eventId, label];
    if (!analytics_string) {
        analytics_string = [NSMutableString string];
    }
    if (![analytics_string containsString:string]) {
        [analytics_string appendString:string];
    }
    [MobClick event:eventId label:label];
}

+ (void)um_clickEvent:(nonnull NSString *)eventId parameters:(NSDictionary *)paramters {
    
    [MobClick event:eventId attributes:paramters];
}

+ (void)um_beginEvent:(nonnull NSString *)eventId {
    
    [MobClick beginEvent:eventId];
}

+ (void)um_beginEventObj:(id)obj selector:(SEL)selector label:(NSString *)label {
   
    NSString *eventId = [self event:obj selector:selector];
    [self um_beginEvent:eventId label:label];
}

+ (void)um_beginEvent:(nonnull NSString *)eventId label:(NSString *)label {
    
    [MobClick beginEvent:eventId label:label];
}

+ (void)um_endEvent:(nonnull NSString *)eventId {
    
    [MobClick endEvent:eventId];
}

+ (void)um_endEventObj:(id)obj selector:(SEL)selector label:(NSString *)label {
    
    NSString *eventId = [self event:obj selector:selector];
    [self um_endEvent:eventId label:label];
}

+ (void)um_endEvent:(nonnull NSString *)eventId label:(NSString *)label {
    
    [MobClick endEvent:eventId label:label];
}

+ (NSString *)event:(id)obj selector:(SEL)selector {
    
    NSString *selctorString = NSStringFromSelector(selector);
    if ([selctorString containsString:@":"]) {
        selctorString = [selctorString stringByReplacingOccurrencesOfString:@":" withString:@""];
    }
    NSString *eventId = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([obj class]), selctorString];
    return eventId;
}

#pragma mark -- Getter

- (NSInteger)userId {
    
    if (!_userId) {
//        NSString *loginModelStr = [SDUD objectForKey:kLoginModel];
//        NSError *err;
//        RRLoginModel *loginModel = [[RRLoginModel alloc] initWithString:loginModelStr error:&err];
//        _userId = loginModel.userId;
    }
    return _userId;
}

- (NSString *)devicePPi {
    if (!_devicePPi) {
        _devicePPi = [RRAnalyticsUtil devicePPi];
    }
    return _devicePPi;
}

- (NSMutableArray *)analytics_list {
    if (!_analytics_list) {
        _analytics_list = [NSMutableArray array];
    }
    return _analytics_list;
}
@end
