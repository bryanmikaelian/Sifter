//
//  IssueDetailViewController.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IssueDetailViewController.h"
#import "DetailCell.h"

#define MAX_ROW_HEIGHT 500

@implementation IssueDetailViewController

@synthesize issueWrapper;

- (id)initWithIssue:(IssueWrapper *)issue andStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.issueWrapper = issue;
    }
    return self;
}

- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    self.title = @"Issue Details";
    
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // One section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Only one row
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [@"Details For Issue #" stringByAppendingString:self.issueWrapper.issueNumber];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [@"Issue Status: " stringByAppendingString:self.issueWrapper.issueStatus];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DetailCell";
        
    DetailCell *detailCell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (detailCell == nil) {
        detailCell = [[[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier issue:self.issueWrapper] autorelease];
        detailCell.frame = CGRectMake(0.0, 0.0, 320.0, MAX_ROW_HEIGHT);
        detailCell.userInteractionEnabled = NO;
    }
    
    return detailCell;
}


#pragma mark - Table view delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
#define TOTAL_OFFSETS_USED 20
    CGSize boundingSizeSubject = CGSizeMake(285, CGFLOAT_MAX);
    
    CGSize subjectSize =  [self.issueWrapper.issueSubject sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:boundingSizeSubject lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize categorySize = [self.issueWrapper.issueCategory sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(285.0, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize descriptionSize = [self.issueWrapper.issueDescription sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(285.0, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return subjectSize.height + categorySize.height  + descriptionSize.height + TOTAL_OFFSETS_USED;
}
@end
