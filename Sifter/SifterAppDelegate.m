//
//  SifterAppDelegate.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SifterAppDelegate.h"
#import "RootViewController.h"

@implementation SifterAppDelegate


@synthesize window=_window;
@synthesize navigationController;
@synthesize rootViewController;
@synthesize tabBarController;
@synthesize searchViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set up the tab bar controller
    UITabBarController *aTabBarController = [[UITabBarController alloc] init];
    self.tabBarController = aTabBarController;
    [aTabBarController release];
        
    // Set up the RootViewController
    RootViewController *aRootViewController = [[RootViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.rootViewController = aRootViewController;
    [aRootViewController release];
        
    // Set up the navigation controller with its root controller.
    UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:aRootViewController];
    self.navigationController = aNavigationController;
    [aNavigationController release];
    
    // Set up a tab bar item for the navigation controller
    UIImage *anImage = [UIImage imageNamed:@"case_30.png"];
    UITabBarItem *anItem = [[UITabBarItem alloc] initWithTitle:@"Project Issues" image:anImage tag:0];
    [anImage release];
    self.navigationController.tabBarItem = anItem;
    [anItem release];
    
    // Set up the search view controller
    UIViewController *aViewController = [[UIViewController alloc] init];
    self.searchViewController = aViewController;
    [aViewController release];
    
    // Set up a tab bar item for the view controller
    UITabBarItem *aSystenItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    self.searchViewController.tabBarItem = aSystenItem;
    [aSystenItem release];

    // Add the views to the tab bar controller
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.navigationController, self.searchViewController, nil];
    
    // Add the tab bar controller's view to the window.
    [self.window addSubview:[self.tabBarController view]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [navigationController release];
    [rootViewController release];
    [tabBarController release];
    [searchViewController release];
    [super dealloc];
}

@end
