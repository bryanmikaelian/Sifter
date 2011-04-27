//
//  DetailCell.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@interface DetailCell : UITableViewCell {
    DetailView *detailView;
}

@property (nonatomic, retain) DetailView *detailView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier issue:(IssueWrapper *)issueWrapper;

@end
