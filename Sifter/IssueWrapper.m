//
//  IssueWrapper.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IssueWrapper.h"


@implementation IssueWrapper

@synthesize issueSubject;
@synthesize issueNumber;
@synthesize issueDescription;
@synthesize issueURL;
@synthesize issueStatus;

- (IssueWrapper*)initWithIssue:(NSDictionary *)issue {
    if((self = [super init])) {
        // Create an issue wrapper.  Add the following values of the issue as properties of this wrapper.  We can add more properties as needed.
        self.issueSubject = [issue valueForKey:@"subject"];
        self.issueNumber = [[issue valueForKey:@"number"] stringValue];
        self.issueDescription = [issue valueForKey:@"description"];
        self.issueURL = [issue valueForKey:@"api_url"];
        self.issueStatus = [issue valueForKey:@"status"];
        NSLog(@"Blah");
    }
    
    return self;
}

- (void)dealloc {
    [issueSubject release];
    [issueNumber release];
    [issueDescription release];
    [issueURL release];
    [super dealloc];
}

@end
