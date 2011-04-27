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
@synthesize highlighted;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlight {
    if(highlighted != highlight) {
        highlighted = highlight;
        [self setNeedsDisplay];
    }
}

- (void)setIssueWrapper:(IssueWrapper *)newIssueWrapper {
	
	// Update the issue wrapper if it changes.  
	if (issueWrapper != newIssueWrapper) {
		[issueWrapper release];
		issueWrapper = [newIssueWrapper retain];
	}
    
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
#define LEFT_OFFSET 60
#define CONTENT_WIDTH 240
#define VERTICAL_OFFSET 6
    
#define ISSUE_SUBJECT_FONT_SIZE 14
#define ISSUE_DESCRIPTION_FONT_SIZE 12
    
#define ISSUE_NUMBER_FONT_SIZE 14
    
#define MAX_OFFSET_ISSUE_SUBJECT 64 // = (Max Number of Lines for Issue Info * issueInfoFontSize) + VERTICAL_OFFSET * 2, specifically (3 * 14) + (6 * 2)
    
    // Points to draw at
    CGPoint subjectPoint, descriptionPoint, issuePoint;
    
    // Color and font for the issue subject and number
    UIFont *issueInfoFont = [UIFont boldSystemFontOfSize:ISSUE_SUBJECT_FONT_SIZE];
    UIColor *issueInfoTextColor = nil;
    
    // Color and font for the issue description
    UIFont *issueDescriptionFont = [UIFont systemFontOfSize:ISSUE_DESCRIPTION_FONT_SIZE];
    UIColor *issueDescriptionTextColor = nil;
    
    // Color and font for the issue number
    UIFont *issueNumberFont = [UIFont boldSystemFontOfSize:ISSUE_NUMBER_FONT_SIZE];
    UIColor *issueNumberTextColor = nil;
    
    
    // Configure the colors for the cell
    if (self.highlighted) {
        issueInfoTextColor = [UIColor whiteColor];
        issueDescriptionTextColor = [UIColor whiteColor];
        issueNumberTextColor = [UIColor whiteColor];
    }
    else {
        issueInfoTextColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
        issueDescriptionTextColor = [UIColor darkGrayColor];
        issueNumberTextColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    // Draw the subject
    [issueInfoTextColor set];
    
    // Specify the point where we want to place the info
    subjectPoint = CGPointMake(LEFT_OFFSET, VERTICAL_OFFSET);
    
    // Because the subject can be several lines, we will need to figure out the size needed for the height of the rectangle that will hold this text.
    CGSize boundingSize = CGSizeMake(CONTENT_WIDTH, CGFLOAT_MAX);  // Ideally we want all the space!
    
    // Set the size to be equal to the font, with the constaint set to the bounding size.  Issue subjects can never exceed 200 characters, so three lines would be used at most.
    CGSize requiredSize = [self.issueWrapper.issueSubject sizeWithFont:issueInfoFont constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];

    // Create a rectangle to hold this text.  The height is equal to the required size.
    CGRect infoRectangle = CGRectMake(subjectPoint.x, subjectPoint.y, CONTENT_WIDTH, requiredSize.height);
    [self.issueWrapper.issueSubject drawInRect:infoRectangle withFont:issueInfoFont lineBreakMode:UILineBreakModeWordWrap];
        
    // Draw the description
    [issueDescriptionTextColor set];
    
    // Because the subject may take multiple lines, we can only allocate so much space for the description.  The point we will draw at will be right below the last line of the subject.
    // Create the drawing point for the rectangle that will hold the content. Add 6 pixels for buffer so the text isn't on top of each other.
    descriptionPoint = CGPointMake(LEFT_OFFSET, requiredSize.height + VERTICAL_OFFSET);
    
    // Figure out how much space is left for the description.
    CGSize remainingSize = CGSizeMake(CONTENT_WIDTH, MAX_OFFSET_ISSUE_SUBJECT - requiredSize.height);   
    CGSize requiredSizeForDescription = [self.issueWrapper.issueDescription sizeWithFont:issueDescriptionFont constrainedToSize:remainingSize lineBreakMode:UILineBreakModeTailTruncation];
    
    // Draw the rectangle to hold the text for the description.  This rectangle's height will be the height of the left over space. 
    CGRect descriptionRectangle = CGRectMake(descriptionPoint.x, descriptionPoint.y, CONTENT_WIDTH, requiredSizeForDescription.height);
    [self.issueWrapper.issueDescription drawInRect:descriptionRectangle withFont:issueDescriptionFont lineBreakMode:UILineBreakModeTailTruncation];
    
    // Draw the number
    [issueNumberTextColor set];
    issuePoint = CGPointMake(10, 25);
    
    // Append an octothorpe to the front
    NSString *fancyIssueNumber = [@"#" stringByAppendingString:self.issueWrapper.issueNumber];
    
    [fancyIssueNumber drawAtPoint:issuePoint withFont:issueNumberFont];
    
    
    
}

 
- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

@end
