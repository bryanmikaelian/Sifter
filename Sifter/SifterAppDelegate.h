//
//  SifterAppDelegate.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SifterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
	RootViewController *rootViewController;
    UITabBarController *tabBarController;
    UIViewController *searchViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UIViewController *searchViewController;

@end
