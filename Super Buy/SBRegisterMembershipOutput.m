//
//  SBRegisterMembershipOutput.m
//  Super Buy
//
//  Created by Robert Witt on 07.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBRegisterMembershipOutput.h"


@implementation SBRegisterMembershipOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _member = [[SBMember alloc] initWithJsonData:[jsonData objectForKey:@"Member"]];
    _membership = [[SBMembership alloc] initWithJsonData:[jsonData objectForKey:@"Membership"]];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    return self;
}

@end
