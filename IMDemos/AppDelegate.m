//
//  AppDelegate.m
//  IMDemos
//
//  Created by oumeng on 2019/3/5.
//  Copyright © 2019 OYKM. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "IMSocketUtils.h"
#import "IMChatViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [defaults objectForKey:@"isLogin"];
    if ([isLogin integerValue]!=1) {
        LoginViewController *loginVc = [[LoginViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVc];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = navi;
    } else {
        IMChatViewController *loginVc = [[IMChatViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVc];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = navi;
    }
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[IMSocketUtils sharedManager] cutOffSocket];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [defaults objectForKey:@"isLogin"];

    if ([isLogin integerValue]!=1) {
        NSDictionary *dicts = @{@"name":[defaults objectForKey:@"accout"],@"pwd":[defaults objectForKey:@"pwd"],@"receiverId":[defaults objectForKey:@"receiverId"]};
        [[LoginUtil sharedManager] loginAgainWithUser:dicts loginBlock:^{
            [[IMSocketUtils sharedManager] getIMServer];
        }];
    } else {
//        [[IMSocketUtils sharedManager] reconnectToServer];
        [[IMSocketUtils sharedManager] getIMServer];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
