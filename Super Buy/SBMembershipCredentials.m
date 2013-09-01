//
//  SBMembershipCredentials.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipCredentials.h"


@implementation SBMembershipCredentials

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    
    self.memberID = [aDecoder decodeObjectForKey:@"memberID"];
    self.membershipID = [aDecoder decodeObjectForKey:@"membershipID"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.memberID forKey:@"memberID"];
    [aCoder encodeObject:self.membershipID forKey:@"membershipID"];
}

@end
