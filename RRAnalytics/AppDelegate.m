//
//  AppDelegate.m
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/13.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
  //此函数在UMCommon.framework版本1.4.2及以上版本，在UMConfigure.h的头文件中加入。
    //如果用户用组件化SDK,需要升级最新的UMCommon.framework版本。
    NSString * deviceID = [UMConfigure deviceIDForIntegration];
    NSLog(@"集成测试的deviceID:%@", deviceID);


    //老版本iOS统计SDK请使用如下代码段：
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if (cls && [cls respondsToSelector: deviceIDSelector]) {
//        deviceID = [cls performSelector: deviceIDSelector];
//    }
//    NSData * jsonData =[NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//    options: NSJSONWritingPrettyPrinted
//    error: nil];
//    NSLog(@"%@", [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding]);
    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
