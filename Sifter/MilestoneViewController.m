//
//  MilestoneViewController.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MilestoneViewController.h"
#import "Milestone.h"

@implementation MilestoneViewController

@synthesize selectedURL;
@synthesize milestones;
@synthesize issueViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithProjectURL:(NSString *)url andStyle:(UITableViewStyle)style {
    // Init the tableview with a given style
    self = [super initWithStyle:style];
    if (self) {
        // Set the URL
        self.selectedURL = url;
        // Get all the miletones for a given project
        self.milestones = [Milestone getProjectMilestonesWithGivenProjectURL:self.selectedURL];
    }
    return self;
}



- (void)dealloc {
    [milestones release];
    [issueViewController release];
    [selectedURL release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    self.title = @"Project";
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We have two sections unless there are no milestones
    if ([self.milestones count] > 0 ) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Section 1 will have 1 row.  Section two will have the number of rows equal to the number of milestones.
    if (section == 0) {
        return 1;
    }
    else
        return [self.milestones count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return @"Milestones";
    }
    else {
        return nil;
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if([self.milestones count] == 0) {
        return @"No Active Milestones";
    }
    else {
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // If there are milestones, put each cell's text as the milestone name.
    if (indexPath.section == 1) {
        cell.textLabel.text = [[self.milestones objectAtIndex:indexPath.row] valueForKey:@"name"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    // Section 0 will always allow the user the select all the issues for a project.
    else {
        cell.textLabel.text = @"All issues";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
        
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // If we select a milestone cell, get the URL, init the new View Controller and push it
    if (indexPath.section == 1) {
        NSString *milestoneIssueURL = [[self.milestones objectAtIndex:indexPath.row] valueForKey:@"api_issues_url"];
        self.issueViewController = [[IssueViewController alloc] initWithIssueURL:milestoneIssueURL 
                                                                                  andStyle:UITableViewStylePlain];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:self.issueViewController animated:YES];
    }
    
    else {
        // Replace the milestones resource with just issues since we are just getting all the issues for the project.
        NSString *projectIssuesURL = [self.selectedURL stringByReplacingOccurrencesOfString:@"/milestones" withString:@"/issues"];
        self.issueViewController = [[IssueViewController alloc] initWithIssueURL:projectIssuesURL 
                                                                                 andStyle:UITableViewStylePlain];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:self.issueViewController animated:YES];
    }
}

@end
