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
    UIFont *issueInfoFont = [UIFont systemFontOfSize:18.0];
    CGPoint point;
    
    
    // Draw the subject
    point = CGPointMake(10.0, 8.0);
    [issueWrapper.issueSubject drawAtPoint:point forWidth:110.0 withFont:issueInfoFont 
                               minFontSize:16.0 
                               actualFontSize:NULL 
                               lineBreakMode:UILineBreakModeTailTruncation 
                               baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    
}

 
- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

@end
