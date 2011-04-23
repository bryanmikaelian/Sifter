//
//  MyClass.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "APIBase.h"

@interface Issue : NSObject {
    
}

+ (NSMutableArray *) getIssuesWithAGivenURL:(NSString *) url;

@end
