//
//  RootViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"


@interface RootViewController : UITableViewController {
    NSMutableArray *projects;
}

@property (nonatomic, retain) NSMutableArray *projects;

@end
