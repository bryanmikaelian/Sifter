//
//  IssueCell.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IssueCell.h"


@implementation IssueCell

@synthesize issueView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Create an issue view and add it is as a subview of the content view
        CGRect issueFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        issueView = [[IssueView alloc] initWithFrame:issueFrame];
        issueView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.contentView addSubview:issueView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIssueWrapper:(IssueWrapper *)newIssueWrapper {
    // Assign the wrapper to the view
    issueView.issueWrapper = newIssueWrapper;
}


- (void)redisplay {
    [issueView setNeedsDisplay];
}

- (void)dealloc {
    [issueView release];
    [super dealloc];
}

@end
