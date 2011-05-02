//
//  SearchViewController.h
//  Sifter
//
//  Created by Bryan Mikaelian on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UITableViewController <UISearchDisplayDelegate> {
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}


@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchController;

@end
