//
//  SearchViewController.m
//  Sifter
//
//  Created by Bryan Mikaelian on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "Project.h"
#import "Milestone.h"

@implementation SearchViewController

@synthesize searchBar;
@synthesize searchController;
@synthesize filteredData;
@synthesize allProjects;
@synthesize allMilestones;
@synthesize milestoneViewController;
@synthesize issueViewController;

- (void)dealloc {
    [super dealloc];
    [searchBar release];
    [searchController release];
    [allProjects release];
    [allMilestones release];
    [milestoneViewController release];
    [issueViewController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
 

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Hold the filtered data
    self.filteredData = [[NSMutableArray alloc] init];
    
    // Hold the milestones
    self.allMilestones = [[NSMutableArray alloc] init];
    
    // Configure the search bar and its controller
    self.searchBar = [[UISearchBar alloc] initWithFrame:self.tableView.tableHeaderView.frame];
    self.searchBar.placeholder = @"Search";
    [self.searchBar sizeToFit];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchBar.tintColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Configure the scope bar.  We will have Projects, Milestones, and Issues.
    self.searchController.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"Projects", @"Milestones", @"Issues", nil];
    
    // Configure the navigation controller's navigation bar
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    self.title = @"Search";
    
    // "Hide" the cells.
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.separatorColor = [UIColor grayColor];
    
    // No scrolling here
    self.tableView.scrollEnabled = NO;
    
    [self.tableView reloadData];
        
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredData count];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Show the filtered data if we are searching and its search results table is present
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [[self.filteredData objectAtIndex:indexPath.row] valueForKey:@"name"];
    }
  
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // Which scope is selected?
        if ([self.searchDisplayController.searchBar selectedScopeButtonIndex] == 0) {
            // Projects scope was selected
            NSString *milestoneURL = [[self.filteredData objectAtIndex:indexPath.row] valueForKey:@"api_milestones_url"];
            self.milestoneViewController = [[MilestoneViewController alloc] initWithProjectURL:milestoneURL 
                                                                                      andStyle:UITableViewStyleGrouped];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            // Hide the keyboard
            [self.searchDisplayController.searchBar resignFirstResponder];
            
            [[self navigationController] pushViewController:self.milestoneViewController animated:YES];
        }
        else if ([self.searchDisplayController.searchBar selectedScopeButtonIndex] == 1) {
            // Milestones was selected
            NSString *issuesURL = [[self.filteredData objectAtIndex:indexPath.row] valueForKey:@"api_issues_url"];
            self.issueViewController = [[IssueViewController alloc] initWithIssueURL:issuesURL 
                                                                                      andStyle:UITableViewStylePlain];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            // Hide the keyboard
            [self.searchDisplayController.searchBar resignFirstResponder];
            
            [[self navigationController] pushViewController:self.issueViewController animated:YES];
            
        }
    }
}
 

#pragma mark - Search Display Controller delegate 
- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString*)scope {
    
    // Which scope are we doing?
    if (scope == @"Projects") {
        // Clear all the filtered projects
        [self.filteredData removeAllObjects];
                
        // Filter on the projects as a search occurs
        for (id project in self.allProjects) {
            NSRange projectResults = [[project valueForKey:@"name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (projectResults.length > 0) {
                [self.filteredData addObject:project];
            }
        }
    }
    
    else if (scope == @"Milestones") {
        // Remove all the objects
        [self.filteredData removeAllObjects];
        
        // Filter on the milestones as a search occurs
        for (id milestone in self.allMilestones) {
            NSRange milestoneResults = [[milestone valueForKey:@"name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (milestoneResults.length > 0) {
                [self.filteredData addObject:milestone];
            }
        }
    }
    
    else if (scope == @"Issues") {
        [self.filteredData removeAllObjects];
    }
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];

    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchController.searchBar text] scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
 
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    // Get all the projects
    self.allProjects = [Project getAllProjectsFromSifter];
    
    // Get all the milestones
    for (id project in self.allProjects) {
        // With each project, we need to get all of the milestones for that project
        [self.allMilestones addObjectsFromArray:[Milestone getProjectMilestonesWithGivenProjectURL:[project valueForKey:@"api_milestones_url"]]];
    }   
}

@end
