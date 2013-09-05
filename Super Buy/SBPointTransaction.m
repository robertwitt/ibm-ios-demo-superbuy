//
//  SBPointTransaction.m
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPointTransaction.h"


@implementation SBPointTransaction

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    self.pointAccount = (SBPointAccount *)header;
    
    // Parse JSON data
    _transactionType = [jsonData objectForKey:@"TxnType"];
    _transactionTypeText = [jsonData objectForKey:@"TxnTypeText"];
    _pointType = [jsonData objectForKey:@"PointType"];
    _pointTypeText = [jsonData objectForKey:@"PointTypeText"];
    _points = [jsonData objectForKey:@"Points"];
    _qualificationPoints = [jsonData objectForKey:@"QualPoints"];
    _transactionReason = [jsonData objectForKey:@"TxnReason"];
    _transactionReasonText = [jsonData objectForKey:@"TxnReasonText"];
    _qualificationType = [jsonData objectForKey:@"QualType"];
    _qualificationTypeText = [jsonData objectForKey:@"QualTypeText"];
    _actualPoints = [jsonData objectForKey:@"ActualPoints"];
    _postingDate = [self dateFromTimestamp:[jsonData objectForKey:@"PostingDate"]];
    _expiryDate = [self dateFromString:[jsonData objectForKey:@"ExpiryDate"]];
    _activityID = [jsonData objectForKey:@"ActivityID"];
    _membershipID = [jsonData objectForKey:@"MembershipId"];
    _memberID = [jsonData objectForKey:@"MemberId"];
    
    return self;
}

@end
