//
//  Milestone.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "APIBase.h"

@interface Milestone : NSObject {
    
}

+ (NSArray *) getProjectMilestonesWithGivenProjectURL:(NSString *) url;

@end
