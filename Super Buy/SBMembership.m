//
//  SBMembership.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembership.h"


@implementation SBMembership

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse JSON data
    NSDictionary *generalData = [jsonData objectForKey:@"General"];
    _ID = [generalData objectForKey:@"Id"];
    _type = [generalData objectForKey:@"Type"];
    _typeText = [generalData objectForKey:@"TypeText"];
    _memberID = [generalData objectForKey:@"MemberId"];
    _startDate = [self dateFromString:[generalData objectForKey:@"StartDate"]];
    _endDate = [self dateFromString:[generalData objectForKey:@"EndDate"]];
    _status = [generalData objectForKey:@"Status"];
    _statusText = [generalData objectForKey:@"StatusText"];
    _loyaltyProgramID = [generalData objectForKey:@"LoyProgID"];
    
    // Parse tiers
    NSMutableArray *tiers = [NSMutableArray array];
    id tierData = [[jsonData objectForKey:@"Tiers"] objectForKey:@"item"];
    
    if ([tierData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *tierDate in tierData) {
            SBMshTier *tier = [[SBMshTier alloc] initWithJsonData:tierDate header:self];
            [tiers addObject:tier];
        }
    } else {
        SBMshTier *tier = [[SBMshTier alloc] initWithJsonData:tierData header:self];
        [tiers addObject:tier];
    }
    _tiers = tiers;
    
    // Point accounts
    NSMutableArray *pointAccounts = [NSMutableArray array];
    id paData = [[jsonData objectForKey:@"PointAccounts"] objectForKey:@"item"];
    
    if ([paData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *paDate in paData) {
            SBMshPointAccount *pointAccount = [[SBMshPointAccount alloc] initWithJsonData:paDate header:self];
            [pointAccounts addObject:pointAccount];
        }
    } else {
        SBMshPointAccount *pointAccount = [[SBMshPointAccount alloc] initWithJsonData:paData header:self];
        [pointAccounts addObject:pointAccount];
    }
    _pointAccounts = pointAccounts;
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.typeText, self.ID];
}

- (BOOL)isEqual:(id)object
{
    return [self.ID isEqualToString:[object ID]];
}

@end
