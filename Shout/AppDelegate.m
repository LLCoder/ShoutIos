//
//  AppDelegate.m
//  Shout
//
//  Created by shana on 14-9-7.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginNibViewController.h"
#import "WelcomeViewController.h"
#import "MainViewController.h"
#import "ShareManager.h"
#import "MainModel.h"
#import "PayofManager.h"

@implementation AppDelegate
@synthesize mainNav;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if (IOS7_OR_LATER)
    {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.window.clipsToBounds =YES;
//        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
//        //Added on 19th Sep 2013
//        self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    }
    if (nil == [PublicFunction isFirst]
        || ![[PublicFunction isFirst] isEqualToString:@"1"]) {
        [self goWelcomeController];
    }
    else{
        [self goLoginController];
    }
    
    //第三方分享
    [[ShareManager sharedInstance]start];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)goWelcomeController{
    
    WelcomeViewController* lc = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:nil];
    
    self.window.rootViewController = lc;
}

-(void)goLoginController{
    
    LoginNibViewController* lc = [[LoginNibViewController alloc] initWithNibName:@"LoginNibViewController" bundle:nil];
    if (nil == mainNav) {
        
        mainNav = [[UINavigationController alloc] initWithRootViewController:lc];
    }
    else{
        [mainNav setViewControllers:[NSArray arrayWithObject:lc]];
    }
    self.window.rootViewController = mainNav;
}

-(void)goMainViewController{
    
    MainViewController* lc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    if (nil == mainNav) {
        
        mainNav = [[UINavigationController alloc] initWithRootViewController:lc];
    }
    else{
        [mainNav setViewControllers:[NSArray arrayWithObject:lc]];
    }
    self.window.rootViewController = mainNav;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[[PayofManager sharedInstance] parse:url application:application];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
