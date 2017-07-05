//
//  AppDelegate.m
//  CYShareSheetView
//
//  Created by 小禹宝宝 on 2017/7/5.
//  Copyright © 2017年 cy55. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    //获得导航栏外观代理类 [UINavigationBar appearance]
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    navigationBarAppearance.translucent = NO;
    [navigationBarAppearance setBarTintColor:[UIColor colorWithRed:1 green:0.39 blue:0.3 alpha:1]];
    //设置导航栏中间title的字体和颜色
    navigationBarAppearance.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:               [UIColor whiteColor],
                                                   NSForegroundColorAttributeName,
                                                   [UIFont boldSystemFontOfSize:17],
                                                   NSFontAttributeName,
                                                   nil];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
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
