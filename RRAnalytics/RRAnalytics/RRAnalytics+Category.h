//
//  RRAnalytics+Category.h
//  RRAnalytics
//
//  Created by Twisted Fate on 2019/11/14.
//  Copyright © 2019 Twisted Fate. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RRAnalytics)


@end

@interface UIControl (RRAnalytics)



@end


@interface UIGestureRecognizer (RRAnalytics)

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *actionName;

@end


NS_ASSUME_NONNULL_END
