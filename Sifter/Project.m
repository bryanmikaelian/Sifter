//
//  Project.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Project.h"


@implementation Project


+ (NSMutableArray *) getAllProjectsFromSifter {
    // Make a request against Sifter for the projects
    NSData *sifterProjectsJSON = [APIBase makeRequestAgainstSifterAPIWithURL:@"https://fellowshiptech.sifterapp.com/api/projects"];
    
    // Parse the JSON for the projects.  This will map to a NSArray with each element being a NSDictionary item
    NSDictionary *parsedProjects = [[CJSONDeserializer deserializer] deserializeAsDictionary:sifterProjectsJSON error:nil];
    NSArray *projects = [[parsedProjects valueForKey:@"projects"] allObjects];
    
    // Return the unarchived projects
    NSMutableArray *unarchivedProjects = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < [projects count]; i++) {
        if(![[[projects objectAtIndex:i] valueForKey:@"archived"] boolValue])
            [unarchivedProjects addObject:[projects objectAtIndex:i]];
    }
    
    return unarchivedProjects;
}

@end
