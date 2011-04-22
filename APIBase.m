//
//  APIBase.m
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APIBase.h"


#define SIFTER_API_KEY  @"1bc768608321972065747ee6530744a0"

@implementation APIBase


+(NSData *) makeRequestAgainstSifterAPIWithURL:(NSString *)url {
    // Build the request from the given URL
    NSMutableURLRequest *sifterAPIRequest = [[NSMutableURLRequest alloc] init];
    [sifterAPIRequest setURL:[[[NSURL alloc] initWithString:url] autorelease]];
    
    // Specify a GET. Add the API Key to the header.
    [sifterAPIRequest setHTTPMethod:@"GET"];
    [sifterAPIRequest addValue:SIFTER_API_KEY forHTTPHeaderField:@"X-Sifter-Token"];
    
    // Make the request
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection  sendSynchronousRequest:sifterAPIRequest returningResponse:&response error:&error];
    [sifterAPIRequest release];
    
    
    // Return the data
    return data;
}


@end
