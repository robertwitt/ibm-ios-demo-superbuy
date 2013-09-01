//
//  SBGetMembershipOutput.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBGetMembershipOutput.h"


@implementation SBGetMembershipOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _membership = [[SBMembership alloc] initWithJsonData:[jsonData objectForKey:@"Membership"]];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    return self;
}

@end
