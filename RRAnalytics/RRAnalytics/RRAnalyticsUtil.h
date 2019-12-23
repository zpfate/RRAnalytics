//
//  RRAnalyticsUtil.h
//  RoadRescue
//
//  Created by Twisted Fate on 2019/11/21.
//  Copyright © 2019 Zhilun (Hangzhou) Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRAnalyticsUtil : NSObject

+ (NSString *)devicePPi;

+ (void)createFileWithList:(NSMutableArray *)list completionHandle:(void(^)(BOOL result))completionHandle;
+ (void)deleteFile;

@end

NS_ASSUME_NONNULL_END
