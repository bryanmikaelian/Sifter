//
//  IssueView.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueWrapper.h"

@interface IssueView : UIView {
    IssueWrapper *issueWrapper;
    BOOL highlighted;
}

@property (nonatomic, retain) IssueWrapper *issueWrapper;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

@end
