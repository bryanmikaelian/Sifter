//
//  MyClass.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Issue.h"

@implementation Issue

+ (NSMutableArray *) getIssuesWithAGivenURL:(NSString *) url {
    
    // Make a request against Sifter's api for the issues for a given url.  We only want Open and Reopened issues, so append the query string s=1-2.  Appending is based on if a request for all the project
    // issues was made or just the issues for a given milestone.
    
    // Store the issues in .json format
    NSData *sifterIssuesJSON = nil;
    
    if ([url rangeOfString:@"?m="].location == NSNotFound) {
        // Milestones are not present in the URL request
        sifterIssuesJSON = [APIBase makeRequestAgainstSifterAPIWithURL:[url stringByAppendingString:@"?s=1-2"]];
    }
    else {
        sifterIssuesJSON = [APIBase makeRequestAgainstSifterAPIWithURL:[url stringByAppendingString:@"&s=1-2"]];        
    }

    NSDictionary *parsedIssues = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterIssuesJSON error:nil];
    
    // Store the issues
    NSMutableArray *issues = [[[NSMutableArray alloc] init] autorelease];    
    
    // Figure out how many pages we have
    int numberOfPages = [[parsedIssues valueForKey:@"total_pages"]integerValue];
    
    
    // If we have more than 1 page, get the issues for each page and add it to the array of issues
    if (numberOfPages > 1) {
        
        // We will need to store the URL for the next page.
        NSString *nextPageURL = nil;
        
        // Add page one's issues to the array
        [issues addObjectsFromArray:[[parsedIssues valueForKey:@"issues"] allObjects]];
        
        // Store the URL for the next page
        nextPageURL = [parsedIssues valueForKey:@"next_page_url"];
        
        // Repeat for each page
        for (int x = 1; x <= numberOfPages; x++) {
            // Make the request
            sifterIssuesJSON = [APIBase makeRequestAgainstSifterAPIWithURL:nextPageURL];
            
            // Parse the issues
            parsedIssues = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterIssuesJSON error:nil];
            
            // Add the issues to the array
            [issues addObjectsFromArray:[[parsedIssues valueForKey:@"issues"] allObjects]];
            
            // Store the URL for the next page
            nextPageURL = [parsedIssues valueForKey:@"next_page_url"];
        }
    }
    
    // We just have one page
    else {
        [issues addObjectsFromArray:[[parsedIssues valueForKey:@"issues"] allObjects]];
    }
    
    // Return the issues
    return issues;
    
}

+ (NSMutableArray *) getIssueCommentsWithAGivenURL:(NSString *)url {
    // Store the issue comments
    NSData *sifterIssueCommentsJSON = nil;
    
    sifterIssueCommentsJSON = [APIBase makeRequestAgainstSifterAPIWithURL:url];
    NSDictionary *parsedIssueComments = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterIssueCommentsJSON error:nil];
    
    // Store the issue comments
    NSMutableArray *issueComments = [[[NSMutableArray alloc] init] autorelease]; 
    
    [issueComments addObjectsFromArray:[[[parsedIssueComments valueForKey:@"issue"] valueForKey:@"comments"] allObjects]];
    
    return issueComments;
}

@end