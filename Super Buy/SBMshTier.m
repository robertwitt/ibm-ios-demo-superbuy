//
//  SBMshTier.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMshTier.h"
#import "SBMembership.h"


@implementation SBMshTier

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse JSON data
    _tierGroup = [jsonData objectForKey:@"TierGroup"];
    _tierGroupText = [jsonData objectForKey:@"TierGroupText"];
    _tierLevel = [jsonData objectForKey:@"TierLevel"];
    _tierLevelText = [jsonData objectForKey:@"TierLevelText"];
    _startDate = [self dateFromString:[jsonData objectForKey:@"StartDate"]];
    _endDate = [self dateFromString:[jsonData objectForKey:@"EndDate"]];
    _expiryDate = [self dateFromString:[jsonData objectForKey:@"ExpiryDate"]];
    _status = [jsonData objectForKey:@"Status"];
    _statusText = [jsonData objectForKey:@"StatusText"];
    
    self.membership = (SBMembership *)header;
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tier '%@' (membership %@)", self.tierLevelText, self.membership.ID];
}

- (BOOL)isEqual:(id)object
{
    return [self.tierGroup isEqualToString:[object tierGroup]] && [self.tierLevel isEqualToString:[object tierLevel]] && [self.membership isEqual:[object membership]];
}

@end
