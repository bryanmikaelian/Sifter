//
//  SearchViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UITableViewController <UITableViewDelegate, UISearchDisplayDelegate> {
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *filteredData;
    NSMutableArray *allProjects;
    NSMutableArray *allMilestones;
}


@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchController;
@property (nonatomic, retain) NSMutableArray *filteredData;
@property (nonatomic, retain) NSMutableArray *allProjects;
@property (nonatomic, retain) NSMutableArray *allMilestones;

@end
