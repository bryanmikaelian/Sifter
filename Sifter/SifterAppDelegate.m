//
//  SifterAppDelegate.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SifterAppDelegate.h"
#import "RootViewController.h"
#import "SearchViewController.h"

@implementation SifterAppDelegate


@synthesize window=_window;
@synthesize navigationController;
@synthesize rootViewController;
@synthesize tabBarController;
@synthesize searchViewController;
@synthesize searchNavigationController;

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
    UIImage *anImage = [UIImage imageNamed:@"tray_full.png"];
    UITabBarItem *anItem = [[UITabBarItem alloc] initWithTitle:@"Project Issues" image:anImage tag:0];
    self.navigationController.tabBarItem = anItem;
    [anItem release];
    
    // Set up the search view controller
    SearchViewController *aSearchViewController = [[SearchViewController alloc] initWithData];
    self.searchViewController = aSearchViewController;
    [aSearchViewController release];
    
    // Set up the search view controller's navigation controller
    UINavigationController *aSecondNavigationController = [[UINavigationController alloc] initWithRootViewController:self.searchViewController];
    aSecondNavigationController.title = @"Search";
    self.searchNavigationController = aSecondNavigationController;
    [aSecondNavigationController release];
    
    // Set up a tab bar item for the view controller
    UITabBarItem *aSystemItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    self.searchNavigationController.tabBarItem = aSystemItem;
    [aSystemItem release];

    // Add the views to the tab bar controller
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.navigationController, self.searchNavigationController, nil];
    
    // Add the tab bar controller's view to the window.
    [self.window addSubview:[self.tabBarController view]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [navigationController release];
    [rootViewController release];
    [tabBarController release];
    [searchViewController release];
    [searchNavigationController release];
    [super dealloc];
}

@end
