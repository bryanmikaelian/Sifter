//
//  Project.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "APIBase.h"

@interface Project : NSObject {

}

+ (NSMutableArray *) getAllProjectsFromSifter;

@end
