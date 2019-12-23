//
//  RRAnalyticsUtil.m
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/21.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import "RRAnalyticsUtil.h"
#import "sys/utsname.h"

static NSString *const kAnalyticsFileName = @"com.zhilunkeji.analytics";

@implementation RRAnalyticsUtil


+ (NSString *)path {
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [cachesPath stringByAppendingPathComponent:kAnalyticsFileName];
    return path;
}

+ (void)createFileWithList:(NSMutableArray *)list completionHandle:(void(^)(BOOL result))completionHandle {
    
    NSString *path = [self path];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSArray *localList = [NSArray arrayWithContentsOfFile:path];
        [list addObjectsFromArray:localList];
    }
    BOOL result = [list writeToFile:path atomically:YES];
    completionHandle(result);
}

+ (void)deleteFile {
    
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:[self path] error:nil];
    if (result) {
        NSLog(@"delete analytics data successfully");
    } else {
        NSLog(@"delete analytics data failed");
    }
}


// ppi
+ (NSString *)devicePPi {
    
    NSDictionary *ppiDict = @{
        @"iPhone 4": @"320*480pt",
        @"Verizon iPhone 4": @"320*480pt",
        @"iPhone 4s": @"320*480pt",
        @"iPhone 5":@"320*480pt",
        @"iPhone 5C":@"320*480pt",
        @"iPhone 5S":@"320*480pt",
        @"iPhone 6 Plus": @"414*736pt",
        @"iPhone 6": @"375*667pt",
        @"iPhone 6s": @"375*667pt",
        @"iPhone 6s Plus": @"414*736pt",
        @"iPhone SE": @"320*480pt",
        @"iPhone 7": @"375*667pt",
        @"iPhone 7 Plus": @"414*736pt",
        @"iPhone 8": @"375*667pt",
        @"iPhone 8 Plus": @"414*736pt",
        @"iPhone X": @"375*812pt",
        @"iPhone XR": @"414*896pt",
        @"iPhone XS": @"375*812pt",
        @"iPhone XS Max": @"414*896pt",
        @"iPhone 11": @"414*896pt",
        @"iPhone 11 Pro": @"375*812pt",
        @"iPhone 11 Pro Max": @"414*896pt",
    };
    
    NSString *device = [self deviceType];
    NSString *ppi = ppiDict[device];
    return ppi;
}

// deviceType
+ (NSString *)deviceType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    return deviceString;
}

@end
