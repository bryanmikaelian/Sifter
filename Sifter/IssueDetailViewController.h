//
//  IssueDetailViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueWrapper.h"

@interface IssueDetailViewController : UITableViewController {
    
}

- (id)initWithIssue:(IssueWrapper *)issue andStyle:(UITableViewStyle)style;

@end
