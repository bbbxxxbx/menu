//
//  AppDelegate.m
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/8/22.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewController1.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    UITabBarController *tabbar = [[UITabBarController alloc] init] ;
    tabbar.view.backgroundColor = [UIColor whiteColor] ;
    ViewController *vc1 = [[ViewController alloc] init] ;
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"效果一" image:nil tag:1] ;
    vc1.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -15) ;
    ViewController1 *vc2 = [[ViewController1 alloc] init] ;
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"效果二" image:nil tag:2] ;
    vc2.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -15) ;
    [tabbar setViewControllers:@[vc1,vc2]] ;
    self.window.rootViewController = tabbar ;
    [self.window makeKeyAndVisible] ;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
