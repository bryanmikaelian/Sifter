//
//  MilestoneViewController.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IssueViewController.h"
#import "Issue.h"
#import "IssueWrapper.h"
#import "IssueCell.h"

#define ROW_HEIGHT 75

@implementation IssueViewController

@synthesize issueWrappers;
@synthesize issueDetailViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithIssueURL:(NSString *)url andStyle:(UITableViewStyle)style {
    // Init the tableview with a given style
    self = [super initWithStyle:style];
    if (self) {
        // Set up the issue wrapper
        self.issueWrappers = [[NSMutableArray alloc] init];
        
        // Get all the issues and store them in an array
        NSMutableArray *issues = [Issue getIssuesWithAGivenURL:url];
        
        // Create an issue wrapper for each issue and add it to an array
        for (id issue in issues) {
            IssueWrapper *anIssueWrapper = [[[IssueWrapper alloc] initWithIssue:issue] autorelease];
            [self.issueWrappers addObject:anIssueWrapper];
        }
    }
    return self;
}

- (void)dealloc {
    [issueWrappers release];
    [issueDetailViewController release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    self.title = @"Issues";
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We have one section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is based on number of issues
    return [self.issueWrappers count];
}

#define ISSUE_SUBJECT_TAG 1

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"IssueCell";
    
    IssueCell *issueCell = (IssueCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (issueCell == nil) {
        issueCell = [[[IssueCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        issueCell.frame = CGRectMake(0.0, 0.0, 320.0, ROW_HEIGHT);
    }
    
    [issueCell setIssueWrapper:[self.issueWrappers objectAtIndex:indexPath.row]];
    issueCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return issueCell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.issueDetailViewController = [[IssueDetailViewController alloc] initWithIssue:[self.issueWrappers objectAtIndex:indexPath.row] andStyle:UITableViewStyleGrouped];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:self.issueDetailViewController animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

@end
