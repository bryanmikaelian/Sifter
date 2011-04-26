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

@implementation IssueViewController

@synthesize issueWrappers;

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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.text = [[self.issueWrappers objectAtIndex:indexPath.row] issueSubject];
        cell.tag = ISSUE_SUBJECT_TAG;
    }
    
    // Put each cell's text as the issue name.
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
