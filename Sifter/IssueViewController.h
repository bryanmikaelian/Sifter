//
//  IssueViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueDetailViewController.h"

@interface IssueViewController : UITableViewController {
    NSMutableArray *issueWrappers;
    IssueDetailViewController *issueDetailViewController;
}

@property (nonatomic, retain) NSMutableArray *issueWrappers;
@property (nonatomic, retain) IssueDetailViewController *issueDetailViewController;

- (id)initWithIssueURL:(NSString *)url andStyle:(UITableViewStyle)style;

@end
