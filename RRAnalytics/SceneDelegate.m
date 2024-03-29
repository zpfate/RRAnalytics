#import "SceneDelegate.h"
#include "FirstViewController.h"
#import <UMCommon/UMCommon.h>

#import <UMAnalytics/MobClick.h>

#import <UMCommonLog/UMCommonLogHeaders.h>
@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    //此函数在UMCommon.framework版本1.4.2及以上版本，在UMConfigure.h的头文件中加入。
    //如果用户用组件化SDK,需要升级最新的UMCommon.framework版本。
    NSString * deviceID =[UMConfigure deviceIDForIntegration];
    NSLog(@"集成测试的deviceID:%@", deviceID);

    [UMConfigure initWithAppkey:@"5dcbc6ef4ca357936e0001ce" channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMCommonLogManager setUpUMCommonLogManager];
//    [MobClick setAutoPageEnabled:YES];
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene ];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.frame = windowScene.coordinateSpace.bounds;

    FirstViewController *vc = [FirstViewController new];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = naVC;
    
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 1000000; i++) {
        NSDictionary *dict = @{@"name": [NSString stringWithFormat:@"zz%d", i], @"sex": @"male", @"age" : [NSString stringWithFormat:@"%d", i]};
        [arr addObject:dict];
    }
    
    NSLog(@"开始写入---------");
    BOOL result = [arr writeToFile:[self cachePath] atomically:YES];
    NSLog(@"写入结果: %d", result);

    NSLog(@"开始提取---------");

    NSArray *local = [NSArray arrayWithContentsOfFile:[self cachePath]];
    NSLog(@"提取结束--------");
}

// 缓存目录
- (NSString *)cachePath {
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [cachesPath stringByAppendingPathComponent:@"rrana"];
    return path;
}
- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
