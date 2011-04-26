//
//  IssueView.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IssueView.h"


@implementation IssueView
@synthesize issueWrapper;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    // Color and font for the issue subject and number
    UIFont *issueInfoFont = [UIFont boldSystemFontOfSize:14.0];
    CGPoint infoPoint, descriptionPoint;
    
    // Color and font for the issue description
    UIFont *issueDescription = [UIFont systemFontOfSize:12.0];
    
    // Draw the subject
    infoPoint = CGPointMake(10.0, 8.0);
    [issueWrapper.issueSubject drawAtPoint:infoPoint forWidth:250.0 withFont:issueInfoFont 
                               minFontSize:14.0 
                               actualFontSize:NULL 
                               lineBreakMode:UILineBreakModeWordWrap 
                               baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    // Draw the description
    descriptionPoint = CGPointMake(10.0, 24.0);
    [issueWrapper.issueDescription drawAtPoint:descriptionPoint forWidth:250.0 withFont:issueDescription 
                                   minFontSize:14.0 
                                   actualFontSize:NULL 
                                   lineBreakMode:UILineBreakModeWordWrap 
                                   baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    
}

 
- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

@end
