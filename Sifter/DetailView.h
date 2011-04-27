//
//  DetailView.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueWrapper.h"

@interface DetailView : UIView {
    IssueWrapper *issueWrapper;
}


@property (nonatomic, retain) IssueWrapper *issueWrapper;

@end
