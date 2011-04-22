//
//  Milestone.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Milestone.h"


@implementation Milestone


+ (NSArray *) getProjectMilestonesWithGivenProjectURL:(NSString *) url {
    // Make a request against Sifter for the milsetones for a given project
    NSData *sifterMilestonsJSON = [APIBase makeRequestAgainstSifterAPIWithURL:url];
    
    // Parse the JSON for the milestones.  This will map to a NSArray with each element being a NSDictionary item
    NSDictionary *parsedMilestones = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterMilestonsJSON error:nil];
    NSArray *milestones = [[parsedMilestones valueForKey:@"milestones"] allObjects];
    
    // Reverse the order to sort by created date
    milestones = [[milestones reverseObjectEnumerator] allObjects];
    
    // Return the milestones
    return milestones;
}

@end
