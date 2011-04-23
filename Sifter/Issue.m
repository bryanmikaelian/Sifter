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
    
    // Make a request against Sifter's api for the issues for a given url.  We only want Open and Reopened issues, so append the query string s=1-2
    NSData *sifterIssuesJSON = [APIBase makeRequestAgainstSifterAPIWithURL:[url stringByAppendingString:@"&s=1-2"]];
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

@end