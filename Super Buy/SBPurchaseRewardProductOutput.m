//
//  SBPurchaseRewardProductOutput.m
//  Super Buy
//
//  Created by Robert Witt on 08.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPurchaseRewardProductOutput.h"


@implementation SBPurchaseRewardProductOutput

- (id)initWithJsonData:(NSDictionary *)jsonData
{
    self = [self init];
    
    _activity = [[SBMemberActivity alloc] initWithJsonData:[jsonData objectForKey:@"MemberActivity"]];
    _messages = [[SBMessageArray alloc] initWithJsonData:[jsonData objectForKey:@"Messages"]];
    
    // Parse point transactions
    NSMutableArray *transactions = [NSMutableArray array];
    id txnData = [jsonData objectForKey:@"PointTransactions"];
    
    if (txnData && ![txnData isKindOfClass:[NSString class]]) {
        txnData = [[jsonData objectForKey:@"PointTransactions"] objectForKey:@"item"];
        
        if ([txnData isKindOfClass:[NSArray class]]) {
            for (NSDictionary *txnDate in txnData) {
                SBPointTransaction *transaction = [[SBPointTransaction alloc] initWithJsonData:txnDate];
                [transactions addObject:transaction];
            }
        } else {
            SBPointTransaction *transaction = [[SBPointTransaction alloc] initWithJsonData:txnData];
            [transactions addObject:transaction];
        }
    }
    
    _transactions = transactions;
    
    return self;
}

@end
