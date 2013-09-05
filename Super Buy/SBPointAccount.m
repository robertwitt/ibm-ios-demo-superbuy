//
//  SBPointAccount.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPointAccount.h"


@implementation SBPointAccount

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse JSON data
    NSDictionary *generalData = [jsonData objectForKey:@"General"];
    _ID = [generalData objectForKey:@"Id"];
    _pointType = [generalData objectForKey:@"PointType"];
    _pointTypeText = [generalData objectForKey:@"PointTypeText"];
    _pointsEarned = [generalData objectForKey:@"PointsEarned"];
    _pointsConsumed = [generalData objectForKey:@"PointsConsumed"];
    _pointsExpired = [generalData objectForKey:@"PointsExpired"];
    _pointBalance = [generalData objectForKey:@"PointBalance"];
    _lastTransactionDate = [self dateFromString:[generalData objectForKey:@"LastTxnDate"]];
    _membershipID = [generalData objectForKey:@"MembershipId"];
    _memberID = [generalData objectForKey:@"MemberId"];
    
    // Parse point transactions
    NSMutableArray *transactions = [NSMutableArray array];
    id txnData = [[jsonData objectForKey:@"Transactions"] objectForKey:@"item"];
    
    if ([txnData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *txnDate in txnData) {
            SBPointTransaction *transaction = [[SBPointTransaction alloc] initWithJsonData:txnDate header:self];
            [transactions addObject:transaction];
        }
    } else {
        SBPointTransaction *transaction = [[SBPointTransaction alloc] initWithJsonData:txnData header:self];
        [transactions addObject:transaction];
    }
    _transactions = transactions;
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Point account %@", self.ID];
}

- (BOOL)isEqual:(id)object
{
    return [self.ID isEqualToString:[object ID]];
}

@end
