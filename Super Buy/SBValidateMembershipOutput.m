//
//  SBValidateMembershipOutput.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBValidateMembershipOutput.h"


@implementation SBValidateMembershipOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _membershipValid = [[jsonData objectForKey:@"MembershipValid"] isEqualToString:@"X"];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    return self;
}

@end
