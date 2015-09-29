//
//  AppDelegate.m
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-07.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"
#import <Parse/Parse.h>
#import "LogInViewController.h"
#import <StartApp/StartApp.h>
#import <VungleSDK/VungleSDK.h>



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"ivim1M4YFACxJq87dTedBPPxhu82OtMCXl5w4I9L"
                  clientKey:@"BfyJp3yhIiXhF9UWOz0LWswFxJeVd4RDUoNzGIIT"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
    sdk.appID = @"208301987";
    NSString* appID = @"55fd598c80fbbf102800001a";
    VungleSDK* sdk2 = [VungleSDK sharedSDK];
    // start vungle publisher library
    [sdk2 startWithAppId:appID];
    [[VungleSDK sharedSDK] setDelegate:nil];
    
    
    MainMenuViewController *viewController = [MainMenuViewController new];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    if(![PFUser currentUser]){
        LogInViewController *loginViewController = [LogInViewController new];
        [self.window.rootViewController presentViewController:loginViewController animated:YES completion:nil];
    }

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
