//
//  SBMembershipCredentials.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembershipCredentials.h"


@implementation SBMembershipCredentials

- (BOOL)isEqual:(id)object
{
    return [self.membershipID isEqualToString:[object membershipID]] && [self.memberID isEqualToString:[object memberID]];
}

@end
