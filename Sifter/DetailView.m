//
//  DetailView.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailView.h"


@implementation DetailView

@synthesize issueWrapper;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
#define CONTENT_WIDTH 275
#define VERTICAL_OFFSET 10
    
#define ISSUE_SUBJECT_FONT_SIZE 20
    
#define ISSUE_DESCRIPTION_FONT_SIZE 12
    
#define MAX_OFFSET_ISSUE_SUBJECT 440
    
    // Points to draw at
    CGPoint subjectPoint, descriptionPoint;
    
    // Color and font for issue subject
    UIFont *issueSubjectFont = [UIFont boldSystemFontOfSize:ISSUE_SUBJECT_FONT_SIZE];
    UIColor *issueSubjectTextColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    
    // Color and font for the issue description
    UIFont *issueDescriptionFont = [UIFont systemFontOfSize:ISSUE_DESCRIPTION_FONT_SIZE];
    UIColor *issueDescriptionTextColor = [UIColor blackColor];
    
    // Draw the subject
    [issueSubjectTextColor set];
    
    // Specify the point where we want to place the info
    subjectPoint = CGPointMake(5.0, 0.0);
    
    // Because the subject can be several lines, we will need to figure out the size needed for the height of the rectangle that will hold this text.
    CGSize boundingSize = CGSizeMake(CONTENT_WIDTH, CGFLOAT_MAX);  // Ideally we want all the space!
    
    // Set the size to be equal to the font, with the constaint set to the bounding size.  Issue subjects can never exceed 200 characters, so three lines would be used at most.
    CGSize requiredSize = [self.issueWrapper.issueSubject sizeWithFont:issueSubjectFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
    
    // Create a rectangle to hold this text.  The height is equal to the required size.
    CGRect infoRectangle = CGRectMake(subjectPoint.x, subjectPoint.y, CONTENT_WIDTH, requiredSize.height);
    [self.issueWrapper.issueSubject drawInRect:infoRectangle withFont:issueSubjectFont lineBreakMode:UILineBreakModeWordWrap];
    
    // Draw the description
    [issueDescriptionTextColor set];
    
    // Because the subject may take multiple lines, we can only allocate so much space for the description.  The point we will draw at will be right below the last line of the subject.
    // Create the drawing point for the rectangle that will hold the content. Add 6 pixels for buffer so the text isn't on top of each other.
    descriptionPoint = CGPointMake(5.0, requiredSize.height + VERTICAL_OFFSET);
    
    // Figure out how much space is left for the description.
    CGSize remainingSize = CGSizeMake(CONTENT_WIDTH, MAX_OFFSET_ISSUE_SUBJECT - requiredSize.height);   
    CGSize requiredSizeForDescription = [self.issueWrapper.issueDescription sizeWithFont:issueDescriptionFont constrainedToSize:remainingSize lineBreakMode:UILineBreakModeTailTruncation];
    
    // Draw the rectangle to hold the text for the description.  This rectangle's height will be the height of the left over space. 
    CGRect descriptionRectangle = CGRectMake(descriptionPoint.x, descriptionPoint.y, CONTENT_WIDTH, requiredSizeForDescription.height);
    [self.issueWrapper.issueDescription drawInRect:descriptionRectangle withFont:issueDescriptionFont lineBreakMode:UILineBreakModeTailTruncation];
    
}


- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

@end