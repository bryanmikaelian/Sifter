//
//  IssueViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IssueViewController : UITableViewController {
    NSArray *issues;
}

@property (nonatomic, retain) NSArray *issues;

- (id)initWithIssueURL:(NSString *)url andStyle:(UITableViewStyle)style;

@end
