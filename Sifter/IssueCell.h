//
//  IssueCell.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueWrapper.h"
#import "IssueView.h"

@interface IssueCell : UITableViewCell {
    IssueView *issueView;
}

- (void)setIssueWrapper:(IssueWrapper *)newIssueWrapper;

@property (nonatomic, retain) IssueView *issueView;

@end
