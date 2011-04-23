//
//  MilestoneViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueViewController.h"

@interface MilestoneViewController : UITableViewController {
    NSArray *milestones;
    IssueViewController *issueViewController;
}

@property (nonatomic, retain) NSArray *milestones;
@property (nonatomic, retain) IssueViewController *issueViewController;

- (id)initWithProjectURL:(NSString *)url andStyle:(UITableViewStyle)style;

@end
