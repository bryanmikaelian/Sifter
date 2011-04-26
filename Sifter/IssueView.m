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
#define LEFT_OFFSET 10
#define CONTENT_WIDTH 275
#define VERTICAL_OFFSET 6
#define DESCRIPTION_OFFSET 24
    
    // Color and font for the issue subject and number
    UIFont *issueInfoFont = [UIFont boldSystemFontOfSize:14.0];
    CGPoint subjectPoint, descriptionPoint;
    
    // Color and font for the issue description
    UIFont *issueDescriptionFont = [UIFont systemFontOfSize:12.0];
    
    // Draw the subject
    
    // Specify the point where we want to place the info
    subjectPoint = CGPointMake(LEFT_OFFSET, VERTICAL_OFFSET);
    
    // Because the subject can be several lines, we will need to figure out the size needed for the height of the rectangle that will hold this text.
    CGSize boundingSize = CGSizeMake(CONTENT_WIDTH, CGFLOAT_MAX);  // Ideally we want all the space!
    
    // Set the size to be equal to the font, with the constaint set to the bounding size.  Issue subjects can never exceed 200 characters, so three lines would be used at most.
    CGSize requiredSize = [issueWrapper.issueSubject sizeWithFont:issueInfoFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];

    // Create a rectangle to hold this text.  The height is equal to the required size.
    CGRect infoRectangle = CGRectMake(subjectPoint.x, subjectPoint.y, CONTENT_WIDTH, requiredSize.height);
    [issueWrapper.issueSubject drawInRect:infoRectangle withFont:issueInfoFont lineBreakMode:UILineBreakModeWordWrap];
        
    // Draw the description
    
    // Because the subject may take multiple lines, we can only allocate so much space for the description.  The point we will draw at will be right below the last line of the subject.
    // Create the drawing point for the rectangle that will hold the content. Add 6 pixels for buffer so the text isn't on top of each other.
    descriptionPoint = CGPointMake(LEFT_OFFSET, requiredSize.height + VERTICAL_OFFSET);
    
    // Figure out how much space is left for the description.
    CGSize remainingSize = CGSizeMake(CONTENT_WIDTH, requiredSize.height + DESCRIPTION_OFFSET);   
    CGSize requiredSizeForDescription = [issueWrapper.issueDescription sizeWithFont:issueDescriptionFont constrainedToSize:remainingSize lineBreakMode:UILineBreakModeTailTruncation];
    
    // Draw the rectangle to hold the text for the description.  This rectangle's height will be the height of the left over space. 
    CGRect descriptionRectangle = CGRectMake(descriptionPoint.x, descriptionPoint.y, CONTENT_WIDTH, requiredSizeForDescription.height);
    [issueWrapper.issueDescription drawInRect:descriptionRectangle withFont:issueDescriptionFont lineBreakMode:UILineBreakModeTailTruncation];
    
}

 
- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

@end
