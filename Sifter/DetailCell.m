//
//  DetailCell.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailCell.h"


@implementation DetailCell

@synthesize detailView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier issue:(IssueWrapper *)issueWrapper {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Create an detail view and add it is as a subview of the content view.  We have to do some adjustments since we are doing rounded corners.
        CGRect detailFrame = CGRectMake(5.0, 5.0, self.contentView.bounds.size.width - 10, self.contentView.bounds.size.height - 10);
        detailView = [[DetailView alloc] initWithFrame:detailFrame];
        detailView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        detailView.issueWrapper = issueWrapper;
        [self.contentView addSubview:detailView];
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}

@end
