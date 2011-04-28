//
//  IssueWrapper.h
//  Sifter
//
//  Created by Bryan Mikaelian on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IssueWrapper : NSObject {
    NSString *issueNumber;
    NSString *issueSubject;
    NSString *issueDescription;
    NSString *issueURL;
    NSString *issueStatus;
    NSString *issueCategory;
    NSArray *issueComments;
}

@property (nonatomic, retain) NSString *issueNumber;
@property (nonatomic, retain) NSString *issueSubject;
@property (nonatomic, retain) NSString *issueDescription;
@property (nonatomic, retain) NSString *issueURL;
@property (nonatomic, retain) NSString *issueStatus;
@property (nonatomic, retain) NSString *issueCategory;
@property (nonatomic, retain) NSArray *issueComments;

- (IssueWrapper*) initWithIssue:(NSDictionary *)issue;

@end
