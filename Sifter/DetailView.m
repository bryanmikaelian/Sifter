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
#define CONTENT_WIDTH 285
#define VERTICAL_OFFSET 15
    
#define ISSUE_SUBJECT_FONT_SIZE 16
    
#define ISSUE_CATEGORY_FONT_SIZE 12  
    
#define ISSUE_DESCRIPTION_FONT_SIZE 12
    
    // Points to draw at
    CGPoint subjectDrawPoint, descriptionPoint, categoryPoint;
    
    // Color and font for issue subject
    UIFont *issueSubjectFont = [UIFont boldSystemFontOfSize:ISSUE_SUBJECT_FONT_SIZE];
    UIColor *issueSubjectTextColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    
    // Color and font for the issue description
    UIFont *issueDescriptionFont = [UIFont systemFontOfSize:ISSUE_DESCRIPTION_FONT_SIZE];
    UIColor *issueDescriptionTextColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:0.9];
    
    // Color and font for the issue category
    UIFont *issueCategoryFont = [UIFont systemFontOfSize:ISSUE_CATEGORY_FONT_SIZE];
    UIColor *issueCategoryTextColor = [UIColor grayColor];
    
    //
    // Draw the subject
    //
    [issueSubjectTextColor set];
    
    // Specify the point where we want to place the info
    subjectDrawPoint = CGPointMake(5.0, 0.0);
    
    // Because the subject can be several lines, we will need to figure out the size needed for the height of the rectangle that will hold this text.
    CGSize boundingSizeSubject = CGSizeMake(CONTENT_WIDTH, CGFLOAT_MAX);  // Ideally we want all the space!
    
    // Set the size to be equal to the font, with the constaint set to the bounding size.  Issue subjects can never exceed 200 characters, so three lines would be used at most.
    CGSize requiredSize = [self.issueWrapper.issueSubject sizeWithFont:issueSubjectFont constrainedToSize:boundingSizeSubject lineBreakMode:UILineBreakModeWordWrap];
    
    // Create a rectangle to hold this text.  The height is equal to the required size.
    CGRect infoRectangle = CGRectMake(subjectDrawPoint.x, subjectDrawPoint.y, CONTENT_WIDTH, requiredSize.height);
    [self.issueWrapper.issueSubject drawInRect:infoRectangle withFont:issueSubjectFont lineBreakMode:UILineBreakModeWordWrap];
    
    
    // Draw the category
    [issueCategoryTextColor set];
    categoryPoint = CGPointMake(5.0, requiredSize.height);
    

    // Modified text for the category
    NSString *fancyCategoryText = [@"Category: " stringByAppendingString:self.issueWrapper.issueCategory];
    
    // How much horizontal space do we need?
    CGSize requiredSizeCategory = [fancyCategoryText sizeWithFont:issueCategoryFont];
    
    // Draw the rectangle to hold the text for the category.  This will be right below the last line of the subject.
    CGRect categoryRectangle = CGRectMake(categoryPoint.x, categoryPoint.y, requiredSizeCategory.width, ISSUE_CATEGORY_FONT_SIZE);
    [fancyCategoryText drawInRect:categoryRectangle withFont:issueCategoryFont lineBreakMode:UILineBreakModeTailTruncation];

    //
    // Draw the description
    //
    [issueDescriptionTextColor set];

    // Create the drawing point for the rectangle that will hold the content.
    descriptionPoint = CGPointMake(5.0, categoryRectangle.origin.y + VERTICAL_OFFSET);
    CGSize boundingSizeDescription = CGSizeMake(CONTENT_WIDTH, CGFLOAT_MAX);   
    CGSize requiredSizeForDescription = [self.issueWrapper.issueDescription sizeWithFont:issueDescriptionFont constrainedToSize:boundingSizeDescription lineBreakMode:UILineBreakModeTailTruncation];
    
    // Draw the rectangle to hold the text for the description.  This rectangle's height will be the height of the left over space. 
    CGRect descriptionRectangle = CGRectMake(descriptionPoint.x, descriptionPoint.y, CONTENT_WIDTH, requiredSizeForDescription.height);
    [self.issueWrapper.issueDescription drawInRect:descriptionRectangle withFont:issueDescriptionFont lineBreakMode:UILineBreakModeTailTruncation];
    
}


- (void)dealloc {
    [issueWrapper release];
    [super dealloc];
}

@end
