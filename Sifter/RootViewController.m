//
//  RootViewController.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize projects;
@synthesize milestoneViewController;

- (void)dealloc {
    [projects release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    // Set the title
    self.navigationController.navigationBar.topItem.title = @"Projects";
    
    // Table View
    self.tableView.opaque = YES;
    
    // Navigation Bar
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    
    // Get the projects
    self.projects = [Project getAllProjectsFromSifter];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    self.projects = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only one section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows = number of projects.
    return [self.projects count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Unarchived Projects";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set the cell's text to the project name and the accessory type with the disclosure icon
    cell.textLabel.text = [[self.projects objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *milestoneURL = [[self.projects objectAtIndex:indexPath.row] valueForKey:@"api_milestones_url"];
    self.milestoneViewController = [[MilestoneViewController alloc] initWithProjectURL:milestoneURL 
                                                                               andStyle:UITableViewStyleGrouped];
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:self.milestoneViewController animated:YES];
}

@end
