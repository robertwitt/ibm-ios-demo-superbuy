//
//  SBMshPointAccount.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMshPointAccount.h"


@implementation SBMshPointAccount

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse JSON data
    _ID = [jsonData objectForKey:@"Id"];
    _pointType = [jsonData objectForKey:@"PointType"];
    _pointTypeText = [jsonData objectForKey:@"PointTypeText"];
    _pointBalance = [jsonData objectForKey:@"PointBalance"];
    _lastTransactionDate = [self dateFromString:@"LastTxnDate"];
    
    self.membership = (SBMembership *)header;
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Point account %@ (%@)", self.ID, self.pointTypeText];
}

- (BOOL)isEqual:(id)object
{
    return [self.ID isEqualToString:[object ID]];
}

@end
