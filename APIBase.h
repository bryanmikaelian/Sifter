//
//  APIBase.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIBase : NSObject {
    
}

+ (NSData *) makeRequestAgainstSifterAPIWithURL:(NSString *)url;

@end
