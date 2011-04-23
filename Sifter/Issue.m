//
//  MyClass.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Issue.h"

@implementation Issue

+ (NSMutableArray *) getMilestoneIssuesWithAGivenURL:(NSString *) url {
    
    // Make a request against Sifter's api for the issues for a given milestone.  We only want Open and Reopened issues, so append the query string s=1-2
    NSData *sifterMilestoneIssuesJSON = [APIBase makeRequestAgainstSifterAPIWithURL:[url stringByAppendingString:@"&s=1-2"]];
    NSDictionary *parsedMilestoneIssues = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterMilestoneIssuesJSON error:nil];
    
    // Store the issues
    NSMutableArray *issues = nil;    
    
    // Figure out how many pages we have
    int numberOfPages = [[parsedMilestoneIssues valueForKey:@"total_pages"]integerValue];
    
    
    // If we have more than 1 page, get the issues for each page and add it to the array of issues
    if (numberOfPages > 1) {
        
        // We will need to store the URL for the next page.
        NSString *nextPageURL = nil;
        
        // Add page one's issues to the array
        [issues addObjectsFromArray:[[parsedMilestoneIssues valueForKey:@"issues"] allObjects]];
        
        // Store the URL for the next page
        nextPageURL = [parsedMilestoneIssues valueForKey:@"next_page_url"];
        
        // Repeat for each page
        for (int x = 1; x <= numberOfPages; x++) {
            // Make the request
            sifterMilestoneIssuesJSON = [APIBase makeRequestAgainstSifterAPIWithURL:nextPageURL];
            
            // Parse the issues
            parsedMilestoneIssues = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterMilestoneIssuesJSON error:nil];
            
            // Add the issues to the array
            [issues addObjectsFromArray:[[parsedMilestoneIssues valueForKey:@"issues"] allObjects]];
            
            // Store the URL for the next page
            nextPageURL = [parsedMilestoneIssues valueForKey:@"next_page_url"];
        }
    }
    
    // We just have one page
    else {
        [issues addObjectsFromArray:[[parsedMilestoneIssues valueForKey:@"issues"] allObjects]];
    }
    
    // Return the issues
    return issues;
    
}

@end