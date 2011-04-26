//
//  MilestoneViewController.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IssueViewController.h"
#import "Issue.h"

@implementation IssueViewController

@synthesize issues;

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
        // Get all the issues
        self.issues = [Issue getIssuesWithAGivenURL:url];
    }
    return self;
}

- (void)dealloc {
    [issues release];
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
    return [self.issues count];
}

#define ISSUE_SUBJECT_TAG 1

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.text = [[self.issues objectAtIndex:indexPath.row] valueForKey:@"subject"];
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
