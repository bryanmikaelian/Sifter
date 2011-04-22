//
//  RootViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "MilestoneViewController.h"

@interface RootViewController : UITableViewController {
    NSMutableArray *projects;
    MilestoneViewController *milestoneViewController;
}

@property (nonatomic, retain) NSMutableArray *projects;
@property (nonatomic, retain) MilestoneViewController *milestoneViewController;

@end
